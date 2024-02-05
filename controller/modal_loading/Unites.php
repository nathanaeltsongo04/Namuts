<?php
require('../../model/db_connection.php');
require('../../model/Unites.php');

$data = new unites();
$data->setCODEUNITE($_POST['codeunite']);
$all = $data->afficherById();
$codeunite = $_POST['codeunite'];
foreach ($all as $key => $val) {
?>
<?php
    echo
    "<div class='row justify-content-center'>
    <div class=' col-md-10 mb-4 '>
        <input type='hidden' value='" . $_POST['codeunite'] . "'name='codeunite'>
        <div class='input-group has-validation'>
            <input type='text' value='" . $val['DESIGNATION'] . "'name='designation' class='form-control' id='yourPassword' placeholder='Désignation' required>
        </div>
    </div>
    <div class='col-md-10 mb-4'>
        <input type='text' value='" . $val['SIGLE'] . "' name='sigle' class='form-control' id='yourPassword' placeholder='Sigle' required>
            <div class='invalid-feedback'>Please enter your password!</div>
    </div>
    <div class='col-md-12 text-center'>
        <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
    </div>
</div>";
}
?>