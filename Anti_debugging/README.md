# Exercice 1 — Anti-debugging sous Linux

## Objectif

- Écrire un programme C minimal qui affiche "Hello, world!".
- Exécuter ce programme sous GDB et observer le comportement avec un point d'arrêt sur `main`.
- Ajouter une protection anti-debugging : le programme doit détecter s'il est lancé sous un debugger (GDB) et refuser l'exécution.

## Étapes réalisées

1. **Création du programme Hello World**
   - Fichier `hello.c` :
     ```c
     #include <stdio.h>
     int main(void) {
         printf("Hello, world!\n");
         return 0;
     }
     ```
   - Compilation :
     ```bash
     gcc hello.c -o hello
     ```

2. **Exécution sous GDB**
   - Lancement du debugger :
     ```bash
     gdb ./hello
     (gdb) break main
     (gdb) run
     ```
   - Le programme s'arrête au début de `main`.

3. **Ajout de la détection de debugger**
   - Utilisation de la fonction `ptrace` pour détecter si le programme est tracé.
   - Nouveau code :
     ```c
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
     ```
   - Si le programme est lancé sous GDB, il affiche "Execution interdite" et s'arrête immédiatement.
   - Sinon, il affiche "Hello, world!" normalement.

## Pour le rapport

- Cet exercice illustre une technique simple d'anti-debugging sous Linux.
- La fonction `ptrace` permet de détecter la présence d'un debugger et d'empêcher l'exécution.
- Utile pour protéger certains logiciels contre l'analyse dynamique ou le reverse engineering.

## Résultat attendu

```bash
$ gcc ./hello
$ (gdb) run
Starting program: ./hello 
Downloading separate debug info for system-supplied DSO at 0x7ffff7fc3000
[Thread debugging using libthread_db enabled]                                
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Execution interdite
[Inferior 1 (process 21860) exited with code 01]
```