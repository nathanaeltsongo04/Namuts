<?php
class Utilisateur
{
    private $OPERATION;
    private $MATRICULE;
    private $NOM;
    private $POSTNOM;
    private $PRENOM;
    private $CONTACT;
    private $EMAIL;
    private $ADDRESSE;
    private $SERVICES;
    private $PHOTO;


    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getMATRICULE()
    {
        return $this->MATRICULE;
    }

    public function setMATRICULE($value)
    {
        $this->MATRICULE = $value;
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

    public function getCONTACT()
    {
        return $this->CONTACT;
    }

    public function setCONTACT($value)
    {
        $this->CONTACT = $value;
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

    public function getSERVICES()
    {
        return $this->SERVICES;
    }

    public function setSERVICES($value)
    {
        $this->SERVICES = $value;
    }

    public function getPHOTO()
    {
        return $this->PHOTO;
    }

    public function setPHOTO($value)
    {
        $this->PHOTO = $value;
    }

    public function afficher()
    {
        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" SELECT * FROM VIEW_UTILISATEUR ");
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
            $stmt = $connect->prepare(" SELECT * FROM VIEW_UTILISATEUR WHERE MATRICULE=? ");
            $stmt->bindParam(1, $this->MATRICULE, PDO::PARAM_STR);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $con->closeConnection(); // Fermeture de la connexion
            return $result;
        } catch (PDOException $e) {
            throw new Exception("Erreur lors de l'exécution de la requête : " . $e->getMessage());
        }
    }

    public function GESTION_UTILISATEUR()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare(" CALL GESTION_UTILISATEURS(?,?,?,?,?) ");

            // Liaison des valeurs aux marqueurs de paramètres
            $stmt->bindParam(1, $this->OPERATION, PDO::PARAM_STR);
            $stmt->bindParam(2, $this->MATRICULE, PDO::PARAM_STR);
            $stmt->bindParam(3, $this->NOM, PDO::PARAM_STR);
            $stmt->bindParam(4, $this->POSTNOM, PDO::PARAM_STR);
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
