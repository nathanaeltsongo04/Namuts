DROP DATABASE IF EXISTS NAMUTS_DB;

CREATE DATABASE NAMUTS_DB;

USE NAMUTS_DB;

CREATE TABLE FOURNISSEURS (
    CODEFOURNISSEUR VARCHAR(15) NOT NULL,
    NOM TEXT,
    POSTNOM TEXT,
    PRENOM TEXT,
    EMAIL TEXT,
    TELEPHONE TEXT,
    ADRESSE TEXT,
    DATE_AJOUT_FOURNISSEUR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_FOURNISSEUR PRIMARY KEY(CODEFOURNISSEUR),
    CONSTRAINT UNIC_TELEPHONE UNIQUE(TELEPHONE)
);

CREATE TABLE MODE_PAIEMENT(
    CODEMODE INT NOT NULL,
    DESIGNATION TEXT,
    AUTEUR TEXT,
    CONSTRAINT PK_MODE PRIMARY KEY(CODEMODE),
    CONSTRAINT UNIC_MODE UNIQUE(DESIGNATION)
);

CREATE TABLE DEVISE (
    CODEDEVISE INT NOT NULL,
    DESIGNATION TEXT,
    SIGLE TEXT,
    TAUX DECIMAL (10, 2),
    DATE_TAUX TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_DEVISE PRIMARY KEY(CODEDEVISE),
    CONSTRAINT UNIC_SIGLE UNIQUE(SIGLE)
);

CREATE TABLE UNITE(
    CODEUNITE INT NOT NULL,
    DESIGNATION TEXT,
    SIGLE TEXT,
    AUTEUR TEXT,
    CONSTRAINT PK_UNITE PRIMARY KEY(CODEUNITE),
    CONSTRAINT UNIC_UNITE UNIQUE(SIGLE)
);

CREATE TABLE CATEGORIE(
    CODECATEGORIE INT NOT NULL,
    DESIGNATION TEXT,
    CONSTRAINT PK_CATEGORIE PRIMARY KEY(CODECATEGORIE),
    CONSTRAINT UNIC_CATEGORIE UNIQUE(DESIGNATION)
);

CREATE TABLE PRODUITS (
    CODEPRODUITS INT NOT NULL,
    DESIGNATION TEXT,
    UNITE INT,
    CATEGORIE INT,
    DATE_AJOUT_PRODUIT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_PRODUITS PRIMARY KEY(CODEPRODUITS),
    CONSTRAINT UNIC_PRODUITS UNIQUE(DESIGNATION)
);

CREATE TABLE CLIENTS(
    CODECLIENTS INT NOT NULL,
    NOM TEXT,
    POSTNOM TEXT,
    PRENOM TEXT,
    CONTACT TEXT,
    EMAIL TEXT,
    ADDRESSE TEXT,
    ACCOMPTE DECIMAL(10, 4),
    DATE_AJOUT_CLIENT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_CLIENTS PRIMARY KEY(CODECLIENTS),
    CONSTRAINT UNIC_CLIENTS UNIQUE(NOM, POSTNOM, PRENOM),
    CONSTRAINT UNIC_EMAIL UNIQUE(EMAIL)
);

CREATE TABLE DEPOT (
    CODEPRODUITS INT NOT NULL,
    PRIX_ACHAT_MOYEN DECIMAL(10, 4),
    PRIX_VENTE_UNITAIRE DECIMAL(10, 4),
    STOCK_DISPONIBLE DECIMAL(10, 2),
    CONSTRAINT PK_DEPOT PRIMARY KEY(CODEPRODUITS)
);

CREATE TABLE MAGAZIN(
    CODEPRODUITS INT NOT NULL,
    PRIX_ACHAT_MOYEN DECIMAL(10, 4),
    PRIX_VENTE_UNITAIRE DECIMAL(10, 4),
    STOCK_DISPONIBLE DECIMAL(10, 2),
    CONSTRAINT PK_MAGAZIN PRIMARY KEY(CODEPRODUITS)
);

CREATE TABLE ENTETE_FACTURE_VENTE (
    CODEENTETEVENTE VARCHAR(15) NOT NULL,
    DATE_FACTURE DATE NOT NULL,
    CLIENT_ID INT,
    TOTAL DECIMAL(10, 4),
    DATE_FACTURE_VENTE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_ENTETE_VENTE PRIMARY KEY(CODEENTETEVENTE)
);

CREATE TABLE DETAILS_FACTURE_VENTE (
    CODEDETAILVENTE VARCHAR(15),
    NUMERO_FACTURE TEXT,
    PRODUITS INT,
    QUANTITE DECIMAL(10, 2),
    PRIX_UNITAIRE DECIMAL(10, 4),
    CONSTRAINT PK_DETAILS_FACTURE PRIMARY KEY(CODEDETAILVENTE)
);

CREATE TABLE ENTETE_FACTURE_ACHAT (
    CODEENTETEACHAT VARCHAR(15) NOT NULL,
    DATE_FACTURE DATE NOT NULL,
    CLIENT_ID INT,
    TOTAL DECIMAL(10, 4),
    DATE_FACTURE_ACHAT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUTEUR TEXT,
    CONSTRAINT PK_ENTETE_ACHAT PRIMARY KEY(CODEENTETEACHAT)
);

CREATE TABLE DETAILS_FACTURE_ACHAT (
    CODEDETAILACHAT VARCHAR(15),
    NUMERO_FACTURE_ACHAT TEXT,
    PRODUITS INT,
    QUANTITE DECIMAL(10, 2),
    PRIX_UNITAIRE DECIMAL(10, 4),
    CONSTRAINT PK_DETAILS_ACHAT PRIMARY KEY(CODEDETAILACHAT)
);

CREATE TABLE MOUVEMENT_DEPOT (
    CODE_MOUVEMENT_DEPOT VARCHAR(15),
    PRODUITS INT,
    TYPE_OPERATION ENUM('ENTREE', 'SORTIE', 'RETOUR') NOT NULL,
    QUANTITE DECIMAL(10, 2),
    PRIX_UNITAIRE DECIMAL(10, 4),
    DATE_MOUVEMENT_DEPOT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_MOUVEMENT_DEPOT PRIMARY KEY(CODE_MOUVEMENT_DEPOT)
);

CREATE TABLE MOUVEMENT_MAGAZIN (
    CODE_MOUVEMENT_MAGAZIN VARCHAR(15),
    PRODUITS INT,
    TYPE_OPERATION ENUM('ENTREE', 'SORTIE', 'RETOUR') NOT NULL,
    QUANTITE DECIMAL(10, 2),
    PRIX_UNITAIRE DECIMAL(10, 4),
    DATE_MOUVEMENT_MAGAZIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_MOUVEMENT_DEPOT PRIMARY KEY(CODE_MOUVEMENT_MAGAZIN)
);

CREATE TABLE PAIEMENTS_VENTE (
    CODE_PAIEMENT_VENTE VARCHAR(15) NOT NULL,
    NUMERO_FACTURE TEXT,
    MONTANT DECIMAL(10, 4) NOT NULL,
    DATE_PAIEMENT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    MODE_PAIEMENT TEXT,
    CONSTRAINT PK_PAIEMENT_VENTE PRIMARY KEY(CODE_PAIEMENT_VENTE)
);

CREATE TABLE PAIEMENTS_ACHAT (
    CODE_PAIEMENT_ACHAT VARCHAR(15) NOT NULL,
    NUMERO_FACTURE TEXT,
    MONTANT DECIMAL(10, 4) NOT NULL,
    DATE_PAIEMENT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    MODE_PAIEMENT TEXT,
    CONSTRAINT PK_PAIEMENT_VENTE PRIMARY KEY(CODE_PAIEMENT_ACHAT)
);

CREATE TABLE RELEVE_PAIEMENT (
    CODE_RELEVE VARCHAR(15) NOT NULL,
    CODE_PAIEMENT_VENTE INT,
    DATE_RELEVE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    MONTANT DECIMAL(10, 4),
    CONSTRAINT PK_RELEVE PRIMARY KEY(CODE_RELEVE)
);

CREATE TABLE UTILISATEUR (
    MATRICULE VARCHAR(15) NOT NULL,
    NOM TEXT,
    POSTNOM TEXT,
    PRENOM TEXT,
    CONTACT TEXT,
    EMAIL TEXT,
    ADDRESSE TEXT,
    CONSTRAINT PK_UTILISATEUR PRIMARY KEY (MATRICULE),
    CONSTRAINT UNIC_UTILISATEUR UNIQUE(NOM, POSTNOM, PRENOM)
);

CREATE TABLE SERVICES (
    CODESERVICES INT NOT NULL,
    DESIGNATION TEXT,
    DESCRIPTION TEXT,
    CONSTRAINT PK_SERVICES PRIMARY KEY (CODESERVICES),
    CONSTRAINT UNIC_SERVICES UNIQUE(DESIGNATION)
);

CREATE TABLE COMPTE(
    CODECOMPTE VARCHAR(15) NOT NULL,
    UTILISATEUR TEXT,
    NOM_UTILISATEUR TEXT,
    MOT_DE_PASSE TEXT,
    SERVICE INT,
    CONSTRAINT PK_COMPTE PRIMARY KEY(CODECOMPTE),
    CONSTRAINT UNIC_COMPTE UNIQUE(NOM_UTILISATEUR)
);