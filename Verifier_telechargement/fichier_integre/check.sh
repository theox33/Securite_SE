#!/bin/bash
# verify_openssl.sh — Verify integrity of OpenSSL tarball using its SHA256 checksum

# Stop on errors
set -e

# File names (you can modify these if needed)
TARBALL="openssl-3.6.0.tar.gz"
SHAFILE="openssl-3.6.0.tar.gz.sha256"

echo "🔍 Verifying $TARBALL using $SHAFILE ..."

# Check if files exist
if [[ ! -f "$TARBALL" ]]; then
    echo "❌ Error: $TARBALL not found!"
    exit 1
fi

if [[ ! -f "$SHAFILE" ]]; then
    echo "❌ Error: $SHAFILE not found!"
    exit 1
fi

# Run verification
if sha256sum -c "$SHAFILE"; then
    echo "✅ Integrity check passed — $TARBALL is valid."
else
    echo "❌ Integrity check FAILED — file may be corrupted or tampered with!"
    exit 1
fi
