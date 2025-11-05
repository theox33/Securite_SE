#!/usr/bin/env bash
# Script pour déchiffrer un fichier chiffré avec OpenSSL AES-256-CBC
set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <infile> <outfile> <hexkey> [hexiv]"
  echo "hexkey must be 64 hex chars (256 bits). Optional hexiv must be 32 hex chars (128 bits)."
  exit 2
fi

INFILE="$1"
OUTFILE="$2"
HEXKEY="$3"
HEXIV="${4:-}"

if [[ ${#HEXKEY} -ne 64 ]]; then
  echo "Error: hexkey must be 64 hex characters (32 bytes -> 256 bits)." >&2
  exit 3
fi
if [[ -n "$HEXIV" && ${#HEXIV} -ne 32 ]]; then
  echo "Error: hexiv must be 32 hex characters (16 bytes -> 128 bits)." >&2
  exit 4
fi

if [[ -n "$HEXIV" ]]; then
  openssl enc -d -aes-256-cbc -in "$INFILE" -out "$OUTFILE" -K "$HEXKEY" -iv "$HEXIV"
else
  echo "No IV provided. For deterministic decryption with -K you must provide -iv." >&2
  exit 5
fi

echo "Decrypted $INFILE -> $OUTFILE"