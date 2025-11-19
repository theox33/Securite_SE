# Analyse CDS CSPN de l'Outil de Protection et de Signature

## 1. Contexte et Périmètre (EBIOS RM Étape 1)

Périmètre étudié : l'outil de signature « Signop » (version 1.0.2), son environnement de préparation (poste dédié hors réseau), le processus de récupération des logiciels sources sur CD-ROM amont, l'opération de signature, puis la gravure des logiciels signés sur CD-ROM aval. La phase de configuration unique (injection de la clé privée de signature via CD-ROM) est incluse. Les environnements externes (systèmes embarqués finaux) sont hors périmètre.

Objectif métier principal : garantir l'authenticité et l'intégrité des logiciels embarqués distribués; prévenir l'introduction de code malveillant ou altéré; assurer la traçabilité réglementaire.

### Parties prenantes
| Rôle                       | Intérêt / Responsabilité                     | Exigences principales                          |
| -------------------------- | -------------------------------------------- | ---------------------------------------------- |
| Opérateur de signature     | Exécute procédure (injection clé, signature) | Simplicité, fiabilité, absence d'erreurs       |
| Administrateur sécurité    | Gère clé, politiques, audits                 | Confidentialité clé, intégrité process         |
| Fournisseur logiciel amont | Fournit binaire non signé                    | Intégrité du binaire reçu                      |
| Client final / Intégrateur | Reçoit logiciel signé                        | Authenticité, traçabilité, absence malware     |
| Auditeur interne/externe   | Vérifie conformité                           | Journalisation, preuves, chaîne de confiance   |
| Attaquant externe          | Cherche contournement, clé ou sabotage       | Exploiter vulnérabilités physiques/logicielles |

### Hypothèses
1. Poste isolé (pas de réseau) sauf éventuellement alimentation électrique standard.
2. Accès physique contrôlé (salle sécurisée) mais possibilité d'insider malveillant.
3. Clé privée stockée dans module logiciel ou fichier protégé (pas de HSM matériel dédié dans la version 1.0.2).
4. Procédures opérateur principalement manuelles (risque d'erreur humaine).

### Cadre normatif / Contraintes
- Besoins de conformité interne (politique sécurité) et éventuelle future certification CSPN.
- Exigence forte sur l'authenticité (signature correcte, clé non compromise) et sur l'intégrité (absence d'altération logicielle).

---

## 2. Actifs (Assets) (EBIOS RM Étape 2)

### Actifs Primaires (Valeur Métier)
| ID  | Actif                          | Description                                        | Criticité (H/M/B) | Besoins (C/I/D/T)  |
| --- | ------------------------------ | -------------------------------------------------- | ----------------- | ------------------ |
| AP1 | Clé privée de signature        | Matériel cryptographique garantissant authenticité | Haute             | C I D              |
| AP2 | Logiciel signé final           | Binaire livré sur CD-ROM sortant                   | Haute             | I A (Authenticité) |
| AP3 | Procédure de signature         | Chaîne opérationnelle reproductible et traçable    | Moyenne           | I T                |
| AP4 | Journal / Log de signature     | Preuves horodatées des opérations                  | Moyenne           | I T                |
| AP5 | Image initiale logiciel source | Binaire entrant à signer                           | Haute             | I                  |

### Actifs de Support
| ID  | Actif support                              | Rôle                                 | Lien actifs primaires |
| --- | ------------------------------------------ | ------------------------------------ | --------------------- |
| AS1 | Poste de travail dédié                     | Environnement d'exécution            | AP1-AP5               |
| AS2 | Système d'exploitation                     | Support logiciel, gestion accès      | AP1-AP4               |
| AS3 | Lecteur CD-ROM amont                       | Entrée médias sources                | AP5                   |
| AS4 | Graveur CD-ROM aval                        | Production médias signés             | AP2                   |
| AS5 | Stockage local (disque)                    | Contient clé et binaires temporaires | AP1, AP5              |
| AS6 | Support CD-ROM d'injection clé             | Transport initial clé privée         | AP1                   |
| AS7 | Salle sécurisée / Contrôle d'accès         | Protection physique                  | AP1-AP5               |
| AS8 | Procédures papier / manuels                | Guide opérateur                      | AP3                   |
| AS9 | Antivirus / Outils intégrité (si présents) | Détection corruption                 | AP5, AP2              |

---

## 3. Événements redoutés (Feared Events)

Notation besoins sécurité : C=Confidentialité, I=Intégrité, D=Disponibilité, T=Traçabilité, A=Authenticité.

| ER ID | Actif impacté             | Besoin compromis | Description                                          | Impact Métier (1-5) |
| ----- | ------------------------- | ---------------- | ---------------------------------------------------- | ------------------- |
| ER1   | Clé privée (AP1)          | C                | Divulgation de la clé de signature                   | 5                   |
| ER2   | Clé privée (AP1)          | I                | Altération / Substitution clé (signatures invalides) | 5                   |
| ER3   | Logiciel signé (AP2)      | I/A              | Injection de code malveillant signé                  | 5                   |
| ER4   | Procédure signature (AP3) | T                | Perte de traçabilité (absence de logs)               | 3                   |
| ER5   | Journal (AP4)             | I/T              | Modification logs pour masquer actions               | 4                   |
| ER6   | Logiciel source (AP5)     | I                | Altération avant signature (supply chain local)      | 4                   |
| ER7   | Poste (AS1)               | D                | Indisponibilité poste (panne) bloquant production    | 3                   |
| ER8   | Stockage (AS5)            | C/I              | Extraction ou corruption fichiers temporaires        | 4                   |

Impact échelle: 1 Faible – 5 Critique.

---

## 4. Sources de Menaces (Threat Sources)

| Source                         | Type          | Motivation               | Ressources / Capacités      | Opportunités                               |
| ------------------------------ | ------------- | ------------------------ | --------------------------- | ------------------------------------------ |
| Attaquant externe opportuniste | Externe       | Gain financier, sabotage | Faibles à moyennes          | Failles physiques, médias interchangeables |
| Attaquant ciblé sophistiqué    | Externe       | Espionnage industriel    | Élevées (technique, social) | Absence HSM, procédures manuelles          |
| Employé malveillant (insider)  | Interne       | Revanche, gain           | Accès légitime physique     | Phase d'injection / opérations signature   |
| Prestataire nettoyage          | Interne tiers | Opportuniste             | Faibles                     | Présence hors supervision (si accès salle) |
| Malware sur média amont        | Technique     | Propagation              | Automatisé                  | CD-ROM source infecté, absence scan        |

---

## 5. Scénarios / Chemins d'Attaque (Attack Paths)

| Scénario | Source                        | Vulnérabilité clé                           | Étapes                                                           | Événement redouté | Probabilité (L/M/H) |
| -------- | ----------------------------- | ------------------------------------------- | ---------------------------------------------------------------- | ----------------- | ------------------- |
| S1       | Insider                       | Clé stockée en clair sur disque             | Accès physique → copie fichier clé → exfiltration                | ER1               | M                   |
| S2       | Externe ciblé                 | Absence HSM / protection matérielle         | Obtention accès physique (intrusion) → extraction clé            | ER1               | L                   |
| S3       | Insider                       | Procédures insuffisantes de contrôle double | Substitution clé sur média configuration → signature frauduleuse | ER2               | M                   |
| S4       | Malware média amont           | Absence de scan CD source                   | Introduire binaire altéré → signé automatiquement                | ER3/ER6           | H                   |
| S5       | Attaquant externe sophistiqué | Manque de contrôle intégrité logs           | Compromet OS → modifie logs pour masquer altération              | ER5               | L                   |
| S6       | Insider                       | Journalisation non robuste                  | Non lancement outil log / effacement traces                      | ER4               | M                   |
| S7       | Opportuniste externe          | Pas de whitelisting exécution               | Lancement code sur poste via média → altère binaire              | ER3               | M                   |
| S8       | Incident technique            | Redondance inexistante                      | Panne grave disque poste                                         | ER7/ER8           | M                   |

---

## 6. Évaluation des Risques

Matrice simplifiée (Probabilité x Impact). Conversion qualitative :
- Probabilité: L(1), M(2), H(3)
- Impact: Valeur "Impact Métier" des ER.

Score = P * Impact. Seuils: 12+ Critique, 8-11 Élevé, 4-7 Modéré, <4 Faible.

| Scénario | P   | Impact max associé | Score | Niveau   |
| -------- | --- | ------------------ | ----- | -------- |
| S1       | 2   | 5                  | 10    | Élevé    |
| S2       | 1   | 5                  | 5     | Modéré   |
| S3       | 2   | 5                  | 10    | Élevé    |
| S4       | 3   | 5                  | 15    | Critique |
| S5       | 1   | 4                  | 4     | Modéré   |
| S6       | 2   | 3                  | 6     | Modéré   |
| S7       | 2   | 5                  | 10    | Élevé    |
| S8       | 2   | 4                  | 8     | Élevé    |

Risques prioritaires: S4 (Critique), S1/S3/S7/S8 (Élevé).

---

## 7. Traitement des Risques (Mesures Recommandées)

### Mesures Prioritaires (Critique / Élevé)
| Risque | Mesure                                                                      | Type (Prévention/Détection/Résilience) | Justification                            |
| ------ | --------------------------------------------------------------------------- | -------------------------------------- | ---------------------------------------- |
| S4     | Scan antivirus + contrôle intégrité hash des médias sources avant signature | Prévention/Détection                   | Réduit infection binaire avant signature |
| S4     | Signature entrante / liste de confiance fournisseurs                        | Prévention                             | Limite sources non validées              |
| S1     | Stockage clé dans module matériel (HSM) + chiffrement au repos              | Prévention                             | Diminue exfiltration clé                 |
| S3     | Procédure de contrôle double opérateur lors injection clé                   | Prévention                             | Réduit substitution malveillante         |
| S7     | Whitelisting applicatif + verrouillage exécution non autorisée              | Prévention                             | Empêche exécution code arbitraire        |
| S8     | Sauvegarde régulière + poste de secours pré-configuré                       | Résilience                             | Réduit indisponibilité prolongée         |

### Mesures Complémentaires (Modéré)
| Risque | Mesure                                               | Type                 | Justification                  |
| ------ | ---------------------------------------------------- | -------------------- | ------------------------------ |
| S2     | Surveillance vidéo + scellés matériels               | Prévention/Détection | Décourage intrusion physique   |
| S5     | Hash chaîné / signature des logs + stockage immuable | Détection            | Empêche altération silencieuse |
| S6     | Journalisation centralisée (support WORM)            | Détection/T          | Préserve traçabilité           |

### Hygiène Générale
- Durcissement OS (suppression services inutiles, comptes minimaux).
- Mises à jour sécurité périodiques (processus hors réseau via médias vérifiés).
- Formation sensibilisation opérateurs (social engineering, procédures).
- Gestion des médias : catalogage, scellés, numérotation, quarantaine initiale.
- Politique de révocation clé (en cas de compromission) + rotation périodique planifiée.

---

## 8. Plan de Mise en Œuvre (Synthèse)
| Mesure                     | Priorité | Responsable        | Délai cible | Indicateur                        |
| -------------------------- | -------- | ------------------ | ----------- | --------------------------------- |
| Intégration HSM            | Haute    | Admin sécurité     | 3 mois      | Clé retirée du disque             |
| Scan hash médias           | Haute    | Opérateur + Outils | 1 mois      | 100% médias vérifiés              |
| Procédure double contrôle  | Haute    | Admin sécurité     | 1 mois      | Checklists signées                |
| Whitelisting applicatif    | Haute    | Admin système      | 2 mois      | Taux blocage exec non autorisée   |
| Sauvegarde + poste secours | Haute    | Admin système      | 2 mois      | RTO < 4h                          |
| Signature logs             | Moyenne  | Admin sécurité     | 3 mois      | Intégrité vérifiée périodiquement |
| Formation opérateurs       | Moyenne  | RH + Sécurité      | 2 mois      | % formés > 90%                    |

---

## 9. Résiduel & Suivi
Après mise en œuvre, re-évaluer probabilités (ex: S4 passe H→M si contrôles efficaces). Mettre en place revue trimestrielle (journal intégrité, tests restauration, audit des procédures). Indicateurs déclencheurs : échec contrôle hash, anomalie log, changement personnel clé.

## 10. Conclusion
L'analyse EBIOS RM met en évidence la centralité de la clé privée et l'exposition forte aux compromis via médias sources. La priorisation des mesures techniques (HSM, intégrité médias, whitelisting) couplée aux procédures organisationnelles (double contrôle, formation, journal inviolable) renforce la chaîne de confiance nécessaire à une éventuelle certification CSPN et à la confiance des clients.

---

Document fictif à visée pédagogique.