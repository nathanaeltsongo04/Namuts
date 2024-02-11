<?php
class Services
{
    private $OPERATION;
    private $CODESERVICES;
    private $DESIGNATION;
    private $DESCRIPTION;
    private $AUTEUR;


    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getCODESERVICES()
    {
        return $this->CODESERVICES;
    }

    public function setCODESERVICES($value)
    {
        $this->CODESERVICES = $value;
    }

    public function getDESIGNATION()
    {
        return $this->DESIGNATION;
    }

    public function setDESIGNATION($value)
    {
        $this->DESIGNATION = $value;
    }

    public function getDESCRIPTION()
    {
        return $this->DESCRIPTION;
    }

    public function setDESCRIPTION($value)
    {
        $this->DESCRIPTION = $value;
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
            $stmt = $connect->prepare(" SELECT * FROM SERVICES ");
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
            $stmt = $connect->prepare(" SELECT * FROM SERVICES WHERE CODESERVICES=? ");
            $stmt->bindParam(1, $this->CODESERVICES, PDO::PARAM_INT);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $con->closeConnection(); // Fermeture de la connexion
            return $result;
        } catch (PDOException $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }


    public function GESTION_SERVICES()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" CALL GESTION_SERVICES(?,?,?,?,?) ");

            // Liaison des valeurs aux marqueurs de paramètres
            $stmt->bindParam(1, $this->OPERATION, PDO::PARAM_STR);
            $stmt->bindParam(2, $this->CODESERVICES, PDO::PARAM_STR);
            $stmt->bindParam(3, $this->DESIGNATION, PDO::PARAM_STR);
            $stmt->bindParam(4, $this->DESCRIPTION, PDO::PARAM_STR);
            $stmt->bindParam(5, $this->AUTEUR, PDO::PARAM_STR);

            // Exécution de la procédure stockée
            $stmt->execute();

            // Fermeture de la connexion
            $con->closeconnection();
        } catch (Exception $e) {

            // Gestion des erreurs : utilisez plutôt une logique appropriée, par exemple, journalisation ou renvoi d'une exception
            return $e->getMessage();
        }
    }
}