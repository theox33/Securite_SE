# Vérificateur de mot de passe hex (console)

Ceci est un petit programme C (console) pour Ubuntu qui demande un mot de passe hexadécimal (max 8 caractères). Il compare la saisie avec la valeur fixe `CAFECAFE`.

Comportement principal :
- Demande le mot de passe (entrée masquée)
- Le mot de passe est constitué de caractères hexadécimaux (0-9, A-F) et sa longueur maximale est 8
- Après 3 échecs, une temporisation de 10 minutes est imposée entre chaque nouvel essai
- Affiche `MDP OK` si le mot de passe est correct, sinon `MDP KO`

Compilation :

```
make
```

Usage :

```
./bin/checkpwd
```

Note : le mot de passe attendu est `CAFECAFE`.
