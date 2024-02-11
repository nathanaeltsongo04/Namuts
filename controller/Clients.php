<?php
require('../model/db_connection.php');
require('../model/Clients.php');

$data = new Clients();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODECLIENTS(NULL);
        $data->setNOM(ucwords($_POST['nom']));
        $data->setPOSTNOM(ucwords($_POST['postnom']));
        $data->setPRENOM(ucwords($_POST['prenom']));
        $data->setCONTACT(ucwords($_POST['contact']));
        $data->setEMAIL(strtolower($_POST['email']));
        $data->setADDRESSE(ucwords($_POST['addresse']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_CLIENTS();
        header('location:../Clients.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Clients.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODECLIENTS($_POST['codeclients']);
        $data->setNOM(ucwords($_POST['nom']));
        $data->setPOSTNOM(ucwords($_POST['postnom']));
        $data->setPRENOM(ucwords($_POST['prenom']));
        $data->setCONTACT(ucwords($_POST['contact']));
        $data->setEMAIL(strtolower($_POST['email']));
        $data->setADDRESSE(ucwords($_POST['addresse']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_CLIENTS();
        header('location:../Clients.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}