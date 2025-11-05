Créer un fichier contenant un message devant être signé.

Protéger ce message à l'aide de l'outil OpenSSL

```bash
openssl pkeyutl -sign -in hello.txt -inkey private.key -out sig
```

Vérifier la signature du message à l'aide de la clé publique.