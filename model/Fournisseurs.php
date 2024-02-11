<?php
class Fournisseurs
{
    private $OPERATION;
    private $CODEFOURNISSEURS;
    private $NOM;
    private $POSTNOM;
    private $PRENOM;
    private $TELEPHONE;
    private $EMAIL;
    private $ADDRESSE;
    private $AUTEUR;


    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getCODEFOURNISSEURS()
    {
        return $this->CODEFOURNISSEURS;
    }

    public function setCODEFOURNISSEURS($value)
    {
        $this->CODEFOURNISSEURS = $value;
    }

    public function getNOM()
    {
        return $this->NOM;
    }

    public function setNOM($value)
    {
        $this->NOM = $value;
    }

    public function getPOSTNOM()
    {
        return $this->POSTNOM;
    }

    public function setPOSTNOM($value)
    {
        $this->POSTNOM = $value;
    }

    public function getPRENOM()
    {
        return $this->PRENOM;
    }

    public function setPRENOM($value)
    {
        $this->PRENOM = $value;
    }

    public function getTELEPHONE()
    {
        return $this->TELEPHONE;
    }

    public function setTELEPHONE($value)
    {
        $this->TELEPHONE = $value;
    }

    public function getEMAIL()
    {
        return $this->EMAIL;
    }

    public function setEMAIL($value)
    {
        $this->EMAIL = $value;
    }

    public function getADDRESSE()
    {
        return $this->ADDRESSE;
    }

    public function setADDRESSE($value)
    {
        $this->ADDRESSE = $value;
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
            $stmt = $connect->prepare(" SELECT * FROM FOURNISSEURS ");
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
            $stmt = $connect->prepare(" SELECT * FROM FOURNISSEURS WHERE CODEFOURNISSEUR=? ");
            $stmt->bindParam(1, $this->CODEFOURNISSEURS, PDO::PARAM_STR);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $con->closeConnection(); // Fermeture de la connexion
            return $result;
        } catch (PDOException $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }


    public function GESTION_FOURNISSEURS()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" CALL GESTION_FOURNISSEURS(?,?,?,?,?,?,?,?,?) ");

            // Liaison des valeurs aux marqueurs de paramètres
            $stmt->bindParam(1, $this->OPERATION, PDO::PARAM_STR);
            $stmt->bindParam(2, $this->CODEFOURNISSEURS, PDO::PARAM_STR);
            $stmt->bindParam(3, $this->NOM, PDO::PARAM_STR);
            $stmt->bindParam(4, $this->POSTNOM, PDO::PARAM_STR);
            $stmt->bindParam(5, $this->PRENOM, PDO::PARAM_STR);
            $stmt->bindParam(6, $this->TELEPHONE, PDO::PARAM_STR);
            $stmt->bindParam(7, $this->EMAIL, PDO::PARAM_STR);
            $stmt->bindParam(8, $this->ADDRESSE, PDO::PARAM_STR);
            $stmt->bindParam(9, $this->AUTEUR, PDO::PARAM_STR);



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