# Protection_AES

Exemple simple pour chiffrer/déchiffrer un fichier avec OpenSSL (AES-256-CBC).

Fichiers fournis:
- `hello.txt` : message en clair d'exemple.
- `encrypt.sh` : script bash pour chiffrer avec une clé hex et IV hex.
- `decrypt.sh` : script bash pour déchiffrer.

Important sur la commande initiale fournie:
La commande que vous avez écrite contient des tirets longs et une clé/IV trop courtes pour AES-256. Exemple corrigé :

  openssl enc -aes-256-cbc -in hello.txt -out hello.enc -K <clé_hex_64_chars> -iv <iv_hex_32_chars>

Notes:
- `-K` attend la clé en hex (pour AES-256, 32 octets => 64 caractères hex).
- `-iv` attend l'IV en hex (pour AES-CBC, 16 octets => 32 caractères hex).
- Si vous ne fournissez pas `-K` ni `-iv`, OpenSSL vous demandera un mot de passe et dérivera la clé/iv (via EVP_BytesToKey) — plus simple mais moins contrôlable pour des tests.

Exemples d'utilisation:

1) Générer une clé et un IV aléatoires (bash):

```bash
# clé 256 bits (32 bytes -> 64 hex chars)
HEXKEY=$(openssl rand -hex 32)
# iv 128 bits (16 bytes -> 32 hex chars)
HEXIV=$(openssl rand -hex 16)

echo "Key: $HEXKEY"
echo "IV:  $HEXIV"
```

2) Chiffrer:

```bash
./encrypt.sh hello.txt hello.enc "$HEXKEY" "$HEXIV"
```

3) Déchiffrer:

```bash
./decrypt.sh hello.enc hello.dec.txt "$HEXKEY" "$HEXIV"
```

4) Afficher l'aide de la commande enc:

```bash
man enc
```

Vérification:

Après déchiffrement, `hello.dec.txt` doit être identique à `hello.txt`.

Sécurité:
- Ne réutilisez jamais la même paire (clé, IV) pour chiffrer plusieurs messages en mode CBC.
- Pour un usage réel, préférez AES-GCM (authenticated encryption). Le format et la gestion des clés doivent être robustes.
