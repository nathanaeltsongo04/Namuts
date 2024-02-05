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
	IDDEPOT INT NOT NULL,
	CODEPRODUITS VARCHAR (14),
	PRIX_ACHAT_MOYEN DECIMAL(10, 4),
	PRIX_VENTE_UNITAIRE DECIMAL(10, 4),
	STOCK_DISPONIBLE DECIMAL(10, 2),
	CONSTRAINT PK_DEPOT PRIMARY KEY(IDDEPOT)
);

CREATE TABLE MAGAZIN(
	CODEMAGASIN INT NOT NULL,
	CODEPRODUITS VARCHAR(15),
	PRIX_ACHAT_MOYEN DECIMAL(10, 4),
	PRIX_VENTE_UNITAIRE DECIMAL(10, 4),
	STOCK_DISPONIBLE DECIMAL(10, 2),
	ETATS_STOCK TEXT,
	CONSTRAINT PK_MAGAZIN PRIMARY KEY(CODEMAGASIN)
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
	PHOTO TEXT,
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
	SERVICE INT,
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
	IN D_AUTEUR TEXT
)
BEGIN
	DECLARE CODE INT;
	-- CHECKING OPERATIONS SHOULD BE DONE
	IF D_OPERATION = 'INSERT' THEN
		SET CODE= (SELECT COALESCE(MAX(CODEDEVISE),0)+1 FROM DEVISE);
		INSERT IGNORE INTO DEVISE(CODEDEVISE,DESIGNATION,SIGLE,TAUX,AUTEUR) VALUES(CODE,D_DESIGNATION,D_SIGLE,D_TAUX,D_AUTEUR);
	ELSEIF D_OPERATION= 'UPDATE' THEN
		UPDATE DEVISE SET DESIGNATION=D_DESIGNATION,SIGLE=D_SIGLE,TAUX=D_TAUX,AUTEUR=D_AUTEUR WHERE CODEDEVISE=D_CODEDEVISE;
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
-- ====================================PROCEDURE DE GESTION FOURNISSEURS
DROP PROCEDURE IF EXISTS Gestion_fournisseurs;
DELIMITER //
CREATE PROCEDURE Gestion_fournisseurs(
    IN type ENUM('INSERT','UPDATE','DELETE'),
    in codefourni varchar(14),
    in nom TEXT,
    in Prenom TEXT,
    in email TEXT,
    in teelphone TEXT,
    in adresse TEXT, 
    IN postnom text,
    in auteur text)
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'FOU'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM fournisseurs
    WHERE LEFT(CODEFOURNISSEUR, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(CODEFOURNISSEUR, LENGTH(CODEFOURNISSEUR) - 10)) INTO counter
        FROM fournisseurs
        WHERE LEFT(CODEFOURNISSEUR, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO fournisseurs (CODEFOURNISSEUR,nom,POSTNOM,prenom,Email,Telephone,Adresse,auteur) VALUES (
primaryKey, nom, POSTNOM,Prenom, email ,teelphone,adresse,auteur
);
ELSEIF type = 'UPDATE' THEN
UPDATE fournisseurs SET nom=nom,prenom=prenom,POSTNOM=Postnom,Email=email,Telephone=teelphone,Adresse=Adresse
WHERE CODEFOURNISSEUR=codefourni;

ELSEIF type = 'DELETE' THEN
DELETE FROM fournisseurs WHERE `CODEFOURNISSEUR` = codefourni;
END IF;
END //
DELIMITER //

-- ===================== PROCEDURE GESTION CLIENTS ==================================

-- create TABLE gestion produits
DELIMITER //
CREATE PROCEDURE gestion_produit(IN type ENUM('INSERT','UPDATE','DELETE'),in codeproduit varchar(14),in designation text,in unite varchar(20),IN SEUIL INT,IN CATEGORIE INT ,IN AUTEUR TEXT)
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'PRO'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM produits
    WHERE LEFT(CODEPRODUITS, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(CODEPRODUITS, LENGTH(CODEPRODUITS) - 10)) INTO counter
        FROM produits
        WHERE LEFT(CODEPRODUITS, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO produits (CODEPRODUITS,designation,unite,SEUIL,CATEGORIE,AUTEUR) VALUES (
primaryKey, designation, unite,SEUIL,CATEGORIE,AUTEUR);
ELSEIF type = 'UPDATE' THEN
UPDATE produits SET designation=designation,unite=unite,SEUIL=SEUIL,CATEGORIE=CATEGORIE,AUTEUR=AUTEUR
WHERE CODEPRODUITS=codeproduit;

ELSEIF type = 'DELETE' THEN
DELETE FROM produits WHERE `CODEPRODUITS` = codeproduit;
END IF;
END //
DELIMITER //

-- ===================== GESTIONS CLIENTS ================================
DELIMITER //
CREATE PROCEDURE gestion_clients(
    IN type ENUM('INSERT','UPDATE','DELETE'),
    in idClient varchar(14),
    IN noms TEXT,
    IN POSTNOM TEXT,
    in prenoms TEXT,
    in phones TEXT,
    in mails TEXT,
    in adresses TEXT,
    IN ACCOMPTE DECIMAL(10, 4),
    IN AUTEUR TEXT)
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'CLI'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM clients
    WHERE LEFT(CODECLIENTS, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(CODECLIENTS, LENGTH(CODECLIENTS) - 10)) INTO counter
        FROM clients
        WHERE LEFT(CODECLIENTS, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO clients (CODECLIENTS,Nom,POSTNOM,prenom,telephone,email,ADDRESSE,ACCOMPTE,AUTEUR) VALUES (
noms,POSTNOM, prenoms, phones, mails, adresses,ACCOMPTE,AUTEUR
);
ELSEIF type = 'UPDATE' THEN
UPDATE clients SET Nom=noms,prenom=prenoms,telephone=phones,email=mails,adresse=adresses,ACCOMPTE=ACCOMPTE,AUTEUR=AUTEUR
WHERE CODECLIENTS=idClient;

ELSEIF type = 'DELETE' THEN
DELETE FROM CLIENTS WHERE CODECLIENTS = idClient;
END IF;
END //
DELIMITER //

-- PROCEDURE GESTION DU DEPOT
DELIMITER //
CREATE PROCEDURE `Gestion_depot` (
    IN `MatricProduits` INT, 
    IN `quantite` INT, 
    IN `type_operation` ENUM('ENTREE','SORTIE','RETOUR'), 
    IN `PAu` FLOAT,
    IN PRIX_VENTE_UNITAIRE DECIMAL(10, 4))
   BEGIN
    DECLARE stock_actuel INT;
    declare prix_actuel float;
    declare PT_entree float;
    DECLARE Prix_total float;
    declare SFentree int;
    	declare SFPrix float;
    	declare CUMP float;
        DECLARE prix_tmp float;
    DECLARE produit_id INT;
    -- Récupérer la quantité en stock actuelle du produit
    
    set PT_entree = quantite*PAu;
    -- dec
    
    -- IDPRODUITS
    IF type_operation = 'ENTREE' THEN  
        SELECT `CODEPRODUITS` into produit_id FROM `depot` WHERE CODEPRODUITS=MatricProduits
        LIMIT 1;
    ELSEIF type_operation = 'SORTIE' THEN
    	SELECT `CODEPRODUITS` into produit_id FROM `depot` WHERE CODEPRODUITS=MatricProduits
        LIMIT 1;
    ELSEIF type_operation='RETOUR' THEN
     SELECT `CODEPRODUITS` INTO produit_id FROM `depot` WHERE CODEPRODUITS=MatricProduits
     LIMIT 1;
    END IF;
    -- stock actuel
    
    SELECT STOCK_DISPONIBLE INTO stock_actuel FROM depot
    WHERE CODEPRODUITS = produit_id;    
     -- prix actuel
    SELECT PRIX_ACHAT_MOYEN into prix_actuel from depot where CODEPRODUITS = produit_id;  
    -- TESTER LES VALEURS
    if prix_actuel is null THEN
    	set prix_actuel=0;
    end if;
    if stock_actuel is null THEN
    	set stock_actuel=0;
    end if;
    -- prix total actuel  
    SELECT (PRIX_ACHAT_MOYEN* STOCK_DISPONIBLE) into Prix_total  FROM `depot` WHERE CODEPRODUITS=produit_id;
    -- ISNULL
    
        
    -- Vérifier le type d'opération et mettre à jour la quantité en stock
    IF type_operation = 'ENTREE' THEN
    	set SFentree =stock_actuel+quantite;
    	set SFPrix =Prix_total+PT_entree;
    	set CUMP =SFPrix/SFentree;
     	SET stock_actuel = stock_actuel + quantite;         
       	set prix_actuel=CUMP;
        set prix_tmp=PAu;
        UPDATE depot	SET STOCK_DISPONIBLE = stock_actuel, PRIX_ACHAT_MOYEN=CUMP	WHERE CODEPRODUITS = produit_id;    
    ELSEIF type_operation = 'SORTIE' THEN
        SET stock_actuel = stock_actuel - quantite;
        set prix_tmp=prix_actuel;        
        UPDATE depot	SET STOCK_DISPONIBLE = stock_actuel WHERE CODEPRODUITS = produit_id; 
    ELSEIF type_operation = 'RETOUR' THEN
        SET stock_actuel = stock_actuel + quantite;
        set prix_tmp=prix_actuel;        
        UPDATE depot	SET STOCK_DISPONIBLE = stock_actuel WHERE CODEPRODUITS = produit_id;     
    END IF;
    
    
    -- Insérer un enregistrement dans la table des transactions de stock
    INSERT INTO Mouvement_Depot (produit, quantite, type_operation,PU,reste_stock)
    VALUES (produit_id, quantite, type_operation,prix_tmp,stock_actuel);
    
    -- Afficher un message de confirmation
    SELECT CONCAT('Quantité en stock mise à jour : ', stock_actuel) AS message;
    
END //

DELIMITER //

-- GESTION STOCKS MAGASIN
DELIMITER //
CREATE PROCEDURE `gestion_magasin` (
    IN `MatricProduits` INT, 
    IN `quantite` INT, 
    IN `type_operation` ENUM('ENTREE','SORTIE','RETOUR'), 
    IN `PAu` FLOAT)
   BEGIN
    DECLARE stock_actuel INT;
    declare prix_actuel float;
    declare PT_entree float;
    DECLARE Prix_total float;
    declare SFentree int;
    	declare SFPrix float;
    	declare CUMP float;
        DECLARE prix_tmp float;
    DECLARE produit_id INT;
    -- Récupérer la quantité en stock actuelle du produit
    
    set PT_entree = quantite*PAu;
    -- dec
    
    -- IDPRODUITS
    IF type_operation = 'ENTREE' THEN  
        SELECT `CODEPRODUITS` into produit_id FROM `magasin` WHERE CODEPRODUITS=MatricProduits
        LIMIT 1;
    ELSEIF type_operation = 'SORTIE' THEN
    	SELECT `CODEPRODUITS` into produit_id FROM `magasin` WHERE CODEPRODUITS=MatricProduits
        LIMIT 1;
    ELSEIF type_operation='RETOUR' THEN
     SELECT `CODEPRODUITS` INTO produit_id FROM `magasin` WHERE CODEPRODUITS=MatricProduits
     LIMIT 1;
    END IF;
    -- stock actuel
    
    SELECT Stock_dispo INTO stock_actuel FROM magasin
    WHERE CODEPRODUITS = produit_id;    
     -- prix actuel
    SELECT PRIX_ACHAT_MOYEN into prix_actuel from magasin where CODEPRODUITS = produit_id;  
    -- TESTER LES VALEURS
    if prix_actuel is null THEN
    	set prix_actuel=0;
    end if;
    if stock_actuel is null THEN
    	set stock_actuel=0;
    end if;
    -- prix total actuel  
    SELECT (PRIX_ACHAT_MOYEN* STOCK_DISPONIBLE) into Prix_total  FROM `magasin` WHERE CODEPRODUITS=produit_id;
    -- ISNULL
    
        
    -- Vérifier le type d'opération et mettre à jour la quantité en stock
    IF type_operation = 'ENTREE' THEN
    	set SFentree =stock_actuel+quantite;
    	set SFPrix =Prix_total+PT_entree;
    	set CUMP =SFPrix/SFentree;
     	SET stock_actuel = stock_actuel + quantite;         
       	set prix_actuel=CUMP;
        set prix_tmp=PAu;
        UPDATE magasin	SET STOCK_DISPONIBLE = stock_actuel, PRIX_ACHAT_MOYEN=CUMP	WHERE CODEPRODUITS = produit_id;    
    ELSEIF type_operation = 'SORTIE' THEN
        SET stock_actuel = stock_actuel - quantite;
        set prix_tmp=prix_actuel;        
        UPDATE magasin	SET STOCK_DISPONIBLE = stock_actuel WHERE CODEPRODUITS = produit_id; 
    ELSEIF type_operation = 'RETOUR' THEN
        SET stock_actuel = stock_actuel + quantite;
        set prix_tmp=prix_actuel;        
        UPDATE magasin	SET STOCK_DISPONIBLE = stock_actuel WHERE CODEPRODUITS = produit_id;     
    END IF;
    
    
    -- Insérer un enregistrement dans la table des transactions de stock
    INSERT INTO mouvement_magasin (produit, quantite, type_operation,PU,reste_stock)
    VALUES (produit_id, quantite, type_operation,prix_tmp,stock_actuel);
    
    -- Afficher un message de confirmation
    SELECT CONCAT('Quantité en stock mise à jour : ', stock_actuel) AS message;
    
END //

-- GESTION  DETAISL ACHATS
DELIMITER //
CREATE PROCEDURE gestion_det_achat(IN type ENUM('INSERT','UPDATE','DELETE'),in codedetail varchar(14),in produits_code varchar(14),in PA_unitaire decimal(10,4),in PVu decimal(10,4),in Quantites int,in Facture_achat varchar(20))
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'DEA'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM detailfacachat
    WHERE LEFT(iddeta, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(iddeta, LENGTH(iddeta) - 10)) INTO counter
        FROM detailfacachat
        WHERE LEFT(iddeta, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO detailfacachat (Iddeta,Produit,Quantite,PaUni,FactureAchat,Pvun) VALUES (
primaryKey, produits_code, Quantites, PA_unitaire ,Facture_achat,PVu
);
ELSEIF type = 'UPDATE' THEN
UPDATE detailfacachat SET Produit=produits_code,Quantite=Quantites,PaUni=PA_unitaire,FactureAchat=Facture_achat,Pvun=Pvu
WHERE Iddeta=codedetail;

ELSEIF type = 'DELETE' THEN
DELETE FROM detailfacachat WHERE `Iddeta` = codedetail;
END IF;
END //
DELIMITER //

-- GESTION DETAIL VENTES
DELIMITER //
CREATE PROCEDURE gestion_det_vente(IN type ENUM('INSERT','UPDATE','DELETE'),in codedetail varchar(14),in produits_code varchar(14),in PA_unitaire decimal(10,4),in PVu decimal(10,4),in Quantites int,in Facturevente varchar(20))
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'DEV'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM detailfactvente
    WHERE LEFT(Iddeta_vente, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(Iddeta_vente, LENGTH(Iddeta_vente) - 10)) INTO counter
        FROM detailfactvente
        WHERE LEFT(Iddeta_vente, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO detailfactvente (Iddeta_vente,Produit,Quantite,PaUni,Facturevente,Pvun) VALUES (
primaryKey, produits_code, Quantites, PA_unitaire ,Facturevente,PVu
);
ELSEIF type = 'UPDATE' THEN
UPDATE detailfactvente SET Produit=produits_code,Quantite=Quantites,PaUni=PA_unitaire,Facturevente=Facturevente,Pvun=Pvu
WHERE Iddeta_vente=codedetail;

ELSEIF type = 'DELETE' THEN
DELETE FROM detailfactvente WHERE `Iddeta_vente` = codedetail;
END IF;
END //
DELIMITER //

-- PROCEDURE ================================ ================================

DELIMITER //
CREATE PROCEDURE gestion_pay_client(
    IN type ENUM('INSERT','UPDATE','DELETE'),
    in codePay varchar(14),
    in Mode_payement varchar(50),
    in Montant_Paye decimal(10,4),
    in Operation varchar(50)
    ,in Facture_Vente varchar(14),
    in DEVISE varchar(14))
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'PAY'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM pay_client
    WHERE LEFT(MatriPay_client, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(MatriPay_client, LENGTH(MatriPay_client) - 10)) INTO counter
        FROM pay_client
        WHERE LEFT(MatriPay_client, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO pay_client (MatriPay_client,Mode_payement,Facture_Vente,Montant_Paye,DEVISE,Operation) VALUES (
primaryKey, Mode_payement, Facture_Vente, Montant_Paye ,DEVISE,Operation
);
ELSEIF type = 'UPDATE' THEN
UPDATE pay_client SET Mode_payement=Mode_payement,Facture_Vente=Facture_Vente,PaUni=Montant_Paye,DEVISE=DEVISE,Operation=Operation
WHERE MatriPay_client=codePay;

ELSEIF type = 'DELETE' THEN
DELETE FROM pay_client WHERE `MatriPay_client` = codePay;
END IF;
END //
DELIMITER //

-- gestion facture achat
DELIMITER //
CREATE PROCEDURE gestion_fact_achat(
    IN type ENUM('INSERT','UPDATE','DELETE'),
    in codefacture varchar(14),in Fournisseurs varchar(50),in dates varchar(20),IN AUTEUR TEXT)
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'PAY'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM factureachat
    WHERE LEFT(IdFacture, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(IdFacture, LENGTH(IdFacture) - 10)) INTO counter
        FROM factureachat
        WHERE LEFT(IdFacture, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO factureachat (IdFacture,Fournisseurs,dateFacturation,AUTEUR) VALUES (
primaryKey, Fournisseurs, dates,AUTEUR);
ELSEIF type = 'UPDATE' THEN
UPDATE factureachat SET Fournisseurs=Fournisseurs,dateFacturation=dates,AUTEUR=AUTEUR
WHERE IdFacture=codefacture;

ELSEIF type = 'DELETE' THEN
DELETE FROM factureachat WHERE `IdFacture` = codefacture;
END IF;
END //
DELIMITER //

-- GESTION FACTURE VENTE
DELIMITER //
CREATE PROCEDURE gestion_fact_vente(
    IN type ENUM('INSERT','UPDATE','DELETE'),
    in coteVente varchar(14),
    in client varchar(50),
    in date_facture varchar(20),
    IN AUTEUR TEXT
    )
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'VEN'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM facture_vente
    WHERE LEFT(MatriculeVente, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(MatriculeVente, LENGTH(MatriculeVente) - 10)) INTO counter
        FROM facture_vente
        WHERE LEFT(MatriculeVente, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO facture_vente (MatriculeVente,client,date_facture,AUTEUR) VALUES (
primaryKey, client, date_facture,AUTEUR);
ELSEIF type = 'UPDATE' THEN
UPDATE facture_vente SET client=client,date_facture=date_facture,AUTEUR=AUTEUR
WHERE MatriculeVente=coteVente;

ELSEIF type = 'DELETE' THEN
DELETE FROM facture_vente WHERE `MatriculeVente` = coteVente;
END IF;
END //
DELIMITER //

-- ======================= =============================
DELIMITER //
CREATE PROCEDURE gestion_devise(IN type ENUM('INSERT','UPDATE','DELETE'),in CodeDevise varchar(14),in designation text,in taux varchar(20))
BEGIN
DECLARE prefix VARCHAR(8); -- Modified prefix length to accommodate month
    DECLARE year VARCHAR(4);
    DECLARE month VARCHAR(2);
    DECLARE counter INT;
    DECLARE primaryKey VARCHAR(14); -- Adjusted to accommodate prefix, year, month, and counter

if type = 'INSERT' THEN
    SET prefix = 'DEV'; -- Préfixe de la clé primaire
    SET year = YEAR(CURDATE());
    SET month = LPAD(MONTH(CURDATE()), 2, '0'); -- Retrieve and pad current month
    SET counter = 1;

    -- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
    SELECT COUNT(*) INTO counter FROM Devise
    WHERE LEFT(idDevise, 10) = CONCAT(prefix, year, month);
    
    IF counter > 0 THEN
        -- Récupérer le dernier numéro utilisé dans la clé primaire
        SELECT MAX(RIGHT(idDevise, LENGTH(idDevise) - 10)) INTO counter
        FROM Devise
        WHERE LEFT(idDevise, 10) = CONCAT(prefix, year, month);
        SET counter = counter + 1;
    END IF;

    -- Générer la clé primaire finale
    SET primaryKey = CONCAT(prefix, year, month, LPAD(counter, 4, '0'));

INSERT INTO Devise (idDevise,designation,taux) VALUES (
primaryKey, designation, taux);
ELSEIF type = 'UPDATE' THEN
UPDATE Devise SET designation=designation,taux=taux
WHERE idDevise=CodeDevise;

ELSEIF type = 'DELETE' THEN
DELETE FROM Devise WHERE `idDevise` = CodeDevise;
END IF;
END //
DELIMITER //


