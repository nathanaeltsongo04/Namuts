     <!-- Left side columns -->
     <div class="col-lg-12">
         <div class="row">
             <!-- Recent Sales -->
             <div class="col-12">
                 <div class="card recent-sales overflow-auto">

                     <div class="filter">
                         <a class="icon text-secondary " href="#"><i class="bi bi-plus-circle-fill h5 "></i></a>
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
                             <table class="table table-borderless datatable table-responsive">
                                 <thead>
                                     <tr>
                                         <th class="ms-2" scope="col">Code</th>
                                         <th scope="col">Désignation</th>
                                         <th scope="col">Sigle</th>
                                         <th scope="col">Auteur</th>
                                         <th scope="col">Action</th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <tr>
                                         <th class="text text-secondary" scope="row">01</th>
                                         <td>Kilogramme</td>
                                         <td>Piece</td>
                                         <td>Quincaillerie</td>
                                         <td><span class="badge bg-success"><i class="bi bi-pencil-fill"></i></span>
                                         </td>
                                     </tr>
                                 </tbody>
                             </table>
                         </div>

                     </div>

                 </div>
             </div><!-- End Recent Sales -->
         </div>
     </div><!-- End Left side columns -->