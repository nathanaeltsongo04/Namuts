<?php
class Devises
{
    private $OPERATION;
    private $CODEDEVISE;
    private $DESIGNATION;
    private $SIGLE;
    private $TAUX;
    private $SYMBOLE;
    private $AUTEUR;

    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getCODEDEVISE()
    {
        return $this->CODEDEVISE;
    }

    public function setCODEDEVISE($value)
    {
        $this->CODEDEVISE = $value;
    }

    public function getDESIGNATION()
    {
        return $this->DESIGNATION;
    }

    public function setDESIGNATION($value)
    {
        $this->DESIGNATION = $value;
    }

    public function getSIGLE()
    {
        return $this->SIGLE;
    }

    public function setSIGLE($value)
    {
        $this->SIGLE = $value;
    }

    public function getTAUX()
    {
        return $this->TAUX;
    }

    public function setTAUX($value)
    {
        $this->TAUX = $value;
    }

    public function getSYMBOLE()
    {
        return $this->SYMBOLE;
    }

    public function setSYMBOLE($value)
    {
        $this->SYMBOLE = $value;
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
            $stmt = $connect->prepare(" SELECT * FROM DEVISE ");
            $stmt->execute();
            return $stmt->fetchAll();
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
    public function afficherById()
    {
        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" SELECT * FROM DEVISE WHERE CODEDEVISE=? ");
            $stmt->bindParam(1, $this->CODEDEVISE, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    public function GESTION_DEVISE()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" CALL GESTION_DEVISE(?,?,?,?,?,?,?) ");

            // Liaison des valeurs aux marqueurs de paramètres
            $stmt->bindParam(1, $this->OPERATION, PDO::PARAM_STR);
            $stmt->bindParam(2, $this->CODEDEVISE, PDO::PARAM_STR);
            $stmt->bindParam(3, $this->DESIGNATION, PDO::PARAM_STR);
            $stmt->bindParam(4, $this->SIGLE, PDO::PARAM_STR);
            $stmt->bindParam(5, $this->TAUX, PDO::PARAM_STR);
            $stmt->bindParam(6, $this->SYMBOLE, PDO::PARAM_STR);
            $stmt->bindParam(7, $this->AUTEUR, PDO::PARAM_STR);

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
