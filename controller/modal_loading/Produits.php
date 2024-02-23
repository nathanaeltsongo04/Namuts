<?php
require('../../model/db_connection.php');
require('../../model/Unites.php');
require('../../model/Categories.php');
require('../../model/Produits.php');

$data = new Produits();
$data->setCODEPRODUITS($_POST['codeproduits']);
$all = $data->afficherById();
$Unitobject = new Unites();
$Unites = $Unitobject->afficher();
$Catobject = new Categories();
$Categorie = $Catobject->afficher();
foreach ($all as $key => $val) {
    echo "
    <div class='row justify-content-center'>
        <div class='col-md-10 mb-4'>
            <input type='hidden' value='" . $_POST['codeproduits'] . "'name='codeproduits'>
            <div class='input-group has-validation'>
                <input type='text' value='" . $val['DESIGNATION'] . "' name='designation' class='form-control' id='yourPassword' placeholder='Désignation' required>
            </div>
        </div>
        <div class='col-md-10 mb-4'>
            <label for='exampleDataList' class='form-label'>Unités</label>
            <input required class='form-control' list='datalistOptions' id='UpdateInput1' name='selectedDesignation' placeholder='Type to search...'>
            <datalist id='datalistOptions'>";
    foreach ($Unites as $unitKey => $unitVal) {
        echo "<option value='" . $unitVal['DESIGNATION'] . "' data-id='" . $unitVal['CODEUNITE'] . "'>";
    }
    echo "</datalist>
            <input type='hidden' id='codeunites' name='codeunites'>
        </div>
        <div class='col-md-10 mb-4'>
            <label for='exampleDataList' class='form-label'>Catégories</label>
            <input required class='form-control'  list='datalistOptions1' id='UpdateInput2' name='selectedDesignation' placeholder='Type to search...'>
            <datalist id='datalistOptions1'>";
    foreach ($Categorie as $catKey => $catVal) {
        echo "<option value='" . $catVal['DESIGNATION'] . "' data-id='" . $catVal['CODECATEGORIE'] . "'>";
    }
    echo "</datalist>
            <input type='hidden' id='codecategorie' name='codecategorie'>
        </div>
        <div class='col-md-12 text-center'>
            <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
        </div>
    </div>";
}
