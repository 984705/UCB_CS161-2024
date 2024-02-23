#include <stdint.h>
#include <stdio.h>
#include <string.h>

void display(const char *path) {
    char msg[128];
    int8_t size;
    FILE *file;
    size_t bytes_read;

    memset(msg, 0, 128);

    file = fopen(path, "r");
    if (!file) {
        perror("fopen");
        return;
    }
    bytes_read = fread(&size, 1, 1, file);
    if (bytes_read == 0 || size > 128) {
        return;
    } 
    bytes_read = fread(msg, 1, size, file);

    puts(msg);
}


int main(int argc, char **argv)
{
    if (argc != 2) {
        return 1;
    } 

    display(argv[1]);
    return 0;
}
