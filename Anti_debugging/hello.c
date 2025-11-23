// Simple anti-debugging demo with cross-platform ptrace usage.
// On Linux: use PTRACE_TRACEME to indicate the process is being traced (self),
// which some debuggers can't attach to afterwards.
// On macOS: use PT_DENY_ATTACH to prevent a debugger from attaching.

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/ptrace.h>

int main(void) {
#if defined(__APPLE__)
    // Deny future debugger attachments on macOS.
    if (ptrace(PT_DENY_ATTACH, 0, 0, 0) == -1) {
        // If already being debugged, this will fail.
        fprintf(stderr, "Execution interdite (debugger détecté ou attach impossible)\n");
        return 1;
    }
#elif defined(__linux__)
    // Request to be traced (self); debuggers typically can't attach afterwards.
    if (ptrace(PTRACE_TRACEME, 0, NULL, 0) == -1) {
        fprintf(stderr, "Execution interdite (ptrace échec)\n");
        return 1;
    }
#else
    fprintf(stderr, "Plateforme non supportée pour cette démonstration.\n");
    return 1;
#endif

    printf("Hello, world!\n");
    return 0;
}
