     <?php
        require('./model/db_connection.php');
        require('./model/Unites.php');
        require('./model/Categories.php');
        require('./model/Produits.php');

        $data = new Produits();
        $all = $data->afficher();
        $Unitobject = new Unites();
        $Unites = $Unitobject->afficher();
        $Catobject = new Categories();
        $Categorie = $Catobject->afficher();

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
    location.replace('Produits.php');
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
                         <a class="icon text-secondary " data-bs-toggle="modal" data-bs-target="#exampleModal"
                             href="#"><i class="bi bi-plus-circle-fill h5 "></i></a>
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
                                         <th class="ms-2" scope="row">Désignation</th>
                                         <th scope="col">Unités</th>
                                         <th scope="col">Catégories</th>
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
                                         <td><?= $val['UNITE'] ?></td>
                                         <td><?= $val['CATEGORIE'] ?></td>
                                         <td><?= $val['AUTEUR'] ?></td>
                                         <td><span data-id='<?= $val['CODEPRODUITS'] ?>'
                                                 class="badge bg-success elementinfo "><i
                                                     class="bi bi-pencil-fill "></i></span>
                                             <span data-id='<?= $val['CODEPRODUITS'] ?>'
                                                 class="badge bg-danger elementinfo "><i
                                                     class="bi bi-trash-fill "></i></span>

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
     <!-- =====================================FORMULAIRE D'INSERTION UNITE=============================-->
     <!-- Modal -->
     <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-md modal-dialog-centered ">
             <div class="modal-content  ">
                 <div class="modal-header border-0 ">
                     <h5 class="modal-title fw-bold text-primary " id="exampleModalLabel">Nouvelle Unité</h5>
                     <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal"
                         aria-label="Close"></button>
                 </div>
                 <form class="row g-3" method="POST" action="./controller/Produits.php">
                     <div class="modal-body">
                         <div class="row justify-content-center">
                             <div class=" col-md-10 mb-4 ">
                                 <div class="input-group has-validation">
                                     <input type="text" name="designation" class="form-control" id="yourPassword"
                                         placeholder="Désignation" required>
                                 </div>
                             </div>
                             <div class="col-md-10 mb-4">
                                 <label for="exampleDataList" class="form-label">Unités</label>
                                 <input class="form-control" list="datalistOptions" id="selectedDesignation"
                                     name="selectedDesignation" placeholder="Type to search...">
                                 <datalist id="datalistOptions">
                                     <?php foreach ($Unites as $key => $val) { ?>
                                     <option value="<?= $val['DESIGNATION'] ?>" data-id="<?= $val['CODEUNITE'] ?>">
                                         <?php } ?>
                                 </datalist>
                                 <input type="hidden" id="codeunites" name="codeunites">
                             </div>
                             <div class="col-md-10 mb-4">
                                 <label for="exampleDataList" class="form-label">Catégories</label>
                                 <input class="form-control" list="datalistOptions1" id="selectedDesignation1"
                                     name="selectedDesignation" placeholder="Type to search...">
                                 <datalist id="datalistOptions1">
                                     <?php foreach ($Categorie as $key => $val) { ?>
                                     <option value="<?= $val['DESIGNATION'] ?>" data-id="<?= $val['CODECATEGORIE'] ?>">
                                         <?php } ?>
                                 </datalist>
                                 <input type="hidden" id="codecategorie" name="codecategorie">
                             </div>
                             <div class="col-md-12 text-center">
                                 <button name="save" class="btn btn-primary w-50 fw-bold"
                                     type="submit">Enregistrer</button>
                             </div>
                         </div>
                     </div>
                 </form>
             </div>
         </div>
     </div>
     <!-- =====================================FORMULAIRE DE MODIFICATION UNITE=============================-->
     <!-- Modal -->
     <div class="modal fade" id="exampleModalmodification" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
         <div class="modal-dialog modal-md modal-dialog-centered ">
             <div class="modal-content  ">
                 <div class="modal-header border-0 ">
                     <h5 class="modal-title fw-bold text-success " id="exampleModalLabel">Modification Produits</h5>
                     <button type="button" class="btn-close fw-bold" data-bs-dismiss="modal"
                         aria-label="Close"></button>
                 </div>
                 <form class="row g-3" method="POST" action="./controller/Produits.php">
                     <div class="modal-body modification">

                     </div>
                     <script>
                     document.getElementById('UpdateInput1').addEventListener('input', function() {
                         var selectedOption = this.value;
                         var options = document.getElementById('datalistOptions').childNodes;
                         for (var i = 0; i < options.length; i++) {
                             if (options[i].value === selectedOption) {
                                 document.getElementById('codeunites').value = options[i].getAttribute(
                                     'data-id');
                                 break;
                             }
                         }
                     });
                     document.getElementById('UpdateInput2').addEventListener('input', function() {
                         var selectedOption = this.value;
                         var options = document.getElementById('datalistOptions1').childNodes;
                         for (var i = 0; i < options.length; i++) {
                             if (options[i].value === selectedOption) {
                                 document.getElementById('codecategorie').value = options[i].getAttribute(
                                     'data-id');
                                 break;
                             }
                         }
                     });
                     </script>
                 </form>
             </div>
         </div>
     </div>
     <!-- ==== SCRIPT POUR CHARGER LE CORP DU MODAL #exampleModalmodification ===-->
     <script type='text/javascript'>
$(document).ready(function() {
    $('.elementinfo').click(function() {
        var codeproduits = $(this).data('id');

        $.ajax({
            url: './controller/modal_loading/Produits.php',
            type: 'POST',
            data: {
                codeproduits: codeproduits
            },
            success: function(response) {
                $('.modification').html(response);
                $('#exampleModalmodification').modal('show');
            }

        })

    });

});

document.getElementById('selectedDesignation').addEventListener('input', function() {
    var selectedOption = this.value;
    var options = document.getElementById('datalistOptions').childNodes;
    for (var i = 0; i < options.length; i++) {
        if (options[i].value === selectedOption) {
            document.getElementById('codeunites').value = options[i].getAttribute('data-id');
            break;
        }
    }
});
document.getElementById('selectedDesignation1').addEventListener('input', function() {
    var selectedOption = this.value;
    var options = document.getElementById('datalistOptions1').childNodes;
    for (var i = 0; i < options.length; i++) {
        if (options[i].value === selectedOption) {
            document.getElementById('codecategorie').value = options[i].getAttribute('data-id');
            break;
        }
    }
});
     </script>