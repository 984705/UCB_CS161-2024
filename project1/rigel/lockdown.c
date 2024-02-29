#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>

/* Hint: No memory safety vulnerabilities in this function. */
int check_noexec(void) {
    int ret;

    pid_t child = fork();
    if (child == 0) {
        /* Child. Try to segfault by executing bytes on the stack. */
        char ret[] = { 0xc3 };
        void (*func_on_stack)(void) = (void (*)(void)) ret;
        func_on_stack();
        exit(0);
    } else {
        /* Parent. Check if the child segfaulted. */
        waitpid(child, &ret, 0);
        if (ret != SIGSEGV) {
            /* If the child didn't segfault, nonexecutable pages failed. */
            return 1;
        }
    }

    printf("NX passed    : exit code  = %d\n", ret);
    return 0;
}

/* Hint: No memory safety vulnerabilities in this function. */
void overwrite_canary(uint32_t *canary) {
    uint32_t *addr;
    __asm__ ("mov %%esp, %0" : "=r"(addr) :: ); /* Get value of ESP. */
    while ((void *) addr < __builtin_frame_address(0)) {
        addr++;
        if (*addr == *canary) {
            *addr = 0xdeadbeef;
            break;
        }
    }
}

/* Hint: No memory safety vulnerabilities in this function. */
int check_canary(void) {
    int ret;
    uint32_t canary;
    pid_t child;

    __asm__ ("mov %%gs:0x14, %0" : "=r"(canary) :: ); /* Get value of canary. */

    child = fork();
    if (child == 0) {
        /* Child. Try to segfualt by overwriting the stack canary. */
        overwrite_canary(&canary);
        exit(0);
    } else {
        /* Parent. Check if the child segfaulted. */
        waitpid(child, &ret, 0);
        if (ret != SIGSEGV) {
            /* If the child didn't segfault, stack canaries aren't enabled. */
            return 1;
        }
    }

    printf("Canary passed: canary val = 0x%08x\n", canary);
    return 0;
}

/* Hint: No memory safety vulnerabilities in this function. */
int check_aslr(void) {
    int aslr = (printf != (void *) 0xf7fb00ec);
    if (!aslr) {
        return 1;
    }
    printf("ASLR passed  : printf located at 0x%08x\n", (uintptr_t) printf);
    return 0;
}

int secure_gets(int *err_ptr) {
    char buf[256];
    int ret;

    /* Check all mitigations are enabled. */
    ret = check_noexec();
    if (ret) {
        printf("Non-executable pages check failed!\n");
        *err_ptr = 1;
    }
    ret = check_canary();
    if (ret) {
        printf("Canary check failed!\n");
        *err_ptr = 1;
    }
    ret = check_aslr();
    if (ret) {
        printf("ASLR check failed!\n");
        *err_ptr = 1;
    }
    if (*err_ptr) {
        printf("One or more mitigation(s) has failed! Proceed with caution...\n");
    }
    fflush(stdout);

    gets(buf);
    printf("%s\n", buf);

    return 0;
}

int main(int argc, char **argv) {
    /* Hint: You don't need to worry about this line of code. */
    setregid(getegid(), -1);

    int err = 0;
    int *err_ptr = &err;

    secure_gets(err_ptr);

    return err;
}
