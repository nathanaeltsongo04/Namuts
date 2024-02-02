<?php
class unites
{
    private $OPERATION;
    private $CODEUNITE;
    private $DESIGNATION;
    private $SIGLE;
    private $AUTEUR;

    public function getOPERATION()
    {
        return $this->OPERATION;
    }

    public function setOPERATION($value)
    {
        $this->OPERATION = $value;
    }

    public function getCODEUNITE()
    {
        return $this->CODEUNITE;
    }

    public function setCODEUNITE($value)
    {
        $this->CODEUNITE = $value;
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

    public function getAUTEUR()
    {
        return $this->AUTEUR;
    }

    public function setAUTEUR($value)
    {
        $this->AUTEUR = $value;
    }

    public function GESTION_UNITE()
    {

        $con = new db_connection();
        $connect = $con->openconnection();
        try {
            $stmt = $connect->prepare("CALL GESTION_UNITE(?,?,?,?,?)");
            $stmt->execute([$this->OPERATION, $this->CODEUNITE, $this->DESIGNATION, $this->SIGLE, $this->AUTEUR]);
            $con->closeconnection();
        } catch (Exception $e) {
            return $this->$e;
        }
    }
}