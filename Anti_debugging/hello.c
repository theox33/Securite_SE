#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>

int main(void) {
    if (ptrace(PTRACE_TRACEME, 0, NULL, 0) == -1) {
        printf("Execution interdite\n");
        exit(1);
    }
    printf("Hello, world!\n");
    return 0;
}
