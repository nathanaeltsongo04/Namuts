<?php
require('../../model/db_connection.php');
require('../../model/Clients.php');

$data = new Clients();
$data->setCODECLIENTS($_POST['codeclients']);
$all = $data->afficherById();
?>
<?php
foreach ($all as $key => $val) {
    echo
    "
    <div class='row justify-content-center'>
        <div class=' col-md-10 mb-4 '>
            <input type='hidden' value='" . $_POST['codeclients'] . "'name='codeclients'>
            <div class='input-group has-validation'>
                <input type='text' value='" . $val['NOM'] . "' name='nom' class='form-control' id='yourPassword'
                                         placeholder='Nom' required>
            </div>
        </div>
        <div class=' col-md-10 mb-4 '>
            <div class='input-group has-validation'>
                <input type='text' value='" . $val['POSTNOM'] . "' name='postnom' class='form-control' id='yourPassword'
                                         placeholder='Post Nom' required>
            </div>
        </div>
        <div class=' col-md-10 mb-4 '>
            <div class='input-group has-validation'>
                <input type='text' value='" . $val['PRENOM'] . "' name='prenom' class='form-control' id='yourPassword'
                                         placeholder='Prénom' required>
            </div>
        </div>
        <div class=' col-md-10 mb-4 '>
            <div class='input-group has-validation'>
                <input type='tel' value='" . $val['CONTACT'] . "' pattern='[0-9]{10}' name='contact' class='form-control'
                                         id='yourPassword' placeholder='0995247814' required>
            </div>
        </div>
        <div class=' col-md-10 mb-4 '>
            <div class='input-group has-validation'>
                <input type='Email' value='" . $val['EMAIL'] . "' name='email' class='form-control' id='yourPassword'
                                        placeholder='xxxx@xxx' required>
            </div>
        </div>
        <div class=' col-md-10 mb-4 '>
            <div class='input-group has-validation'>
                <input type='text' value='" . $val['ADDRESSE'] . "' name='addresse' class='form-control' id='yourPassword'
                                         placeholder='Addresse Client' required>
            </div>
        </div>

        <div class='col-md-12 text-center'>
            <button name='update' class='btn btn-success w-50 fw-bold'
                                     type='submit'>Modifier</button>
        </div>
    </div>";
}
?>