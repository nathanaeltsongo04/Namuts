<?php

class db_connection
{

    private $server = "mysql:host=localhost;dbname=NAMUTS_DB;port=3306";
    private $username = "root";
    private $password = "";
    private $options  = array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,);
    protected $conn;

    public function openconnection()
    {
        try {
            $this->conn = new PDO($this->server, $this->username, $this->password);
            return $this->conn;
        } catch (PDOException $e) {
            $msg = "erreur dans +" . $e->getMessage();
            die($msg);
        }
    }

    public function closeconnection()
    {
        $this->conn = null;
    }
}

$pdo = new db_connection();