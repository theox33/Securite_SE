#!/usr/bin/env bash
# Script pour chiffrer un fichier avec OpenSSL AES-256-CBC
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

# Validate lengths
if [[ ${#HEXKEY} -ne 64 ]]; then
  echo "Error: hexkey must be 64 hex characters (32 bytes -> 256 bits)." >&2
  exit 3
fi
if [[ -n "$HEXIV" && ${#HEXIV} -ne 32 ]]; then
  echo "Error: hexiv must be 32 hex characters (16 bytes -> 128 bits)." >&2
  exit 4
fi

# Build openssl command
if [[ -n "$HEXIV" ]]; then
  openssl enc -aes-256-cbc -in "$INFILE" -out "$OUTFILE" -K "$HEXKEY" -iv "$HEXIV"
else
  # If no IV provided, OpenSSL will derive key/iv from a password; but with -K we must provide iv.
  echo "No IV provided. For deterministic encryption with -K you must provide -iv." >&2
  exit 5
fi

echo "Encrypted $INFILE -> $OUTFILE"