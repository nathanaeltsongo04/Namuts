<?php
require('../../model/db_connection.php');
require('../../model/Fournisseurs.php');
$data = new Fournisseurs();
$data->setCODEFOURNISSEURS($_POST['codefournisseurs']);
$all = $data->afficherById();
foreach ($all as $key => $val) {
?>
<?php
    echo
    "<div class='row justify-content-center'>
        
                              <div class=' col-md-10 mb-2 mt-0 '>
                              <input type='hidden' value='" . $_POST['codefournisseurs'] . "'name='codefournisseurs'>
                                  <div class='input-group has-validation'>
                                      <input type='text' value='" . $val['NOM'] . "' name='nom' class='form-control' id='yourPassword' placeholder='Nom' required>
                                  </div>
                              </div>
                              <div class=' col-md-10 mb-2 mt-1 '>
                                  <div class='input-group has-validation'>
                                      <input type='text' value='" . $val['POSTNOM'] . "' name='postnom' class='form-control' id='yourPassword' placeholder='Post Nom' required>
                                  </div>
                              </div>
                              <div class=' col-md-10 mb-2 mt-1 '>
                                  <div class='input-group has-validation'>
                                      <input type='text' value='" . $val['PRENOM'] . "' name='prenom' class='form-control' id='yourPassword' placeholder='Prénom' required>
                                  </div>
                              </div>
                              <div class=' col-md-10 mb-2 mt-1 '>
                                  <div class='input-group has-validation'>
                                      <input type='tel' value='" . $val['TELEPHONE'] . "' pattern='[0-9]{10}' name='telephone' class='form-control' id='yourPassword' placeholder='0995247814' required>
                                  </div>
                              </div>
                              <div class=' col-md-10 mb-2 mt-1 '>
                                  <div class='input-group has-validation'>
                                      <input type='email' value='" . $val['EMAIL'] . "' name='email' class='form-control' id='yourPassword' placeholder='Email' required>
                                  </div>
                              </div>
                              <div class=' col-md-10 mb-4 mt-1 '>
                                  <div class='input-group has-validation'>
                                      <input type='text' value='" . $val['ADDRESSE'] . "' name='addresse' class='form-control' id='yourPassword' placeholder='Addresse' required>
                                  </div>
                              </div>
                              <div class='col-md-12 text-center mt-2'>
                                  <button name='update' class='btn btn-success w-50 fw-bold' type='submit'>Modifier</button>
                              </div>
                          </div>";
}
?>