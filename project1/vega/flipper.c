#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void flip(char *buf, const char *input) {
    size_t n = strlen(input);
    int i;
    for (i = 0; i < n && i <= 64; i++) {
        buf[i] = input[i] ^ 0x20;
    }  

    while (i < 64) {
        buf[i++] = '\0';
    } 
}

void invoke(const char *in) {
    char buf[64];
    flip(buf, in);
    puts(buf);
}

void dispatch(const char *in) {
    invoke(in);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        return 1;
    } 

    dispatch(argv[1]);
    return 0;
}
