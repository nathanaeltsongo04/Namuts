<?php
require('../model/db_connection.php');
require('../model/Categories.php');

$data = new Categories();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODECATEGORIE(NULL);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_CATEGORIE();
        header('location:../Catégories.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Catégories.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODECATEGORIE($_POST['codecategorie']);
        $data->setDESIGNATION(ucwords($_POST['designation']));
        $data->setAuteur(ucwords($auteur));
        $data->GESTION_CATEGORIE();
        header('location:../Catégories.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}
