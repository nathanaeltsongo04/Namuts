<div class="container">

    <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-6 d-flex flex-column align-items-center justify-content-center">
                    <div class="card mb-3">

                        <div class="card-body">

                            <div class="pt-2 pb-4">
                                <h4 class="card-title text-center pb-0 fs-4 fw-bold">AUTHENTIFICATION</h4>
                                <p class="text-center small ">Veuillez entrer vos identifiants pour vous
                                    connecter</p>
                            </div>

                            <form class="row g-3" method="POST" action="tableau_de_bord.php">
                                <div class=" col-md-12 mb-3">

                                    <div class="input-group has-validation">
                                        <input type="text" name="nomdutilisateur" class="form-control" id="yourPassword" placeholder="Nom d'Utilisateur" required>
                                    </div>
                                </div>

                                <div class="col-md-12 mb-3">

                                    <input type="password" name="password" class="form-control" id="yourPassword" placeholder="Mot de Passe" required>
                                    <div class="invalid-feedback">Please enter your password!</div>
                                </div>


                                <div class="col-md-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="remember" value="true" id="rememberMe">
                                        <label class="form-check-label" for="rememberMe">Remember me</label>
                                    </div>
                                </div>
                                <div class="col-md-12 text-center">
                                    <button class="btn btn-primary w-50 fw-bold" type="submit">Se Connecter</button>
                                </div>
                                <div class="col-md-12 text-center">
                                    <p class="small mb-0">Je n'ai pas de Compte? <a href="Créer_Compte.php"><b>Créer Un
                                                Compte</b></a></p>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

</div>