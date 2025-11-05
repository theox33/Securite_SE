# Sécurité SE - Exercices de cours

Ce dépôt GitHub regroupe tous les petits exercices proposés par le professeur en cours de Sécurité des Systèmes d'Exploitation. Chaque exercice est accompagné de consignes détaillées, d'explications et de code fonctionnel.

## 📚 Structure du dépôt

Le dépôt est organisé en plusieurs répertoires, chacun correspondant à un exercice spécifique :

### 🔐 Protection_AES
Exercice sur le chiffrement et déchiffrement de fichiers avec OpenSSL en utilisant l'algorithme AES-256-CBC.

**Contenu :**
- Scripts de chiffrement et déchiffrement (`encrypt.sh`, `decrypt.sh`)
- Exemples de fichiers texte
- Documentation détaillée sur l'utilisation d'OpenSSL pour la protection par chiffrement symétrique

**Points clés :**
- Génération de clés et vecteurs d'initialisation (IV) aléatoires
- Utilisation correcte de la commande `openssl enc`
- Bonnes pratiques de sécurité (non-réutilisation des paires clé/IV)

### ✍️ Protection en authenticité
Exercice sur la signature numérique de messages avec OpenSSL.

**Contenu :**
- Scripts de génération de signatures
- Paires de clés publique/privée
- Exemples de messages signés

**Objectifs :**
- Créer une signature numérique d'un message
- Vérifier l'authenticité d'un message à l'aide de la clé publique
- Comprendre la cryptographie asymétrique

### 🔍 Verifier_telechargement
Exercice sur la vérification de l'intégrité et de l'authenticité des téléchargements.

**Sous-répertoires :**
- `fichier_integre/` : Vérification d'intégrité avec SHA-256
- `fichier_modifie/` : Détection de modifications

**Contenu :**
- Scripts de vérification (`check.sh`)
- Documentation sur l'utilisation de `sha256sum`
- Distinction entre intégrité (SHA-256) et authenticité (signatures PGP)

### 🔑 mdp secure
Programme C pour la vérification de mots de passe hexadécimaux avec protection contre les attaques par force brute.

**Contenu :**
- Code source en C (`src/main.c`)
- Makefile pour la compilation
- Programme de vérification de mot de passe avec temporisation

**Fonctionnalités :**
- Saisie masquée du mot de passe
- Validation de format hexadécimal (0-9, A-F, max 8 caractères)
- Protection par temporisation après 3 échecs (10 minutes)
- Mot de passe attendu : `CAFECAFE`

### 🔨 OpenSSL_dgst
Exercice sur les fonctions de hachage cryptographique avec OpenSSL.

**Contenu :**
- Scripts d'utilisation de la commande `openssl dgst`
- Exemples de génération de condensés (hash)

## 🚀 Utilisation

Chaque répertoire contient son propre fichier README.md avec des instructions détaillées pour :
1. Les consignes de l'exercice
2. Les explications théoriques
3. Les exemples d'utilisation
4. Le code fonctionnel

Pour un exercice spécifique, naviguez dans le répertoire correspondant et consultez son README.

## 🛠️ Prérequis

La plupart des exercices nécessitent :
- Un système Linux/Unix (Ubuntu recommandé)
- OpenSSL installé
- Compilateur GCC (pour les exercices en C)
- Bash

## 📖 Apprentissage

Ces exercices couvrent les concepts fondamentaux de la sécurité informatique :
- **Chiffrement symétrique** (AES)
- **Cryptographie asymétrique** (signatures RSA)
- **Fonctions de hachage** (SHA-256)
- **Intégrité et authenticité** des données
- **Protection des mots de passe**
- **Bonnes pratiques de sécurité**

## 📝 Notes

Ce dépôt est à usage pédagogique. Les exemples de code sont volontairement simplifiés pour illustrer les concepts. Pour une utilisation en production, des mesures de sécurité supplémentaires seraient nécessaires.
