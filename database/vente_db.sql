-- STRUCTURE DES ACHATS
-- Structure de la table `fournisseurs`
--
CREATE TABLE
    `fournisseurs` (
        `MatriFourni` varchar(11) PRIMARY KEY NOT NULL,
        `nom` varchar(255) DEFAULT NULL,
        `prenom` varchar(255) DEFAULT NULL,
        `Email` varchar(50) DEFAULT NULL,
        `Telephone` varchar(20) DEFAULT NULL,
        `Adresse` text DEFAULT NULL
    );

-- --------------------------------------------------------
-- Structure de la table `pay_fournisseur`
--
CREATE TABLE
    `pay_fournisseur` (
        `MatriPay` varchar(14) PRIMARY KEY NOT NULL,
        `Mode_payement` varchar(50) DEFAULT NULL,
        `Montant_Paye` decimal(10, 4) DEFAULT NULL,
        `Operation` varchar(30) DEFAULT NULL,
        `FactureAchat` varchar(14) DEFAULT NULL,
        DEVISE varchar(14) not NULL
    );

--Structure de la table DEVISE
CREATE TABLE
    Devise (
        idDevise varchar(14) PRIMARY KEY,
        designation varchar(20),
        taux decimal(10, 2)
    );

-- --------------------------------------------------------
--Structure de la TABLE Detail facture
CREATE TABLE
    detailFacAchat (
        Iddeta varchar(14) PRIMARY KEY,
        Produit varchar(14),
        Quantite varchar(14),
        PaUni decimal(10, 4),
        FactureAchat varchar(14),
        Pvun decimal(10, 4)
    );

--
-- Structure de la table `produits`
--
CREATE TABLE
    `produits` (
        `Matricule` varchar(11) DEFAULT NULL,
        `designation` varchar(255) DEFAULT NULL,
        `unite` varchar(11) DEFAULT NULL
    );

-- DEPOT ET MAGASIN
CREATE TABLE
    Depot (
        produit_mat varchar(14),
        `PAm` decimal(10, 4) DEFAULT NULL,
        `PVu` decimal(10, 4) DEFAULT NULL,
        `Stock_dispo` int (11) DEFAULT NULL,
        `Etat_stock` varchar(255) DEFAULT NULL
    );

CREATE TABLE
    Magasin (
        produit_mat varchar(14),
        `PAm` decimal(10, 4) DEFAULT NULL,
        `PVu` decimal(10, 4) DEFAULT NULL,
        `Stock_dispo` int (11) DEFAULT NULL,
        `Etat_stock` varchar(255) DEFAULT NULL
    )
    --STRUCTURE DE LA VENTE
    -- ==================================================VENTE ============================================
CREATE TABLE
    `Clients` (
        `MatriClient` varchar(11) PRIMARY KEY NOT NULL,
        `nom` varchar(255) DEFAULT NULL,
        `prenom` varchar(255) DEFAULT NULL,
        `Email` varchar(50) DEFAULT NULL,
        `Telephone` varchar(20) DEFAULT NULL,
        `Adresse` text DEFAULT NULL
    )
    -- FACTURE DE LA VENTE
create TABLE
    facture_Vente (
        MatriculeVente varchar(11) PRIMARY KEY,
        date_facture date,
        client varchar(14)
    );

-- DETAIL DE LA VENTE
CREATE TABLE
    detailFactVente (
        Iddeta_vente varchar(14) PRIMARY KEY,
        Produit varchar(14),
        Quantite varchar(14),
        PaUni decimal(10, 4),
        FactureAchat varchar(14),
        Pvun decimal(10, 4)
    );

-- PAYEMENT
CREATE TABLE
    `pay_client` (
        `MatriPay_client` varchar(14) PRIMARY KEY NOT NULL,
        `Mode_payement` varchar(50) DEFAULT NULL,
        `Montant_Paye` decimal(10, 4) DEFAULT NULL,
        `Operation` varchar(30) DEFAULT NULL,
        `Facture_Vente` varchar(14) DEFAULT NULL,
        reste_a_paye float,
        DEVISE varchar(14) not NULL
    );

--STRUCTURE DE LA TABLE TRANSANCTION STOCK
CREATE TABLE
    `Mouvement_Depot` (
        `id` int (11) primary KEY,
        `produit` VARCHAR(14),
        `quantite` int (11) NOT NULL,
        `type_operation` enum ('ENTREE', 'SORTIE', 'RETOUR') NOT NULL,
        `date_operation` datetime DEFAULT current_timestamp(),
        `PU` decimal(10, 2) NOT NULL,
        `reste_quantite` int (11) NOT Null
    );

CREATE TABLE
    `Mouvement_Magasin` (
        `id` int (11) primary KEY,
        `produit` VARCHAR(14),
        `quantite` int (11) NOT NULL,
        `type_operation` enum ('ENTREE', 'SORTIE', 'RETOUR') NOT NULL,
        `date_operation` datetime DEFAULT current_timestamp(),
        `PU` decimal(10, 2) NOT NULL,
        `reste_quantite` int (11) NOT Null
    );

-- PROCEDURE GESTION DU DEPOT
DELIMITER / / CREATE PROCEDURE `Gestion_depot` (
    IN `MatricProduits` INT,
    IN `quantite` INT,
    IN `type_operation` ENUM ('ENTREE', 'SORTIE', 'RETOUR'),
    IN `PAu` FLOAT
) BEGIN DECLARE stock_actuel INT;

declare prix_actuel float;

declare PT_entree float;

DECLARE Prix_total float;

declare SFentree int;

declare SFPrix float;

declare CUMP float;

DECLARE prix_tmp float;

DECLARE produit_id INT;

-- Récupérer la quantité en stock actuelle du produit
set
    PT_entree = quantite * PAu;

-- dec
-- IDPRODUITS
IF type_operation = 'ENTREE' THEN
SELECT
    `produit_mat` into produit_id
FROM
    `depot`
WHERE
    produit_mat = MatricProduits
LIMIT
    1;

ELSEIF type_operation = 'SORTIE' THEN
SELECT
    `produit_mat` into produit_id
FROM
    `depot`
WHERE
    produit_mat = MatricProduits
LIMIT
    1;

ELSEIF type_operation = 'RETOUR' THEN
SELECT
    `produit_mat` INTO produit_id
FROM
    `depot`
WHERE
    idproduit = tmpid
LIMIT
    1;

END IF;

-- stock actuel
SELECT
    Stock_dispo INTO stock_actuel
FROM
    depot
WHERE
    produit = produit_id;

-- prix actuel
SELECT
    PAm into prix_actuel
from
    depot
where
    produit = produit_id;

-- TESTER LES VALEURS
if prix_actuel is null THEN
set
    prix_actuel = 0;

end if;

if stock_actuel is null THEN
set
    stock_actuel = 0;

end if;

-- prix total actuel  
SELECT
    (PAm * Stock_dispo) into Prix_total
FROM
    `depot`
WHERE
    produi = produit_id;

-- ISNULL
-- Vérifier le type d'opération et mettre à jour la quantité en stock
IF type_operation = 'ENTREE' THEN
set
    SFentree = stock_actuel + quantite;

set
    SFPrix = Prix_total + PT_entree;

set
    CUMP = SFPrix / SFentree;

SET
    stock_actuel = stock_actuel + quantite;

set
    prix_actuel = CUMP;

set
    prix_tmp = PAu;

UPDATE depot
SET
    Stock_dispo = stock_actuel,
    PAm = CUMP
WHERE
    produit = produit_id;

ELSEIF type_operation = 'SORTIE' THEN
SET
    stock_actuel = stock_actuel - quantite;

set
    prix_tmp = prix_actuel;

UPDATE depot
SET
    Stock_dispo = stock_actuel
WHERE
    produit = produit_id;

ELSEIF type_operation = 'RETOUR' THEN
SET
    stock_actuel = stock_actuel + quantite;

set
    prix_tmp = prix_actuel;

UPDATE depot
SET
    Stock_dispo = stock_actuel
WHERE
    produit = produit_id;

END IF;

-- Insérer un enregistrement dans la table des transactions de stock
INSERT INTO
    Mouvement_Depot (
        produit,
        quantite,
        type_operation,
        PU,
        reste_stock
    )
VALUES
    (
        produit_id,
        quantite,
        type_operation,
        prix_tmp,
        stock_actuel
    );

-- Afficher un message de confirmation
SELECT
    CONCAT ('Quantité en stock mise à jour : ', stock_actuel) AS message;

END / / DELIMITER / /
-- GESTION STOCKS MAGASIN
DELIMITER / / CREATE PROCEDURE `gestion_magasin` (
    IN `MatricProduits` INT,
    IN `quantite` INT,
    IN `type_operation` ENUM ('ENTREE', 'SORTIE', 'RETOUR'),
    IN `PAu` FLOAT
) BEGIN DECLARE stock_actuel INT;

declare prix_actuel float;

declare PT_entree float;

DECLARE Prix_total float;

declare SFentree int;

declare SFPrix float;

declare CUMP float;

DECLARE prix_tmp float;

DECLARE produit_id INT;

-- Récupérer la quantité en stock actuelle du produit
set
    PT_entree = quantite * PAu;

-- dec
-- IDPRODUITS
IF type_operation = 'ENTREE' THEN
SELECT
    `produit_mat` into produit_id
FROM
    `magasin`
WHERE
    produit_mat = MatricProduits
LIMIT
    1;

ELSEIF type_operation = 'SORTIE' THEN
SELECT
    `produit_mat` into produit_id
FROM
    `magasin`
WHERE
    produit_mat = MatricProduits
LIMIT
    1;

ELSEIF type_operation = 'RETOUR' THEN
SELECT
    `produit_mat` INTO produit_id
FROM
    `magasin`
WHERE
    idproduit = tmpid
LIMIT
    1;

END IF;

-- stock actuel
SELECT
    Stock_dispo INTO stock_actuel
FROM
    magasin
WHERE
    produit = produit_id;

-- prix actuel
SELECT
    PAm into prix_actuel
from
    magasin
where
    produit = produit_id;

-- TESTER LES VALEURS
if prix_actuel is null THEN
set
    prix_actuel = 0;

end if;

if stock_actuel is null THEN
set
    stock_actuel = 0;

end if;

-- prix total actuel  
SELECT
    (PAm * Stock_dispo) into Prix_total
FROM
    `magasin`
WHERE
    produi = produit_id;

-- ISNULL
-- Vérifier le type d'opération et mettre à jour la quantité en stock
IF type_operation = 'ENTREE' THEN
set
    SFentree = stock_actuel + quantite;

set
    SFPrix = Prix_total + PT_entree;

set
    CUMP = SFPrix / SFentree;

SET
    stock_actuel = stock_actuel + quantite;

set
    prix_actuel = CUMP;

set
    prix_tmp = PAu;

UPDATE magasin
SET
    Stock_dispo = stock_actuel,
    PAm = CUMP
WHERE
    produit = produit_id;

ELSEIF type_operation = 'SORTIE' THEN
SET
    stock_actuel = stock_actuel - quantite;

set
    prix_tmp = prix_actuel;

UPDATE magasin
SET
    Stock_dispo = stock_actuel
WHERE
    produit = produit_id;

ELSEIF type_operation = 'RETOUR' THEN
SET
    stock_actuel = stock_actuel + quantite;

set
    prix_tmp = prix_actuel;

UPDATE magasin
SET
    Stock_dispo = stock_actuel
WHERE
    produit = produit_id;

END IF;

-- Insérer un enregistrement dans la table des transactions de stock
INSERT INTO
    mouvement_magasin (
        produit,
        quantite,
        type_operation,
        PU,
        reste_stock
    )
VALUES
    (
        produit_id,
        quantite,
        type_operation,
        prix_tmp,
        stock_actuel
    );

-- Afficher un message de confirmation
SELECT
    CONCAT ('Quantité en stock mise à jour : ', stock_actuel) AS message;

END / / DELIMITER / /
-- GESTION DES CLIENTS
DELIMITER / / CREATE PROCEDURE gestion_clients (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in idClient varchar(14),
    IN noms varchar(255),
    in prenoms varchar(255),
    in phones varchar(20),
    in mails varchar(20),
    in adresses varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'CLI';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    clients
WHERE
    LEFT (MatriClient, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (MatriClient, LENGTH (id_patient) - 10)) INTO counter
FROM
    clients
WHERE
    LEFT (MatriClient, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    clients (
        MatriClient,
        Nom,
        prenom,
        telephone,
        email,
        adresse
    )
VALUES
    (noms, prenoms, phones, mails, adresses);

ELSEIF type = 'UPDATE' THEN
UPDATE clients
SET
    Nom = noms,
    prenom = prenoms,
    telephone = phones,
    email = mails,
    adresse = adresses
WHERE
    MatriClient = idClient;

ELSEIF type = 'DELETE' THEN
DELETE FROM produits
WHERE
    `produits`.`Matricule` = idClient;

END IF;

END / / DELIMITER / /
-- GESTION  DETAISL ACHATS
DELIMITER / / CREATE PROCEDURE gestion_det_achat (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codedetail varchar(14),
    in produits_code varchar(14),
    in PA_unitaire decimal(10, 4),
    in PVu decimal(10, 4),
    in Quantites int,
    in Facture_achat varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'DE';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    detailfacachat
WHERE
    LEFT (iddeta, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (iddeta, LENGTH (iddeta) - 10)) INTO counter
FROM
    detailfacachat
WHERE
    LEFT (iddeta, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    detailfacachat (
        Iddeta,
        Produit,
        Quantite,
        PaUni,
        FactureAchat,
        Pvun
    )
VALUES
    (
        primaryKey,
        produits_code,
        Quantites,
        PA_unitaire,
        Facture_achat,
        PVu
    );

ELSEIF type = 'UPDATE' THEN
UPDATE detailfacachat
SET
    Produit = produits_code,
    Quantite = Quantites,
    PaUni = PA_unitaire,
    FactureAchat = Facture_achat,
    Pvun = Pvu
WHERE
    Iddeta = codedetail;

ELSEIF type = 'DELETE' THEN
DELETE FROM detailfacachat
WHERE
    `Iddeta` = codedetail;

END IF;

END / / DELIMITER / /
-- GESTION DETAILS VENTES
DELIMITER / / CREATE PROCEDURE gestion_det_achat (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codedetail varchar(14),
    in produits_code varchar(14),
    in PA_unitaire decimal(10, 4),
    in PVu decimal(10, 4),
    in Quantites int,
    in Facturevente varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'DE';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    detailfactvente
WHERE
    LEFT (Iddeta_vente, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (Iddeta_vente, LENGTH (Iddeta_vente) - 10)) INTO counter
FROM
    detailfactvente
WHERE
    LEFT (Iddeta_vente, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    detailfactvente (
        Iddeta_vente,
        Produit,
        Quantite,
        PaUni,
        Facturevente,
        Pvun
    )
VALUES
    (
        primaryKey,
        produits_code,
        Quantites,
        PA_unitaire,
        Facturevente,
        PVu
    );

ELSEIF type = 'UPDATE' THEN
UPDATE detailfactvente
SET
    Produit = produits_code,
    Quantite = Quantites,
    PaUni = PA_unitaire,
    Facturevente = Facturevente,
    Pvun = Pvu
WHERE
    Iddeta_vente = codedetail;

ELSEIF type = 'DELETE' THEN
DELETE FROM detailfactvente
WHERE
    `Iddeta_vente` = codedetail;

END IF;

END / / DELIMITER / /
-- GESTION DETAIL VENTES
DELIMITER / / CREATE PROCEDURE gestion_det_vente (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codedetail varchar(14),
    in produits_code varchar(14),
    in PA_unitaire decimal(10, 4),
    in PVu decimal(10, 4),
    in Quantites int,
    in Facturevente varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'DE';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    detailfactvente
WHERE
    LEFT (Iddeta_vente, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (Iddeta_vente, LENGTH (Iddeta_vente) - 10)) INTO counter
FROM
    detailfactvente
WHERE
    LEFT (Iddeta_vente, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    detailfactvente (
        Iddeta_vente,
        Produit,
        Quantite,
        PaUni,
        Facturevente,
        Pvun
    )
VALUES
    (
        primaryKey,
        produits_code,
        Quantites,
        PA_unitaire,
        Facturevente,
        PVu
    );

ELSEIF type = 'UPDATE' THEN
UPDATE detailfactvente
SET
    Produit = produits_code,
    Quantite = Quantites,
    PaUni = PA_unitaire,
    Facturevente = Facturevente,
    Pvun = Pvu
WHERE
    Iddeta_vente = codedetail;

ELSEIF type = 'DELETE' THEN
DELETE FROM detailfactvente
WHERE
    `Iddeta_vente` = codedetail;

END IF;

END / / DELIMITER / /
-- GESTION FACTURE FOURNISSEURS
DELIMITER / / CREATE PROCEDURE Gestion_fourni (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codefourni varchar(14),
    in nom varchar(50),
    in Prenom varchar(20),
    in email varchar(20),
    in teelphone varchar(20),
    in adresse varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'FOU';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    fournisseurs
WHERE
    LEFT (MatriFourni, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (MatriFourni, LENGTH (MatriFourni) - 10)) INTO counter
FROM
    fournisseurs
WHERE
    LEFT (MatriFourni, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    fournisseurs (
        MatriFourni,
        nom,
        prenom,
        Email,
        Telephone,
        Adresse
    )
VALUES
    (
        primaryKey,
        nom,
        Prenom,
        email,
        teelphone,
        adresse
    );

ELSEIF type = 'UPDATE' THEN
UPDATE fournisseurs
SET
    nom = nom,
    prenom = prenom,
    Email = email,
    Telephone = teelphone,
    Adresse = Adresse
WHERE
    MatriFourni = codefourni;

ELSEIF type = 'DELETE' THEN
DELETE FROM fournisseurs
WHERE
    `MatriFourni` = codefourni;

END IF;

END / / DELIMITER / /
-- GESTION PAY
DELIMITER / / CREATE PROCEDURE gestion_pay_client (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codePay varchar(14),
    in Mode_payement varchar(50),
    in Montant_Paye decimal(10, 4),
    in Operation varchar(50),
    in Facture_Vente varchar(14),
    in DEVISE varchar(14)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'PAY';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    pay_client
WHERE
    LEFT (MatriPay_client, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(
        RIGHT (MatriPay_client, LENGTH (MatriPay_client) - 10)
    ) INTO counter
FROM
    pay_client
WHERE
    LEFT (MatriPay_client, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    pay_client (
        MatriPay_client,
        Mode_payement,
        Facture_Vente,
        Montant_Paye,
        DEVISE,
        Operation
    )
VALUES
    (
        primaryKey,
        Mode_payement,
        Facture_Vente,
        Montant_Paye,
        DEVISE,
        Operation
    );

ELSEIF type = 'UPDATE' THEN
UPDATE pay_client
SET
    Mode_payement = Mode_payement,
    Facture_Vente = Facture_Vente,
    PaUni = Montant_Paye,
    DEVISE = DEVISE,
    Operation = Operation
WHERE
    MatriPay_client = codePay;

ELSEIF type = 'DELETE' THEN
DELETE FROM pay_client
WHERE
    `MatriPay_client` = codePay;

END IF;

END / / DELIMITER / /
-- gestion facture achat
DELIMITER / / CREATE PROCEDURE gestion_fact_achat (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codefacture varchar(14),
    in Fournisseurs varchar(50),
    in dates varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'PAY';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    factureachat
WHERE
    LEFT (IdFacture, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (IdFacture, LENGTH (IdFacture) - 10)) INTO counter
FROM
    factureachat
WHERE
    LEFT (IdFacture, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    factureachat (IdFacture, Fournisseurs, dateFacturation)
VALUES
    (primaryKey, Fournisseurs, dates);

ELSEIF type = 'UPDATE' THEN
UPDATE factureachat
SET
    Fournisseurs = Fournisseurs,
    dateFacturation = dates
WHERE
    IdFacture = codefacture;

ELSEIF type = 'DELETE' THEN
DELETE FROM factureachat
WHERE
    `IdFacture` = codefacture;

END IF;

END / / DELIMITER / /
-- GESTION FACTURE VENTE
DELIMITER / / CREATE PROCEDURE gestion_fact_vente (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in coteVente varchar(14),
    in client varchar(50),
    in date_facture varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'VEN';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    facture_vente
WHERE
    LEFT (MatriculeVente, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(
        RIGHT (MatriculeVente, LENGTH (MatriculeVente) - 10)
    ) INTO counter
FROM
    facture_vente
WHERE
    LEFT (MatriculeVente, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    facture_vente (MatriculeVente, client, date_facture)
VALUES
    (primaryKey, client, date_facture);

ELSEIF type = 'UPDATE' THEN
UPDATE facture_vente
SET
    client = client,
    date_facture = date_facture
WHERE
    MatriculeVente = coteVente;

ELSEIF type = 'DELETE' THEN
DELETE FROM facture_vente
WHERE
    `MatriculeVente` = coteVente;

END IF;

END / / DELIMITER / /
-- create TABLE gestion produits
DELIMITER / / CREATE PROCEDURE gestion_produit (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in codeproduit varchar(14),
    in designation text,
    in unite varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'VEN';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    produits
WHERE
    LEFT (Matricule_produit, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(
        RIGHT (
            Matricule_produit,
            LENGTH (Matricule_produit) - 10
        )
    ) INTO counter
FROM
    produits
WHERE
    LEFT (Matricule_produit, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    produits (Matricule_produit, designation, unite)
VALUES
    (primaryKey, designation, unite);

ELSEIF type = 'UPDATE' THEN
UPDATE produits
SET
    designation = designation,
    unite = unite
WHERE
    Matricule_produit = codeproduit;

ELSEIF type = 'DELETE' THEN
DELETE FROM produits
WHERE
    `Matricule_produit` = codeproduit;

END IF;

END / / DELIMITER / /
-- GESTION DEVISE
DELIMITER / / CREATE PROCEDURE gestion_devise (
    IN type ENUM ('INSERT', 'UPDATE', 'DELETE'),
    in CodeDevise varchar(14),
    in designation text,
    in taux varchar(20)
) BEGIN DECLARE prefix VARCHAR(8);

-- Modified prefix length to accommodate month
DECLARE year VARCHAR(4);

DECLARE month VARCHAR(2);

DECLARE counter INT;

DECLARE primaryKey VARCHAR(14);

-- Adjusted to accommodate prefix, year, month, and counter
if type = 'INSERT' THEN
SET
    prefix = 'DEV';

-- Préfixe de la clé primaire
SET
    year = YEAR (CURDATE ());

SET
    month = LPAD (MONTH (CURDATE ()), 2, '0');

-- Retrieve and pad current month
SET
    counter = 1;

-- Vérifier si une clé primaire avec le préfixe, l'année, et le mois existe déjà
SELECT
    COUNT(*) INTO counter
FROM
    Devise
WHERE
    LEFT (idDevise, 10) = CONCAT (prefix, year, month);

IF counter > 0 THEN
-- Récupérer le dernier numéro utilisé dans la clé primaire
SELECT
    MAX(RIGHT (idDevise, LENGTH (idDevise) - 10)) INTO counter
FROM
    Devise
WHERE
    LEFT (idDevise, 10) = CONCAT (prefix, year, month);

SET
    counter = counter + 1;

END IF;

-- Générer la clé primaire finale
SET
    primaryKey = CONCAT (prefix, year, month, LPAD (counter, 4, '0'));

INSERT INTO
    Devise (idDevise, designation, taux)
VALUES
    (primaryKey, designation, taux);

ELSEIF type = 'UPDATE' THEN
UPDATE Devise
SET
    designation = designation,
    taux = taux
WHERE
    idDevise = CodeDevise;

ELSEIF type = 'DELETE' THEN
DELETE FROM Devise
WHERE
    `idDevise` = CodeDevise;

END IF;

END / / DELIMITER / /