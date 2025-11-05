#!/usr/bin/env bash
# make_hello.sh
# Crée hello.txt contenant exactement "Hello world" (sans saut de ligne)
# puis affiche le haché SHA-256 du fichier.
set -euo pipefail

# Écrire le texte sans saut de ligne
printf 'Hello world' > hello.txt

# Calculer et afficher le SHA-256
sha256sum hello.txt
