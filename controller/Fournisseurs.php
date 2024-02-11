<?php
require('../model/db_connection.php');
require('../model/Fournisseurs.php');

$data = new Fournisseurs();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODEFOURNISSEURS(NULL);
        $data->setNOM(ucwords($_POST['nom']));
        $data->setPOSTNOM(ucwords($_POST['postnom']));
        $data->setPRENOM(ucwords($_POST['prenom']));
        $data->setTELEPHONE(ucwords($_POST['telephone']));
        $data->setEMAIL(strtolower($_POST['email']));
        $data->setADDRESSE(ucwords($_POST['addresse']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_FOURNISSEURS();
        header('location:../Fournisseurs.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Fournisseurs.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODEFOURNISSEURS($_POST['codefournisseurs']);
        $data->setNOM(ucwords($_POST['nom']));
        $data->setPOSTNOM(ucwords($_POST['postnom']));
        $data->setPRENOM(ucwords($_POST['prenom']));
        $data->setTELEPHONE(ucwords($_POST['telephone']));
        $data->setEMAIL(strtolower($_POST['email']));
        $data->setADDRESSE(ucwords($_POST['addresse']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_FOURNISSEURS();
        header('location:../Fournisseurs.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}
