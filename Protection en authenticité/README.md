# Protection en authenticité

Créer un fichier contenant un message devant être signé.

Protéger ce message à l'aide de l'outil OpenSSL

```bash
openssl pkeyutl -sign -in hello.txt -inkey private.key -out sig
```

Vérifier la signature du message à l'aide de la clé publique.

```bash
openssl pkeyutl -verify -in hello.txt -sigfile sig -inkey public.key -pubin
```

Si la signature est valide, le programme ne renvoie aucune sortie et se termine avec un code de retour 0. Si la signature est invalide, il renvoie une erreur et se termine avec un code de retour différent de 0.