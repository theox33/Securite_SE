/*
 * Programme console C pour vérifier un mot de passe hex (max 8 caractères).
 * Comportement :
 * - Demande le mot de passe (entrée masquée)
 * - Le mot de passe correct est "CAFECAFE"
 * - Après 3 échecs, impose une temporisation de 10 minutes entre chaque nouvel essai
 * - Affiche "MDP OK" si correct, sinon "MDP KO"
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <termios.h>
#include <unistd.h>

static void read_password(char *buf, size_t bufsz, const char *prompt) {
    struct termios oldt, newt;
    printf("%s", prompt);
    fflush(stdout);

    /* Disable echo */
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    if (fgets(buf, (int)bufsz, stdin) == NULL) {
        buf[0] = '\0';
    }

    /* Restore terminal */
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    putchar('\n');

    /* Strip newline */
    size_t len = strlen(buf);
    if (len && buf[len-1] == '\n') buf[len-1] = '\0';
}

static int is_hex_string(const char *s) {
    if (!s) return 0;
    if (*s == '\0') return 0; /* empty not allowed */
    for (; *s; ++s) {
        if (!isxdigit((unsigned char)*s)) return 0;
    }
    return 1;
}

int main(void) {
    const char CORRECT[] = "CAFECAFE"; /* Mot de passe correct */
    const size_t MAXLEN = 8;
    const int LOCK_THRESHOLD = 3;
    const int LOCK_SECONDS = 10 * 60; /* 10 minutes */

    char pwd[64];
    int failures = 0;
    time_t last_attempt = 0; /* time of last attempt once locked */

    while (1) {
        time_t now = time(NULL);
        if (failures >= LOCK_THRESHOLD) {
            if (last_attempt == 0) last_attempt = now; /* initialize on first lock */
            time_t next_allowed = last_attempt + LOCK_SECONDS;
            if (now < next_allowed) {
                int remaining = (int)(next_allowed - now);
                int mn = remaining / 60;
                int sec = remaining % 60;

                printf("Trop d'echecs (%d). Nouvel essai possible dans %d minute(s) %d seconde(s).\n", failures, mn, sec);
                /* Sleep short time to avoid busy loop; wake to re-evaluate */
                sleep(1);
                continue;
            }
            /* allow one attempt now */
        }

        read_password(pwd, sizeof(pwd), "Entrez le mot de passe (hexa, max 8): ");

        /* Basic validation */
        size_t len = strlen(pwd);
        if (len == 0 || len > MAXLEN || !is_hex_string(pwd)) {
            printf("MDP KO\n");
            failures++;
            if (failures >= LOCK_THRESHOLD) last_attempt = time(NULL);
            continue;
        }

        /* Normalize to uppercase for comparison */
        char normalized[64];
        for (size_t i = 0; i < len; ++i) normalized[i] = (char)toupper((unsigned char)pwd[i]);
        normalized[len] = '\0';

        if (strcmp(normalized, CORRECT) == 0) {
            printf("MDP OK\n");
            return 0;
        } else {
            printf("MDP KO\n");
            failures++;
            if (failures >= LOCK_THRESHOLD) last_attempt = time(NULL);
            /* If locked, the code will require waiting LOCK_SECONDS from last_attempt */
        }
    }

    return 0;
}
