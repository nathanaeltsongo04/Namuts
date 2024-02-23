<?php
class Produits
{
    private $OPERATION;
    private $CODEPRODUITS;
    private $DESIGNATION;
    private $UNITE;
    private $CATEGORIE;
    private $AUTEUR;

    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getCODEPRODUITS()
    {
        return $this->CODEPRODUITS;
    }

    public function setCODEPRODUITS($value)
    {
        $this->CODEPRODUITS = $value;
    }

    public function getDESIGNATION()
    {
        return $this->DESIGNATION;
    }

    public function setDESIGNATION($value)
    {
        $this->DESIGNATION = $value;
    }

    public function getUNITE()
    {
        return $this->UNITE;
    }

    public function setUNITE($value)
    {
        $this->UNITE = $value;
    }

    public function getCATEGORIE()
    {
        return $this->CATEGORIE;
    }

    public function setCATEGORIE($value)
    {
        $this->CATEGORIE = $value;
    }

    public function getAUTEUR()
    {
        return $this->AUTEUR;
    }

    public function setAUTEUR($value)
    {
        $this->AUTEUR = $value;
    }

    public function afficher()
    {
        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" SELECT * FROM VIEW_PRODUITS ");
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $con->closeConnection(); // Fermeture de la connexion
            return $result;
        } catch (PDOException $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }
    public function afficherById()
    {
        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" SELECT * FROM VIEW_PRODUITS WHERE CODEPRODUITS= ? ");
            $stmt->bindParam(1, $this->CODEPRODUITS, PDO::PARAM_STR);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $con->closeConnection(); // Fermeture de la connexion
            return $result;
        } catch (PDOException $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }

    public function GESTION_PRODUITS()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" CALL GESTION_PRODUITS(?,?,?,?,?,?) ");

            // Liaison des valeurs aux marqueurs de paramètres
            $stmt->bindParam(1, $this->OPERATION, PDO::PARAM_STR);
            $stmt->bindParam(2, $this->CODEPRODUITS, PDO::PARAM_STR);
            $stmt->bindParam(3, $this->DESIGNATION, PDO::PARAM_STR);
            $stmt->bindParam(4, $this->UNITE, PDO::PARAM_STR);
            $stmt->bindParam(5, $this->CATEGORIE, PDO::PARAM_STR);
            $stmt->bindParam(6, $this->AUTEUR, PDO::PARAM_STR);

            // Exécution de la procédure stockée
            $stmt->execute();

            // Fermeture de la connexion
            $con->closeconnection();
        } catch (Exception $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }
}
