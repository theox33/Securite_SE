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

## Cas de signature d'un fichier trop volumineux

Il n'est pas possible de signer directement un fichier volumineux avec `pkeyutl`. La bonne pratique consiste à créer un condensat (hash) du fichier, puis à signer ce condensat.

Créer un hash du fichier à l'aide de SHA-256.

```bash
openssl dgst -sha256 -out hello.hash hello.txt
``` 

Signer le hash.

```bash
openssl pkeyutl -sign -in hello.hash -inkey private.key -out hello.sig
``` 

Envoyer le fichier orignal, et le hash avec sa signature.

Coté destinataire:
Pour vérifier commencer vérifier que le hash reçu est bien signé par l'expéditeur.

```bash
openssl pkeyutl -verify -in hello.hash -sigfile hello.sig -inkey public.key -pubin
``` 

Si la signature est valide, on peut alors recalculer le hash du fichier reçu et le comparer avec le hash reçu.

```bash
openssl dgst -sha256 -out hello_rec.hash hello.txt
```
Comparer les deux hash.

```bash
diff hello.hash hello_rec.hash
```
Si les deux hash sont identiques, le fichier n'a pas été modifié.


