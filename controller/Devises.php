<?php
require('../model/db_connection.php');
require('../model/Devises.php');

$data = new devises();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODEDEVISE(NULL);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setSIGLE(strtoupper($_POST['sigle']));
        $data->setTAUX($_POST['taux']);
        $data->setSYMBOLE($_POST['symbole']);
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_DEVISE();
        header('location:../Devises.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Devises.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODEDEVISE($_POST['codedevise']);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setSIGLE(strtoupper($_POST['sigle']));
        $data->setTAUX($_POST['taux']);
        $data->setSYMBOLE($_POST['symbole']);
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_DEVISE();
        header('location:../Devises.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}
