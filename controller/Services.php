<?php
require('../model/db_connection.php');
require('../model/Services.php');

$data = new Services();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODESERVICES(NULL);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setDESCRIPTION(ucfirst($_POST['description']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_SERVICES();
        header('location:../Services.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Services.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODESERVICES($_POST['codeservices']);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setDESCRIPTION(ucfirst($_POST['description']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_SERVICES();
        header('location:../Services.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}
