
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
	SYMBOLE TEXT,
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
	AUTEUR TEXT,
	CONSTRAINT PK_CATEGORIE PRIMARY KEY(CODECATEGORIE),
	CONSTRAINT UNIC_CATEGORIE UNIQUE(DESIGNATION)
);

CREATE TABLE PRODUITS (
	CODEPRODUITS VARCHAR(15) NOT NULL,
	DESIGNATION TEXT,
	UNITE INT,
	SEUIL DECIMAL(10, 2),
	CATEGORIE INT,
	DATE_AJOUT_PRODUIT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	AUTEUR TEXT,
	CONSTRAINT PK_PRODUITS PRIMARY KEY(CODEPRODUITS),
	CONSTRAINT UNIC_PRODUITS UNIQUE(DESIGNATION)
);

CREATE TABLE CLIENTS(
	CODECLIENTS VARCHAR(15) NOT NULL,
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
	SERVICES INT,
	PHOTO TEXT,
	PERMISSION INT DEFAULT 1,
	CONSTRAINT PK_UTILISATEUR PRIMARY KEY (MATRICULE),
	CONSTRAINT UNIC_UTILISATEUR UNIQUE(NOM, POSTNOM, PRENOM)
);

CREATE TABLE SERVICES (
	CODESERVICES INT NOT NULL,
	DESIGNATION TEXT,
	DESCRIPTION TEXT,
	AUTEUR TEXT,
	CONSTRAINT PK_SERVICES PRIMARY KEY (CODESERVICES),
	CONSTRAINT UNIC_SERVICES UNIQUE(DESIGNATION)
);

CREATE TABLE COMPTE(
	CODECOMPTE VARCHAR(15) NOT NULL,
	UTILISATEUR TEXT,
	NOM_UTILISATEUR TEXT,
	MOT_DE_PASSE TEXT,
	CONSTRAINT PK_COMPTE PRIMARY KEY(CODECOMPTE),
	CONSTRAINT UNIC_COMPTE UNIQUE(NOM_UTILISATEUR)
);
/*========================LES PROCEDURE STOCKEES GESTION_UNITE===========================*/
DROP PROCEDURE IF EXISTS GESTION_UNITE;
DELIMITER //
	CREATE PROCEDURE GESTION_UNITE (
	IN U_OPERATION TEXT,
	IN U_CODEUNITE INT,
	IN U_DESIGNATION TEXT,
	IN U_SIGNE TEXT,
	IN U_AUTEUR TEXT
)
BEGIN
	DECLARE
		CODE      INT;
 -- CHECKING THE U_OPERATION
		IF        U_OPERATION = 'INSERT' THEN
			SET CODE=(
				SELECT
					COALESCE(MAX(CODEUNITE),
					0)+1
				FROM
					UNITE
			);
			INSERT    IGNORE INTO UNITE (CODEUNITE, DESIGNATION, SIGLE, AUTEUR) VALUES (CODE, U_DESIGNATION, U_SIGLE, U_AUTEUR);
			ELSEIF    U_OPERATION = 'UPDATE' THEN
				UPDATE UNITE SET DESIGNATION=U_DESIGNATION,SIGLE=U_SIGLE,AUTEUR=U_AUTEUR WHERE CODEUNITE=U_CODEUNITE;
			ELSEIF U_OPERATION= 'SELECT' THEN
				SELECT * FROM UNITE WHERE CODEUNITE=U_CODEUNITE;
			ELSE
				SELECT
					'Action Non Reconnu' AS MESSAGE;
			END IF; END;
 /*========================LES PROCEDURE STOCKEES GESTION_CATEGORIE===========================*/
	DROP PROCEDURE IF EXISTS GESTION_CATEGORIE;
	DELIMITER // CREATE PROCEDURE GESTION_CATEGORIE ( IN C_OPERATION TEXT, IN C_CODECATEGORIE INT, IN C_DESIGNATION TEXT, IN C_AUTEUR TEXT )
	BEGIN
		DECLARE
			CODE   INT;
 -- CHECKING THE C_OPERATION
			IF     C_OPERATION = 'INSERT' THEN
				SET CODE=(
					SELECT
						COALESCE(MAX(CODECATEGORIE),
						0)+1
					FROM
						CATEGORIE
				);
				INSERT IGNORE INTO CATEGORIE (CODECATEGORIE, DESIGNATION, AUTEUR) VALUES (CODE, C_DESIGNATION, C_AUTEUR);
				ELSEIF C_OPERATION = 'UPDATE' THEN
					UPDATE CATEGORIE SET DESIGNATION=C_DESIGNATION, AUTEUR=C_AUTEUR WHERE CODECATEGORIE=U_CODEUNITE;
					ELSEIF C_OPERATION= 'DELETE' THEN
						DELETE FROM CATEGORIE WHERE CODECATEGORIE=U_CODECATEGORIE;
						ELSEIF C_OPERATION ='SELECT' THEN
							SELECT
								*
							FROM
								CATEGORIE
							WHERE
								CODECATEGORIE=C_CODECATEGORIE;
							ELSE  
							SELECT
								'Opération non reconnue' AS MESSAGE;
						END IF;
					END;
/*========================LES PROCEDURE STOCKEES GESTION_DEVISE===========================*/
DROP PROCEDURE IF EXISTS GESTION_DEVISE;
DELIMITER //
CREATE PROCEDURE GESTION_DEVISE
(
	IN D_OPERATION TEXT,
	IN D_CODEDEVISE INT,
	IN D_DESIGNATION TEXT,
	IN D_SIGLE TEXT,
	IN D_TAUX DECIMAL(10,4),
	IN D_SYMBOLE TEXT,
	IN D_AUTEUR TEXT
)
BEGIN
	DECLARE CODE INT;
	-- CHECKING OPERATIONS SHOULD BE DONE
	IF D_OPERATION = 'INSERT' THEN
		SET CODE= (SELECT COALESCE(MAX(CODEDEVISE),0)+1 FROM DEVISE);
		INSERT IGNORE INTO DEVISE(CODEDEVISE,DESIGNATION,SIGLE,TAUX,SYMBOLE,AUTEUR) VALUES(CODE,D_DESIGNATION,D_SIGLE,D_TAUX,D_SYMBOLE,D_AUTEUR);
	ELSEIF D_OPERATION= 'UPDATE' THEN
		UPDATE DEVISE SET DESIGNATION=D_DESIGNATION,SIGLE=D_SIGLE,TAUX=D_TAUX,SYMBOLE=D_SYMBOLE,AUTEUR=D_AUTEUR WHERE CODEDEVISE=D_CODEDEVISE;
	ELSEIF D_OPERATION= 'DELETE' THEN
		DELETE FROM DEVISE WHERE CODEDEVISE=D_CODEDEVISE;
	ELSEIF D_OPERATION= 'SELECT' THEN
		SELECT * FROM DEVISE WHERE CODEDEVISE=D_CODEDEVISE;
	ELSE
		SELECT 'Action non reconnue' AS MESSAGE;
	END IF;
END;
/*========================LES PROCEDURE STOCKEES GESTION_MODEPAIEMENT===========================*/
DROP PROCEDURE IF EXISTS GESTION_MODEPAIEMENT
DELIMITER //
CREATE PROCEDURE GESTION_MODEPAIEMENT
(
	IN MD_OPERATION TEXT,
	IN MD_CODEMODE INT,
	IN MD_DESIGNATION TEXT,
	IN MD_AUTEUR TEXT
)
BEGIN
	DECLARE CODE INT;
	-- CHECKING OPERATION SHOULD BE DONE
	IF MD_OPERATION= 'INSERT' THEN
		SET CODE=(SELECT COALESCE(MAX(CODEMODE),0)+1 FROM MODE_PAIEMENT);
		INSERT IGNORE INTO MODE_PAIEMENT(CODEMODE,DESIGNATION,AUTEUR) VALUES (CODE,MD_DESIGNATION,MD_AUTEUR);
	ELSEIF MD_OPERATION= 'UPDATE' THEN
		UPDATE MODE_PAIEMENT SET DESIGNATION=MD_DESIGNATION,AUTEUR=MD_AUTEUR WHERE CODEMODE=MD_CODEMODE;
	ELSEIF MD_OPERATION= 'DELETE' THEN
		DELETE FROM MODE_PAIEMENT WHERE CODEMODE=MD_CODEMODE;
	ELSEIF MD_OPERATION= 'SELECT' THEN
		SELECT * FROM MODE_PAIEMENT WHERE CODEMODE=MD_CODEMODE;
	ELSE
		SELECT 'Action non reconnue' AS MESSAGE;
	END IF;
END;
/*========================LES PROCEDURE STOCKEES GESTION_SERVICES===========================*/
DROP PROCEDURE IF EXISTS GESTION_SERVICES;
DELIMITER //
CREATE PROCEDURE GESTION_SERVICES
(
	IN S_OPERATION TEXT,
	IN S_CODESERVICES INT,
	IN S_DESIGNATION TEXT,
	IN S_DESCRIPTION TEXT,
	IN S_AUTEUR TEXT
)
BEGIN
	DECLARE CODE INT;
	-- CHECKING OPERATION SHOULD BE DONE 
	IF S_OPERATION= 'INSERT' THEN
		SET CODE=(SELECT COALESCE(MAX(CODESERVICES),0)+1 FROM SERVICES);
		INSERT IGNORE INTO SERVICES(CODESERVICES,DESIGNATION,DESCRIPTION,AUTEUR) VALUES (CODE,S_DESIGNATION,S_DESCRIPTION,S_AUTEUR);
	ELSEIF S_OPERATION= 'UPDATE' THEN
		UPDATE SERVICES SET DESIGNATION=S_DESIGNATION,DESCRIPTION=S_DESCRIPTION,AUTEUR=S_AUTEUR WHERE CODESERVICES=S_CODESERVICES;
	ELSEIF S_OPERATION= 'DELETE' THEN
		DELETE FROM SERVICES WHERE CODESERVICES=S_CODESERVICES;
	ELSEIF S_OPERATION= 'SELECT' THEN
		SELECT * FROM SERVICES WHERE CODESERVICES=S_CODESERVICES;
	ELSE
		SELECT 'Action non reconnue' AS MESSAGE;
	END IF;
END;
/*========================LES PROCEDURE STOCKEES GESTION_UTILISATEURS===========================*/
