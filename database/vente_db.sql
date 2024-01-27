-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 27 jan. 2024 à 19:49
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vente_db`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Gestion_depot` (IN `MatricProduits` VARCHAR(14), IN `quantite` INT, IN `type_operation` ENUM('ENTREE','SORTIE','RETOUR'), IN `PAu` FLOAT, IN `Prix_vente` INT)   BEGIN
    DECLARE stock_actuel INT;
    declare prix_actuel float;
    declare PT_entree float;
    DECLARE Prix_total float;
    declare SFentree int;
    	declare SFPrix float;
    	declare CUMP float;
        DECLARE prix_tmp float;
         DECLARE prix_achat_actuel double;
    DECLARE stock_disp int;
    
     DECLARE produit_id varchar(14);
    DECLARE cle_produit varchar(14);
    -- Récupérer la quantité en stock actuelle du produit
    set produit_id=MatricProduits;
    set PT_entree = quantite*PAu;
    -- dec
    
    -- IDPRODUITS
    IF type_operation = 'ENTREE' THEN  
        SELECT `produit` into produit_id FROM `depot` WHERE produit=MatricProduits
        LIMIT 1;
    ELSEIF type_operation = 'SORTIE' THEN
    	SELECT `produit` into produit_id FROM `depot` WHERE produit=MatricProduits
        LIMIT 1;
    ELSEIF type_operation='RETOUR' THEN
     SELECT `produit` INTO produit_id FROM `depot` WHERE produit=tmpid
     LIMIT 1;
    END IF;
    -- stock actuel
    
    SELECT Stock_dispo INTO stock_actuel FROM depot
    WHERE produit = produit_id;
    -- ID DE PRODUIT
    SELECT produit INTO cle_produit FROM depot
    WHERE produit = produit_id;
    
     -- prix actuel
    SELECT PAm into prix_actuel from depot 
    where produit = produit_id;  
    -- TESTER LES VALEURS
    if prix_actuel is null THEN
    	set prix_actuel=0;
    end if;
    if stock_actuel is null THEN
    	set stock_actuel=0;
    end if;
    -- prix total actuel      
    
    SELECT Stock_dispo into stock_disp FROM depot 
    WHERE produit=produit_id;
      SELECT PAm into prix_achat_actuel FROM depot 
    WHERE produit=produit_id;
    
    if prix_achat_actuel is null THEN
    	set prix_achat_actuel=0;
    end if;
     if stock_disp is null THEN
    	set stock_disp=0;
    end if;
    SET Prix_total=prix_achat_actuel*stock_disp;
    -- ISNULL
    
        
    -- Vérifier le type d'opération et mettre à jour la quantité en stock
    IF type_operation = 'ENTREE' THEN
    	set SFentree =stock_actuel+quantite;
    	set SFPrix =Prix_total+PT_entree;
    	set CUMP =SFPrix/SFentree;
     	SET stock_actuel = stock_actuel + quantite;         
       	set prix_actuel=CUMP;
        set prix_tmp=PAu;
        if cle_produit is null THEN
        	INSERT INTO `depot` (`produit`, `PAm`, `PVu`, `Stock_dispo`, `Etat_stock`) VALUES (produit_id, 0, 0, 0, 'DISPO');
        END IF;
        UPDATE depot SET Stock_dispo = stock_actuel, Pvu=Prix_vente,PAm=prix_actuel	WHERE produit = produit_id;    
    ELSEIF type_operation = 'SORTIE' THEN
        SET stock_actuel = stock_actuel - quantite;
        set prix_tmp=prix_actuel;        
        UPDATE depot SET Stock_dispo = stock_actuel WHERE produit = produit_id; 
    ELSEIF type_operation = 'RETOUR' THEN
        SET stock_actuel = stock_actuel - quantite;
        set prix_tmp=prix_actuel;        
        UPDATE depot SET Stock_dispo = stock_actuel WHERE produit = produit_id;     
    END IF;
        
    -- Insérer un enregistrement dans la table des transactions de stock
    INSERT INTO mouvement_depot (produit, quantite, type_operation,PU,reste_quantite)
    VALUES (produit_id, quantite, type_operation,prix_tmp,stock_actuel);
    
    -- Afficher un message de confirmation
    SELECT CONCAT('Quantité en stock mise à jour : ', stock_actuel) AS message;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `gestion_magasin` (IN `MatricProduits` VARCHAR(14), IN `quantite` INT, IN `type_operation` ENUM('ENTREE','SORTIE','RETOUR'), IN `PAu` FLOAT, IN `Prix_vente` FLOAT)   BEGIN
    DECLARE stock_actuel INT;
    declare prix_actuel float;
    declare PT_entree float;
    DECLARE Prix_total float;
    declare SFentree int;
    	declare SFPrix float;
    	declare CUMP float;
        DECLARE prix_tmp float;
         DECLARE prix_achat_actuel double;
    DECLARE stock_disp int;
    
     DECLARE produit_id varchar(14);
    DECLARE cle_produit varchar(14);
    -- Récupérer la quantité en stock actuelle du produit
    set produit_id=MatricProduits;
    set PT_entree = quantite*PAu;
    -- dec
    
    -- IDPRODUITS
    IF type_operation = 'ENTREE' THEN  
        SELECT `produit` into produit_id FROM `magasin` WHERE produit=MatricProduits
        LIMIT 1;
    ELSEIF type_operation = 'SORTIE' THEN
    	SELECT `produit` into produit_id FROM `magasin` WHERE produit=MatricProduits
        LIMIT 1;
    ELSEIF type_operation='RETOUR' THEN
     SELECT `produit` INTO produit_id FROM `magasin` WHERE produit=tmpid
     LIMIT 1;
    END IF;
    -- stock actuel
    
    SELECT Stock_dispo INTO stock_actuel FROM magasin
    WHERE produit = produit_id;
    -- ID DE PRODUIT
    SELECT produit INTO cle_produit FROM magasin
    WHERE produit = produit_id;
    
     -- prix actuel
    SELECT PAm into prix_actuel from magasin 
    where produit = produit_id;  
    -- TESTER LES VALEURS
    if prix_actuel is null THEN
    	set prix_actuel=0;
    end if;
    if stock_actuel is null THEN
    	set stock_actuel=0;
    end if;
    -- prix total actuel      
    
    SELECT Stock_dispo into stock_disp FROM magasin 
    WHERE produit=produit_id;
      SELECT PAm into prix_achat_actuel FROM magasin 
    WHERE produit=produit_id;
    
    if prix_achat_actuel is null THEN
    	set prix_achat_actuel=0;
    end if;
     if stock_disp is null THEN
    	set stock_disp=0;
    end if;
    SET Prix_total=prix_achat_actuel*stock_disp;
    -- ISNULL
    
        
    -- Vérifier le type d'opération et mettre à jour la quantité en stock
    IF type_operation = 'ENTREE' THEN
    	set SFentree =stock_actuel+quantite;
    	set SFPrix =Prix_total+PT_entree;
    	set CUMP =SFPrix/SFentree;
     	SET stock_actuel = stock_actuel + quantite;         
       	set prix_actuel=CUMP;
        set prix_tmp=PAu;
        if cle_produit is null THEN
        	INSERT INTO `magasin` (`produit`, `PAm`, `PVu`, `Stock_dispo`, `Etat_stock`, `idmagasin`) VALUES (produit_id, 0, 0, 0, 0, '');
        END IF;
        UPDATE magasin	SET Stock_dispo = stock_actuel, Pvu=Prix_vente,PAm=prix_actuel	WHERE produit = produit_id;    
    ELSEIF type_operation = 'SORTIE' THEN
        SET stock_actuel = stock_actuel - quantite;
        set prix_tmp=prix_actuel;        
        UPDATE magasin	SET Stock_dispo = stock_actuel WHERE produit = produit_id; 
    ELSEIF type_operation = 'RETOUR' THEN
        SET stock_actuel = stock_actuel + quantite;
        set prix_tmp=prix_actuel;        
        UPDATE magasin	SET Stock_dispo = stock_actuel WHERE produit = produit_id;     
    END IF;
        
    -- Insérer un enregistrement dans la table des transactions de stock
    INSERT INTO mouvement_magasin (produit, quantite, type_operation,PU,reste_quantite)
    VALUES (produit_id, quantite, type_operation,prix_tmp,stock_actuel);
    
    -- Afficher un message de confirmation
    SELECT CONCAT('Quantité en stock mise à jour : ', stock_actuel) AS message;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `MatriClient` varchar(14) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Telephone` varchar(20) DEFAULT NULL,
  `Adresse` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `depot`
--

CREATE TABLE `depot` (
  `produit` varchar(14) DEFAULT NULL,
  `PAm` decimal(10,4) DEFAULT NULL,
  `PVu` decimal(10,4) DEFAULT NULL,
  `Stock_dispo` int(11) DEFAULT NULL,
  `Etat_stock` varchar(255) DEFAULT NULL,
  `iddepot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `depot`
--

INSERT INTO `depot` (`produit`, `PAm`, `PVu`, `Stock_dispo`, `Etat_stock`, `iddepot`) VALUES
('0', 4.5000, 5.0000, 10, 'DISPO', 2),
('PRO_1', 4.5000, 5.0000, 10, 'DISPO', 3);

-- --------------------------------------------------------

--
-- Structure de la table `detailfacachat`
--

CREATE TABLE `detailfacachat` (
  `Iddeta` varchar(14) NOT NULL,
  `Produit` varchar(14) DEFAULT NULL,
  `Quantite` varchar(14) DEFAULT NULL,
  `PaUni` decimal(10,4) DEFAULT NULL,
  `FactureAchat` varchar(14) DEFAULT NULL,
  `Pvun` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `detailfactvente`
--

CREATE TABLE `detailfactvente` (
  `Iddeta_vente` varchar(14) NOT NULL,
  `Produit` varchar(14) DEFAULT NULL,
  `Quantite` varchar(14) DEFAULT NULL,
  `PaUni` decimal(10,4) DEFAULT NULL,
  `FactureAchat` varchar(14) DEFAULT NULL,
  `Pvun` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `devise`
--

CREATE TABLE `devise` (
  `idDevise` varchar(14) NOT NULL,
  `designation` varchar(20) DEFAULT NULL,
  `taux` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `factureachat`
--

CREATE TABLE `factureachat` (
  `IdFacture` varchar(14) NOT NULL,
  `dateFacturation` date DEFAULT NULL,
  `Fournisseurs` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `facture_vente`
--

CREATE TABLE `facture_vente` (
  `MatriculeVente` varchar(11) NOT NULL,
  `date_facture` date DEFAULT NULL,
  `client` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

CREATE TABLE `fournisseurs` (
  `MatriFourni` varchar(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Telephone` varchar(20) DEFAULT NULL,
  `Adresse` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `magasin`
--

CREATE TABLE `magasin` (
  `produit` varchar(14) DEFAULT NULL,
  `PAm` decimal(10,4) DEFAULT NULL,
  `PVu` decimal(10,4) DEFAULT NULL,
  `Stock_dispo` int(11) DEFAULT NULL,
  `Etat_stock` varchar(255) DEFAULT NULL,
  `idmagasin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `magasin`
--

INSERT INTO `magasin` (`produit`, `PAm`, `PVu`, `Stock_dispo`, `Etat_stock`, `idmagasin`) VALUES
('PRO_1', 1.1250, NULL, 40, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `mouvement_depot`
--

CREATE TABLE `mouvement_depot` (
  `id` int(11) NOT NULL,
  `produit` varchar(14) DEFAULT NULL,
  `quantite` int(11) NOT NULL,
  `type_operation` enum('ENTREE','SORTIE','RETOUR') NOT NULL,
  `date_operation` datetime DEFAULT current_timestamp(),
  `PU` decimal(10,2) NOT NULL,
  `reste_quantite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `mouvement_depot`
--

INSERT INTO `mouvement_depot` (`id`, `produit`, `quantite`, `type_operation`, `date_operation`, `PU`, `reste_quantite`) VALUES
(1, '0', 10, 'ENTREE', '2024-01-27 09:34:34', 4.50, 10),
(2, '0', 10, 'ENTREE', '2024-01-27 09:42:01', 4.50, 10),
(3, 'PRO_1', 10, 'ENTREE', '2024-01-27 09:44:31', 4.50, 10);

-- --------------------------------------------------------

--
-- Structure de la table `mouvement_magasin`
--

CREATE TABLE `mouvement_magasin` (
  `id` int(11) NOT NULL,
  `produit` varchar(14) DEFAULT NULL,
  `quantite` int(11) NOT NULL,
  `type_operation` enum('ENTREE','SORTIE','RETOUR') NOT NULL,
  `date_operation` datetime DEFAULT current_timestamp(),
  `PU` decimal(10,2) NOT NULL,
  `reste_quantite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `mouvement_magasin`
--

INSERT INTO `mouvement_magasin` (`id`, `produit`, `quantite`, `type_operation`, `date_operation`, `PU`, `reste_quantite`) VALUES
(2, 'PRO_1', 10, 'ENTREE', '2024-01-27 07:22:44', 4.50, 10),
(3, 'PRO_1', 10, 'ENTREE', '2024-01-27 07:33:13', 4.50, 10),
(4, 'PRO_1', 10, 'ENTREE', '2024-01-27 07:41:53', 4.50, 20),
(5, 'PRO_1', 10, 'ENTREE', '2024-01-27 07:47:06', 4.50, 30),
(6, 'PRO_1', 10, 'ENTREE', '2024-01-27 09:06:50', 4.50, 40);

-- --------------------------------------------------------

--
-- Structure de la table `pay_client`
--

CREATE TABLE `pay_client` (
  `MatriPay_client` varchar(14) NOT NULL,
  `Mode_payement` varchar(50) DEFAULT NULL,
  `Montant_Paye` decimal(10,4) DEFAULT NULL,
  `Operation` varchar(30) DEFAULT NULL,
  `Facture_Vente` varchar(14) DEFAULT NULL,
  `DEVISE` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pay_fournisseur`
--

CREATE TABLE `pay_fournisseur` (
  `MatriPay` varchar(14) NOT NULL,
  `Mode_payement` varchar(50) DEFAULT NULL,
  `Montant_Paye` decimal(10,4) DEFAULT NULL,
  `Operation` varchar(30) DEFAULT NULL,
  `FactureAchat` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `Matricule` varchar(14) NOT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `unite` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`Matricule`, `designation`, `unite`) VALUES
('PRO_1', 'Barre 18 mm', 'Piece');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`MatriClient`);

--
-- Index pour la table `depot`
--
ALTER TABLE `depot`
  ADD PRIMARY KEY (`iddepot`);

--
-- Index pour la table `detailfacachat`
--
ALTER TABLE `detailfacachat`
  ADD PRIMARY KEY (`Iddeta`);

--
-- Index pour la table `detailfactvente`
--
ALTER TABLE `detailfactvente`
  ADD PRIMARY KEY (`Iddeta_vente`);

--
-- Index pour la table `devise`
--
ALTER TABLE `devise`
  ADD PRIMARY KEY (`idDevise`);

--
-- Index pour la table `factureachat`
--
ALTER TABLE `factureachat`
  ADD PRIMARY KEY (`IdFacture`);

--
-- Index pour la table `facture_vente`
--
ALTER TABLE `facture_vente`
  ADD PRIMARY KEY (`MatriculeVente`);

--
-- Index pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD PRIMARY KEY (`MatriFourni`);

--
-- Index pour la table `magasin`
--
ALTER TABLE `magasin`
  ADD PRIMARY KEY (`idmagasin`);

--
-- Index pour la table `mouvement_depot`
--
ALTER TABLE `mouvement_depot`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mouvement_magasin`
--
ALTER TABLE `mouvement_magasin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pay_client`
--
ALTER TABLE `pay_client`
  ADD PRIMARY KEY (`MatriPay_client`);

--
-- Index pour la table `pay_fournisseur`
--
ALTER TABLE `pay_fournisseur`
  ADD PRIMARY KEY (`MatriPay`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`Matricule`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `depot`
--
ALTER TABLE `depot`
  MODIFY `iddepot` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `mouvement_depot`
--
ALTER TABLE `mouvement_depot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `mouvement_magasin`
--
ALTER TABLE `mouvement_magasin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
