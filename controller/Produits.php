<?php
require('../model/db_connection.php');
require('../model/Produits.php');

$data = new Produits();
//$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    if ($_POST['codeunites'] == '' || $_POST['codecategorie'] == '') {

        header('location:../Produits.php?msg=true&info=Unité ou Catégorie invalide');
    } else {
        try {
            $data->setOPERATION('INSERT');
            $data->setCODEPRODUITS(NULL);
            $data->setDESIGNATION(ucwords($_POST['designation']));
            $data->setUNITE($_POST['codeunites']);
            $data->setCATEGORIE($_POST['codecategorie']);
            $data->setAuteur(ucwords($auteur));
            $data->GESTION_PRODUITS();
            header('location:../Produits.php?msg=true&info=Added Successfully');
        } catch (Exception $e) {
            return $e;
        }
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Unités.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    if ($_POST['codeunites'] == '' || $_POST['codecategorie'] == '') {

        header('location:../Produits.php?msg=true&info=Unité ou Catégorie invalide');
    } else {
        try {
            $data->setOPERATION('UPDATE');
            $data->setCODEPRODUITS($_POST['codeproduits']);
            $data->setDESIGNATION(ucwords($_POST['designation']));
            $data->setUNITE($_POST['codeunites']);
            $data->setCATEGORIE($_POST['codecategorie']);
            $data->setAuteur(ucwords($auteur));
            $data->GESTION_PRODUITS();
            header('location:../Produits.php?msg=true&info=Updated Successfully');
        } catch (Exception $e) {
            return $e;
        }
    }
}
