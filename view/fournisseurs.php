      <?php
        require('./model/db_connection.php');
        require('./model/Fournisseurs.php');

        $data = new Fournisseurs();
        $all = $data->afficher();
        if (isset($_GET['msg']) == 'true') {
        ?>
          <script>
              Swal.fire({
                  position: 'center',
                  icon: 'success',
                  title: '<?php echo $_GET['info'] ?>',
                  showConfirmButton: false,
                  timer: 2800
              }).then(function() {
                  location.replace('Clients.php');
              });
          </script>
      <?php } ?>
      <!-- Left side columns -->
      <div class="col-lg-12">
          <div class="row">
              <!-- Recent Sales -->
              <div class="col-12">
                  <div class="card recent-sales overflow-auto">

                      <div class="filter">
                          <a class="icon text-secondary " data-bs-toggle="modal" data-bs-target="#exampleModalinsertion" href="#"><i class="bi bi-plus-circle-fill h5 "></i></a>
                          <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots h5"></i></a>
                          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                              <li class="dropdown-header text-start">
                                  <h6>Filter</h6>
                              </li>

                              <li><a class="dropdown-item" href="#">Today</a></li>
                              <li><a class="dropdown-item" href="#">This Month</a></li>
                              <li><a class="dropdown-item" href="#">This Year</a></li>
                          </ul>
                      </div>

                      <div class="card-body">
                          <h5 class="card-title"><?= $Subtitle ?> <span></span></h5>

                          <table class="table table-borderless datatable">
                              <thead>
                                  <tr>
                                      <th scope="col">Noms</th>
                                      <th scope="col">Téléphone</th>
                                      <th scope="col">Email</th>
                                      <th scope="col">Addresse</th>
                                      <th scope="col">Action</th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <?php
                                    foreach ($all as $key => $val) {
                                    ?>
                                      <tr>
                                          <td scope="row"><?= $val['NOM'] . " " . $val['POSTNOM'] . " " . $val['PRENOM'] ?>
                                          </td>
                                          <td><?= $val['TELEPHONE'] ?></td>
                                          <td><?= $val['EMAIL'] ?></td>
                                          <td><?= $val['ADDRESSE'] ?></td>
                                          <td><span data-id='<?= $val['CODEFOURNISSEUR'] ?>' class="badge bg-success elementinfo "><i class="bi bi-pencil-fill "></i></span>
                                              <span data-id='<?= $val['CODEFOURNISSEUR'] ?>' class="badge bg-danger elementinfo "><i class="bi bi-trash-fill "></i></span>

                                          </td>
                                      </tr>
                                  <?php
                                    }
                                    ?>
                              </tbody>
                          </table>

                      </div>

                  </div>
              </div><!-- End Recent Sales -->
          </div>
      </div><!-- End Left side columns -->
      <!-- =====================================FORMULAIRE D'INSERTION CATEGORIE=============================-->
      <!-- Modal -->
      <div class="modal fade" id="exampleModalinsertion" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-md modal-dialog-centered ">
              <div class="modal-content  ">
                  <div class="modal-header border-0 ">
                      <h5 class="modal-title fw-bold text-primary " id="exampleModalLabel">Nouveau Fournisseur</h5>
                      <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form class="row g-3" method="POST" action="./controller/Fournisseurs.php">
                      <div class="modal-body">
                          <div class="row justify-content-center">
                              <div class=" col-md-10 mb-2 mt-0 ">
                                  <div class="input-group has-validation">
                                      <input type="text" name="nom" class="form-control" id="yourPassword" placeholder="Nom" required>
                                  </div>
                              </div>
                              <div class=" col-md-10 mb-2 mt-1 ">
                                  <div class="input-group has-validation">
                                      <input type="text" name="postnom" class="form-control" id="yourPassword" placeholder="Post Nom" required>
                                  </div>
                              </div>
                              <div class=" col-md-10 mb-2 mt-1 ">
                                  <div class="input-group has-validation">
                                      <input type="text" name="prenom" class="form-control" id="yourPassword" placeholder="Prénom" required>
                                  </div>
                              </div>
                              <div class=" col-md-10 mb-2 mt-1 ">
                                  <div class="input-group has-validation">
                                      <input type="tel" pattern="[0-9]{10}" name="telephone" class="form-control" id="yourPassword" placeholder="0995247814" required>
                                  </div>
                              </div>
                              <div class=" col-md-10 mb-2 mt-1 ">
                                  <div class="input-group has-validation">
                                      <input type="email" name="email" class="form-control" id="yourPassword" placeholder="Email" required>
                                  </div>
                              </div>
                              <div class=" col-md-10 mb-4 mt-1 ">
                                  <div class="input-group has-validation">
                                      <input type="text" name="addresse" class="form-control" id="yourPassword" placeholder="Addresse" required>
                                  </div>
                              </div>
                              <div class="col-md-12 text-center mt-2">
                                  <button name="save" class="btn btn-primary w-50 fw-bold" type="submit">Enregistrer</button>
                              </div>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
      </div>
      <!-- =====================================FORMULAIRE DE MODIFICATION CLIENTS=============================-->
      <!-- Modal -->
      <div class="modal fade" id="exampleModalmodification" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-md modal-dialog-centered ">
              <div class="modal-content  ">
                  <div class="modal-header border-0 ">
                      <h5 class="modal-title fw-bold text-success " id="exampleModalLabel">Modification Fournisseur</h5>
                      <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form class="row g-3" method="POST" action="./controller/Fournisseurs.php">
                      <div class="modal-body modification">

                      </div>
                  </form>
              </div>
          </div>
      </div>
      <!-- ==== SCRIPT POUR CHARGER LE CORP DU MODAL #exampleModalmodification ===-->
      <script type='text/javascript'>
          $(document).ready(function() {
              $('.elementinfo').click(function() {
                  var codefournisseurs = $(this).data('id');

                  $.ajax({
                      url: './controller/modal_loading/Fournisseurs.php',
                      type: 'POST',
                      data: {
                          codefournisseurs: codefournisseurs
                      },
                      success: function(response) {
                          $('.modification').html(response);
                          $('#exampleModalmodification').modal('show');
                      }

                  })

              });

          });
      </script>