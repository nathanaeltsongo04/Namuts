<?php
require('../model/db_connection.php');
require('../model/Unites.php');

$data = new unites();
$auteur = $_SESSION['postnom'] . " " . $_SESSION['prenom'];

if (isset($_POST['save'])) {
    try {
        $data->setOPERATION('INSERT');
        $data->setCODEUNITE(NULL);
        $data->setDESIGNATION($_POST['designation']);
        $data->setSIGLE($_POST['sigle']);
        $data->setAuteur($auteur);
        $data->GESTION_UNITE();
        header('location:../Unités.php?msg=true&info=Added Successfully');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_GET['supprimer'])) {
    try {

        header('location:../Unités.php?msg=true&info=Deleted Successful');
    } catch (Exception $e) {
        return $e;
    }
} elseif (isset($_POST['update'])) {
    try {
        $data->setOPERATION('UPDATE');
        $data->setCODEUNITE($_POST['codeunite']);
        $data->setDESIGNATION($_POST['designation']);
        $data->setSIGLE($_POST['sigle']);
        $data->setAuteur($auteur);
        $data->GESTION_UNITE();
        header('location:../Unités.php?msg=true&info=Updated Successfully');
    } catch (Exception $e) {
        return $e;
    }
}
