<?php
require('../../model/db_connection.php');
require('../../model/Services.php');

$data = new Services();
$data->setCODESERVICES($_POST['codeservices']);
$all = $data->afficherById();
foreach ($all as $key => $val) {
?>
<?php
    echo
    "<div class='row justify-content-center'>
    <div class=' col-md-10 mb-4 '>
        <input type='hidden' value='" . $_POST['codeservices'] . "'name='codeservices'>
        <div class='input-group has-validation'>
            <input type='text' value='" . $val['DESIGNATION'] . "'name='designation' class='form-control' id='yourPassword' placeholder='Désignation' required>
        </div>
    </div>
    <div class='col-md-10 mb-4'>
        <textarea name='description' class='form-control' placeholder='La description du service' id='floatingTextarea2' style='height: 200px'>" . $val['DESCRIPTION'] . "</textarea>
                                 <label for='floatingTextarea2'></label>
    </div>
    <div class='col-md-12 text-center'>
        <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
    </div>
</div>";
}
?>