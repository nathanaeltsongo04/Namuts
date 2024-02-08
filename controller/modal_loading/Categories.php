<?php
require('../../model/db_connection.php');
require('../../model/Categories.php');

$data = new Categories();
$data->setCODECATEGORIE($_POST['codecategorie']);
$all = $data->afficherById();
foreach ($all as $key => $val) {
?>
<?php
    echo
    "<div class='row justify-content-center'>
    <div class=' col-md-10 mb-4 mt-2 '>
        <input type='hidden' value='" . $_POST['codecategorie'] . "'name='codecategorie'>
        <div class='input-group has-validation'>
            <input type='text' value='" . $val['DESIGNATION'] . "'name='designation' class='form-control' id='yourPassword' placeholder='Désignation' required>
        </div>
    </div>
    <div class='col-md-12 text-center mt-2'>
        <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
    </div>
</div>";
}
?>