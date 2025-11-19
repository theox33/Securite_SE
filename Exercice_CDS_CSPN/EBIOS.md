# Analyse de risque EBIOS – Outil de signature Signop  

## Chapitre 1 – Contexte

### 1.1 Périmètre de l’étude

**Objet étudié**

- Produit : **Signop Référence 098 345 – version 1.0.2**
- Rôle : outil de **signature de logiciels embarqués** à partir de CD-ROM.

**Périmètre technique inclus**

- Postes de travail hébergeant le logiciel Signop (matériel, OS, comptes locaux).
- Logiciel **Signop** (binaire, fichiers de configuration, modules de signature).
- **Flux CD-ROM entrants** :
  - CD contenant les logiciels de produits embarqués à signer.
  - CD spécial d’injection de la clé de signature (phase de configuration).
- **Flux CD-ROM sortants** :
  - CD contenant les logiciels signés.
- Stockage de la **clé de signature** dans l’outil après injection.
- Journaux / fichiers de log générés par Signop.
- Réseaux éventuellement connectés au poste Signop (LAN, mises à jour, etc.).

**Hors périmètre direct mais impactés**

- Les systèmes embarqués qui recevront les logiciels signés.
- Les chaînes de production / clients finaux consommant les CD-ROM signés.

---

### 1.2 Valeurs métiers et services essentiels

#### 1.2.1 Valeurs métiers / services

| ID VM | Valeur métier / Service                          | Description                                                                                  | Criticité (1–4) |
|:-----:|--------------------------------------------------|----------------------------------------------------------------------------------------------|:---------------:|
| VM1   | Authenticité des logiciels livrés                | Les logiciels embarqués fournis au client doivent être authentiques et non modifiés.        |        4        |
| VM2   | Intégrité des logiciels signés                   | Les binaires signés doivent être strictement conformes à ceux validés.                      |        4        |
| VM3   | Confidentialité & intégrité de la clé de signature | La clé de signature ne doit jamais être divulguée, copiée ou altérée.                       |        4        |
| VM4   | Disponibilité du processus de signature          | L’outil doit être disponible pour permettre la production industrielle.                     |        3        |
| VM5   | Traçabilité des opérations de signature          | Être capable de prouver qui a signé quoi, quand, avec quelle version.                       |        3        |

#### 1.2.2 Biens supports essentiels

| ID Bien | Bien support                       | Lié à VM                   | Propriétés critiques (D/I/C) | Criticité (1–4) |
|:-------:|------------------------------------|----------------------------|------------------------------|:---------------:|
| B1      | Clé de signature (clé privée)      | VM1, VM2, VM3              | I, C                         |        4        |
| B2      | Logiciels à signer (CD entrants)   | VM1, VM2                   | I                            |        3        |
| B3      | Logiciels signés (CD sortants)     | VM1, VM2                   | I                            |        4        |
| B4      | Poste de travail Signop (matériel + OS) | VM2, VM4               | D, I                         |        3        |
| B5      | Logiciel Signop (binaire, config)  | VM1, VM2, VM4              | I                            |        4        |
| B6      | CD d’injection de la clé           | VM3                        | I, C                         |        4        |
| B7      | Journaux et traces de signature    | VM5                        | I                            |        3        |
| B8      | Procédures / documentation         | VM5                        | I                            |        2        |

---

### 1.3 Sources de risque / Attaquants

| ID Source | Source de risque / Attaquant           | Description                                                       | Motivation typique                      | Ressources           | Pertinence |
|:---------:|----------------------------------------|-------------------------------------------------------------------|-----------------------------------------|----------------------|-----------|
| A1        | Opérateur légitime malveillant         | Employé ayant accès à Signop et détournant le processus.         | Sabotage, fraude, intérêt financier     | Accès physique & logique | Élevée    |
| A2        | Opérateur négligent                    | Employé commettant des erreurs de manipulation.                  | Manque de rigueur, fatigue, méconnaissance | Faibles compétences techniques | Élevée    |
| A3        | Attaquant externe / malware            | Malware ou attaquant distant cherchant à compromettre Signop.    | Compromettre la clé ou les logiciels    | Exploit OS/réseau, supports amovibles | Moyenne à élevée |
| A4        | Fournisseur / transport de CD compromis | Acteur ayant accès aux CD avant ou après signature.              | Introduire des modifications malveillantes | Accès aux supports physiques | Moyenne   |
| A5        | Administrateur système malveillant     | Admin disposant de droits étendus sur le système.                | Accès privilégié, copie de clé, effacement de logs | Droits élevés sur le poste | Moyenne   |

---

## Chapitre 2 – Événements redoutés

| ID ER | Événement redouté                                                                 | VM impactées      | Biens impactés        | Gravité (1–4) | Types d’impact                                                                                 |
|:-----:|-----------------------------------------------------------------------------------|-------------------|-----------------------|:-------------:|-----------------------------------------------------------------------------------------------|
| ER1   | Signature d’un logiciel modifié ou malveillant (contrefait mais vu comme légitime) | VM1, VM2          | B2, B3, B5            |       4       | Sécurité des systèmes embarqués, image de marque, responsabilité juridique                    |
| ER2   | Compromission de la clé de signature (copie, fuite, usage non autorisé)          | VM1, VM2, VM3     | B1, B6                |       4       | Possibilité de signer hors contrôle, création de faux produits, crise d’image                |
| ER3   | Indisponibilité prolongée de Signop (impossibilité de signer)                     | VM4               | B4, B5                |       3       | Retards de production, pénalités contractuelles, coûts supplémentaires                         |
| ER4   | Perte ou altération des journaux de signature (traçabilité incomplète ou fausse)  | VM5               | B7                    |       3       | Impossibilité d’enquêter, difficulté à prouver la conformité, risques juridiques              |
| ER5   | Destruction ou corruption des logiciels à signer avant signature                  | VM1, VM2          | B2                    |       3       | Retards de livraison, nécessité de régénérer les binaires, risque de signer une mauvaise version |

---

## Chapitre 3 – Scénarios de menace

Probabilité :  
1 = faible, 2 = moyenne, 3 = élevée.

| ID Scénario | Source de risque | ER ciblé | Description du scénario                                                                                                                                           | Probabilité (1–3) |
|:-----------:|------------------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|
| SM1         | A1 – Opérateur malveillant | ER1 | L’opérateur remplace le CD à signer par un CD contenant un logiciel modifié, puis lance une signature “normale” via Signop.                                     |         2         |
| SM2         | A2 – Opérateur négligent  | ER1 / ER5 | L’opérateur mélange des CD ou se trompe de version, signe un logiciel non validé ou écrase par erreur les bons CD avec de mauvaises images.                     |         3         |
| SM3         | A3 – Attaquant externe / malware | ER1 / ER2 | Un malware présent sur le poste Signop ou sur un support USB modifie les fichiers à signer ou lit la clé de signature en mémoire / sur disque.                 |         2         |
| SM4         | A4 – Interception / manipulation de CD | ER1 / ER5 | Un acteur malveillant manipule les CD pendant le transport (avant ou après signature) et introduit des logiciels modifiés ou détruit le contenu.                |         2         |
| SM5         | A5 – Administrateur système malveillant | ER2 / ER4 | L’admin ayant des droits élevés copie la clé de signature ou efface/altère les journaux de signature pour masquer des actions.                                  |         2         |
| SM6         | A1 / A2 – Mauvaise gestion du CD d’injection de clé | ER2 | Mauvaise gestion du CD de clé (copie non autorisée, stockage non sécurisé, perte), entraînant la fuite ou l’usage non maîtrisé de la clé de signature.          |         2         |

---

## Chapitre 4 – Risques (cotation)

Grille indicative de niveau de risque en fonction du produit **Impact × Probabilité** :

- 1–3  → Faible  
- 4–6  → Moyen  
- 7–9  → Élevé / Critique

| ID Risque | Scénario | ER associé | Impact (1–4) | Probabilité (1–3) | Score I×P | Niveau           |
|:---------:|----------|-----------|:------------:|:-----------------:|:---------:|------------------|
| R1        | SM1 – Opérateur malveillant modifie le logiciel à signer | ER1 | 4 | 2 | 8 | **Élevé**        |
| R2        | SM2 – Erreur d’opérateur (mauvaise version signée)       | ER1 / ER5 | 4 | 3 | 12 | **Élevé / Critique** |
| R3        | SM3 – Malware sur le poste Signop                        | ER1 / ER2 | 4 | 2 | 8 | **Élevé**        |
| R4        | SM5 – Admin système copie la clé ou efface les logs      | ER2 / ER4 | 4 | 2 | 8 | **Élevé**        |
| R5        | SM4 – Manipulation des CD en transport                   | ER1 / ER5 | 3 | 2 | 6 | Moyen            |
| R6        | SM6 – Mauvaise gestion du CD d’injection de clé         | ER2       | 4 | 2 | 8 | **Élevé**        |

---

## Chapitre 5 – Mesures de sécurité

Les mesures ci-dessous visent prioritairement les risques de niveau **Élevé** (R1, R2, R3, R4, R6).

| Risque ciblé | Objectif de sécurité                                             | Mesures de sécurité proposées                                                                                                                                                                             | Type (Prévention / Détection / Réaction) |
|--------------|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| R1 – Opérateur malveillant modifie les logiciels | Garantir que seuls les logiciels validés sont signés | - Procédure de validation préalable (double contrôle) des binaires à signer.  \n- Séparation des rôles : préparation des CD vs opération de signature.  \n- Vérification systématique par hash (SHA-256) avant signature. | Prévention |
|              |                                                                  | - Contrôle d’intégrité automatisé des images avant et après signature.  \n- Journalisation détaillée (qui signe quoi, quand) avec revue périodique.                                                     | Détection   |
| R2 – Erreurs d’opérateur (mauvaises versions signées) | Réduire les risques de confusion et d’erreur humaine | - Nommage / étiquetage strict des CD-ROM.  \n- Check-list de vérification avant chaque session de signature.  \n- Interface Signop guidée (sélection explicite de la version, confirmation).  \n- Formation des opérateurs. | Prévention |
|              |                                                                  | - Journalisation automatique des opérations.  \n- Revue régulière des journaux pour détecter des anomalies (fréquence inhabituelle, erreurs répétées).                                                   | Détection   |
| R3 – Malware sur le poste Signop            | Protéger l’environnement d’exécution de Signop      | - Poste **dédié** à la signature, si possible isolé du réseau ou sur un réseau très restreint.  \n- Désactivation des ports USB non nécessaires.  \n- Politique d’installation stricte des logiciels (whitelisting). | Prévention |
|              |                                                                  | - Antivirus / antimalware à jour.  \n- Surveillance de l’intégrité du binaire Signop et de l’OS (checksums, contrôle de conformité).                                                                     | Détection   |
| R4 – Admin système malveillant / logs altérés | Assurer la confidentialité de la clé et l’intégrité des journaux | - Utilisation d’un module sécurisé (HSM ou équivalent) pour stocker la clé : jamais en clair sur disque.  \n- Séparation des rôles : admin système ≠ admin sécurité.  \n- Accès à la clé soumis au principe du double contrôle (4-eyes). | Prévention |
|              |                                                                  | - Journaux signés ou envoyés vers un serveur de logs centralisé (SIEM), non modifiable par un seul admin.  \n- Revues et audits réguliers des journaux d’administration et de signature.                 | Détection   |
| R6 – Mauvaise gestion du CD d’injection de clé | Sécuriser la phase d’injection et la vie du support de clé | - Conservation du CD de clé dans un coffre sécurisé, accès tracé et limité.  \n- Procédure d’utilisation documentée (qui, comment, où, quand).  \n- Destruction sécurisée du CD après usage si le procédé le permet, ou stockage chiffré. | Prévention |
| Tous         | Maintenir le niveau global de sécurité                   | - Sensibilisation régulière des opérateurs et administrateurs.  \n- Audits périodiques de la procédure de signature et tests de reprise après incident (poste de secours, restauration).                | Prévention / Réaction |

---

_Fin du document EBIOS pour Signop Réf. 098 345 v1.0.2._
