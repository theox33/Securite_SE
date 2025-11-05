cd /home/theo/E5e/Securite_SE/Protection en authenticité
# écrire le message
printf 'Bonjour, ceci est un message a signer.\n' > hello.txt

# générer une clé privée RSA 2048 bits
openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048

# extraire la clé publique
openssl rsa -in private.key -pubout -out public.key

# signer le fichier (pkeyutl -sign)
openssl pkeyutl -sign -in hello.txt -inkey private.key -out hello.sig

# vérifier la signature (utiliser -pubin pour indiquer que -inkey est une clé publique)
openssl pkeyutl -verify -in hello.txt -pubin -inkey public.key -sigfile hello.sig