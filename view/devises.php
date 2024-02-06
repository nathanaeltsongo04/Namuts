     <?php
        require('./model/db_connection.php');
        require('./model/Devises.php');

        $data = new Devises();
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
                 location.replace('Devises.php');
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
                         <a class="icon text-secondary " data-bs-toggle="modal" data-bs-target="#exampleModal" href="#"><i class="bi bi-plus-circle-fill h5 "></i></a>
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
                         <h5 class="card-title "> <?= $Subtitle ?> <span></span></h5>
                         <div class="table-responsive-md">
                             <table class="table table-borderless datatable table-responsive table table-striped">
                                 <thead>
                                     <tr>
                                         <th scope="col">Désignation</th>
                                         <th scope="col">Sigle</th>
                                         <th scope="col">Taux</th>
                                         <th scope="col">Symbole</th>
                                         <th scope="col">Date Taux</th>
                                         <th scope="col">Auteur</th>
                                         <th scope="col">Action</th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <?php
                                        foreach ($all as $key => $val) {
                                        ?>
                                         <tr>
                                             <td><?= $val['DESIGNATION'] ?></td>
                                             <td><?= $val['SIGLE'] ?></td>
                                             <td><?= $val['TAUX'] ?></td>
                                             <td><?= $val['SYMBOLE'] ?></td>
                                             <td><?= $val['DATE_TAUX'] ?></td>
                                             <td><?= $val['AUTEUR'] ?></td>
                                             <td><span data-id='<?= $val['CODEDEVISE'] ?>' class="badge bg-success elementinfo "><i class="bi bi-pencil-fill "></i></span>
                                                 <span data-id='<?= $val['CODEDEVISE'] ?>' class="badge bg-danger elementinfo "><i class="bi bi-trash-fill "></i></span>

                                             </td>
                                         </tr>
                                     <?php
                                        }
                                        ?>
                                 </tbody>
                             </table>
                         </div>

                     </div>

                 </div>
             </div><!-- End Recent Sales -->
         </div>
     </div><!-- End Left side columns -->
     <!-- =====================================FORMULAIRE D'INSERTION DEVISE=============================-->
     <!-- Modal -->
     <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-md modal-dialog-centered ">
             <div class="modal-content  ">
                 <div class="modal-header border-0 ">
                     <h5 class="modal-title fw-bold text-primary " id="exampleModalLabel">Nouvelle Devise</h5>
                     <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <form class="row g-3" method="POST" action="./controller/Devises.php">
                     <div class="modal-body">
                         <div class="row justify-content-center">
                             <div class=" col-md-10 mb-4 ">
                                 <div class="input-group has-validation">
                                     <input type="text" name="designation" class="form-control" id="yourPassword" placeholder="Désignation" required>
                                 </div>
                             </div>
                             <div class="col-md-10 mb-4">
                                 <input type="text" name="sigle" class="form-control" id="yourPassword" placeholder="Sigle" required>

                             </div>
                             <div class="col-md-10 mb-4">
                                 <input type="number" min="0" step=".01" name="taux" class="form-control" id="yourPassword" placeholder="2000" required>

                             </div>
                             <div class="col-md-10 mb-4">
                                 <input type="text" name="symbole" class="form-control" id="yourPassword" placeholder="Symbole ($)" required>

                             </div>
                             <div class="col-md-12 text-center">
                                 <button name="save" class="btn btn-primary w-50 fw-bold" type="submit">Enregistrer</button>
                             </div>
                         </div>
                     </div>
                 </form>
             </div>
         </div>
     </div>
     <!-- =====================================FORMULAIRE DE MODIFICATION DEVISE=============================-->
     <!-- Modal -->
     <div class="modal fade" id="exampleModalmodification" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-md modal-dialog-centered ">
             <div class="modal-content  ">
                 <div class="modal-header border-0 ">
                     <h5 class="modal-title fw-bold text-success " id="exampleModalLabel">Modification Devise</h5>
                     <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal" aria-label="Close"></button>
                 </div>
                 <form class="row g-3" method="POST" action="./controller/Devises.php">
                     <div class="modal-body">

                     </div>
                 </form>
             </div>
         </div>
     </div>
     <!-- ==== SCRIPT POUR CHARGER LE CORP DU MODAL #exampleModalmodification ===-->
     <script type='text/javascript'>
         $(document).ready(function() {
             $('.elementinfo').click(function() {
                 var codedevise = $(this).data('id');

                 $.ajax({
                     url: './controller/modal_loading/Devises.php',
                     type: 'POST',
                     data: {
                         codedevise: codedevise
                     },
                     success: function(response) {
                         $('.modal-body').html(response);
                         $('#exampleModalmodification').modal('show');
                     }

                 })

             });

         });
     </script>