# Analyse CDS CSPN de l'Outil de Protection et de Signature

## Chapitre 1 : Contexte

### Présentation de l'outil
Le produit Signop Référence 098 345 version 1.0.2 est un outil de signature de logiciel.
Cet outil récupère sur des CD ROM des logiciels de produits embarqués qu’il signe. Les logiciels signés sont ensuite gravés sur des CD-ROM.
La clé de signature est injectée une fois en phase de configuration à travers un CD-ROM.

### Périmètre
On considère le périmètre suivant :
- Poste de signature (OS Linux durci, application de signature Signop).
- Médias amont (CD-ROM source des logiciels à signer).
- Médias aval (CD-ROM des logiciels signés).
- Clé privée de signature (stockée sur le poste de signature).

On exclut du périmètre :
- Le processus de développement du logiciel source.
- Le transport et la distribution des médias aval et amont.
- Les quelconques services de maintenance necessaires.

On considère les éléments suivant :
- l'outil est déployé sur un poste isolé, non connecté à un réseau. 
- L'outils refuse toute forme de communication en dehors des médias amont et aval (hors maintenance).
- Les opérateurs utilisant l'outil sont formés.
- Les médias amont et aval sont fournis par un tiers de confiance.

### Biens et services essentiels

Notation: C=Confidentialité, I=Intégrité, D=Disponibilité, T=Traçabilité, A=Authenticité.

#### Services

| ID  | Bien / Service                | Description                                                                 | Criticité | Besoins principaux |
| --- | ----------------------------- | --------------------------------------------------------------------------- | --------- | ------------------ |
| S1  | Service de signature          | Processus et application réalisant la signature des binaires                | 3/4       | I, D               |
| S2  | Service de gestion des médias | Acceptation, contrôle (scans, hashes) et transfert des médias amont et aval | 3/4       | I, D               |
| S3  | Service de journalisation     | Collecte, protection et conservation des journaux de signature              | 2/4       | I, T, A            |

#### Biens

| ID  | Bien / Service          | Description                          | Criticité | Besoins principaux |
| --- | ----------------------- | ------------------------------------ | --------- | ------------------ |
| B1  | Clé privée de signature | Secret de signature                  | 4/4       | C, I, A            |
| B2  | Logiciel signé          | Binaire final distribué              | 1/4       | I, A               |
| B4  | Journaux de signature   | Preuves et traçabilité               | 2/4       | I, T, A            |
| B5  | Logiciel source entrant | Binaire à signer depuis CD-ROM amont | 3/4       | I, A               |

### Attaquants

| ID  | Attaquant                         | Motivation | Ressources | Activité | Pertinence |
| --- | --------------------------------- | ---------- | ---------- | -------- | ---------- |
| A1  | Externe opportuniste              | ++         | ++         | ++       | Moyenne    |
| A2  | Externe ciblé (sophistiqué)       | +++        | +++        | +++      | Élevé      |
| A3  | Employé malveillant (insider)     | +          | +++        | +        | Faible     |
| A4  | Fournisseur du binaire (provider) | +          | ++         | +        | Faible     |

---

## Chapitre 2 : Événements redoutés

Notation: C=Confidentialité, I=Intégrité, D=Disponibilité, T=Traçabilité, A=Authenticité.

| ER ID | Actif impacté          | Besoin compromis | Description                                     | Impact (1-5) |
| ----- | ---------------------- | ---------------- | ----------------------------------------------- | ------------ |
| ER1   | Clé privée (B1)        | C                | Divulgation de la clé de signature              | 5            |
| ER2   | Clé privée (B1)        | I,A              | Altération/Substitution de la clé               | 5            |
| ER3   | Logiciel signé (B2)    | I,A              | Injection de code malveillant signé             | 5            |
| ER4   | Journaux (B4,S3)       | I,T,A            | Altération ou effacement des logs               | 4            |
| ER5   | Service (B3)           | D                | Indisponibilité du poste/processus de signature | 3            |
| ER6   | Source (B5)            | I                | Altération du binaire avant signature           | 4            |
| ER7   | Fonctionnement (S1,S2) | I,D              | Logiciel inutilisable                           | 2            |

---

## Chapitre 3 : Scénarios de menace

| Scénario | Source     | Vulnérabilité clé                  | Événement redouté | Probabilité |
| -------- | ---------- | ---------------------------------- | ----------------- | ----------- |
| S1       | A3         | Clé accessible sur disque          | ER1               | Moyenne     |
| S2       | A2         | Absence de sécurisation sur la clé | ER1               | Légère      |
| S3       | A3         | Absence de double contrôle         | ER2               | Moyenne     |
| S4       | A4         | Absence de scan des médias         | ER3, ER6          | Haute       |
| S5       | A2         | Logs non protégés                  | ER4               | Légère      |
| S6       | A1, A2, A3 | Manque de redondance               | ER5, ER7          | Moyenne     |

---

## Chapitre 4 : Risques (cotation)

Échelle: Probabilité L(1)/M(2)/H(3); Score = P × Impact.

| Scénario | Probabilité | Impact max | Score | Niveau   |
| -------- | ----------- | ---------- | ----- | -------- |
| S1       | 2           | 5          | 10    | Élevé    |
| S2       | 1           | 5          | 5     | Modéré   |
| S3       | 2           | 5          | 10    | Élevé    |
| S4       | 3           | 5          | 15    | Critique |
| S5       | 1           | 4          | 4     | Modéré   |
| S6       | 2           | 3          | 6     | Modéré   |

Matrice : 

|               | Impact 1 | Impact 2 | Impact 3 | Impact 4 | Impact 5 |
| ------------- | -------- | -------- | -------- | -------- | -------- |
| Probabilité 1 |          |          |          | S5       | S2       |
| Probabilité 2 |          |          | S6       |          | S1, S3   |
| Probabilité 3 |          |          |          |          | S4       |

    
---

## Chapitre 5 : Mesures de sécurité

### Mesures principales (prioritaires)
| Risque | Mesure synthétique                                                         | Type                 |
| ------ | -------------------------------------------------------------------------- | -------------------- |
| S4     | Scan antivirus + vérification hash des médias sources                      | Prévention/Détection |
| S4     | Acceptation sources via liste blanche / signature entrante                 | Prévention           |
| S1     | Stockage clé dans HSM + chiffrement au repos                               | Prévention           |
| S3     | Double contrôle opérateur à l'injection et à la signature                  | Prévention           |
| S6     | Sauvegarde périodique + poste de secours préconfiguré                      | Résilience           |
| S5     | Stockage des logs imuables + extraction et sauvgarde à chaque manipulation | Prévention           |

### Mesures complémentaires
- Whitelisting applicatif; blocage de l'exécution non autorisée (réduit S4 et dérivés).
- Contrôles physiques (scellés, vidéosurveillance) pour accès au poste et aux médias.
- Durcissement OS et mises à jour via médias vérifiés; formation des opérateurs.