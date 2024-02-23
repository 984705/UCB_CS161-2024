#include <stdio.h>
#include <string.h>

#define BUFLEN 16

/* Hint: No memory safety errors in this function */
int nibble_to_int(char nibble) {
    if ('0' <= nibble && nibble <= '9') {
        return nibble - '0';
    } else {
        return nibble - 'a' + 10;
    } 
}

void dehexify(void) {
    struct {
        char answer[BUFLEN];
        char buffer[BUFLEN];
    } c;
    int i = 0, j = 0;

    gets(c.buffer);

    while (c.buffer[i]) {
        if (c.buffer[i] == '\\' && c.buffer[i+1] == 'x') {
            int top_half = nibble_to_int(c.buffer[i+2]);
            int bottom_half = nibble_to_int(c.buffer[i+3]);
            c.answer[j] = top_half << 4 | bottom_half;
            i += 3;
        } else {
            c.answer[j] = c.buffer[i];
        }
        i++; j++;
    }

    c.answer[j] = 0;
    printf("%s\n", c.answer);
    fflush(stdout);
}

int main(void) {
    while (!feof(stdin)) {
        dehexify();
    }
    return 0;
}
