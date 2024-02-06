<?php
require('../../model/db_connection.php');
require('../../model/Devises.php');

$data = new Devises();
$data->setCODEDEVISE($_POST['codedevise']);
$all = $data->afficherById();
foreach ($all as $key => $val) {
?>
<?php
    echo
    "<div class='row justify-content-center'>
    <div class=' col-md-10 mb-4 '>
        <input type='hidden' value='" . $_POST['codedevise'] . "'name='codedevise'>
        <div class='input-group has-validation'>
            <input type='text' value='" . $val['DESIGNATION'] . "'name='designation' class='form-control' id='yourPassword' placeholder='Désignation' required>
        </div>
    </div>
    <div class='col-md-10 mb-4'>
        <input type='text' value='" . $val['SIGLE'] . "' name='sigle' class='form-control' id='yourPassword' placeholder='Sigle' required>
            <div class='invalid-feedback'>Please enter your password!</div>
    </div>
    <div class='col-md-10 mb-4'>
        <input type='number' value='" . $val['TAUX'] . "' min='0' step='.01' name='taux' class='form-control' id='yourPassword' placeholder='2000' required>

    </div>
    <div class='col-md-10 mb-4'>
        <input type='text' value='" . $val['SYMBOLE'] . "' name='symbole' class='form-control' id='yourPassword' placeholder='Symbole ($)' required>

    </div>
    <div class='col-md-12 text-center'>
        <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
    </div>
</div>";
}
?>