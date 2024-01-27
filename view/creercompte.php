<div class="container">

    <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-6 d-flex flex-column align-items-center justify-content-center">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="pt-2 pb-3">
                                <h4 class="card-title text-center pb-0 fs-4 fw-bold">NOUVEAU COMPTE</h4>
                                <p class="text-center small ">Veuillez remplir le formulaire pour créer votre compte</p>
                            </div>

                            <form class="row g-3 ">
                                <div class=" col-md-12 mb-2">

                                    <div class="input-group has-validation">
                                        <input type="text" name="codeutilisateur" class="form-control" id="yourPassword"
                                            placeholder="Code Utilisateur" required>
                                    </div>
                                </div>
                                <div class=" col-md-12 mb-2">

                                    <div class="input-group has-validation">
                                        <input type="text" name="nomdutilisateur" class="form-control" id="yourPassword"
                                            placeholder="Nom d'Utilisateur" required>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-2">

                                    <input type="password" name="confirmermotdepasse" class="form-control"
                                        id="yourPassword" placeholder="Mot de Passe" required>
                                    <div class="invalid-feedback">Please enter your password!</div>
                                </div>
                                <div class="col-md-12 mb-3">

                                    <input type="password" name="motdepasse" class="form-control" id="yourPassword"
                                        placeholder="Confirmer le Mot de Passe" required>
                                    <div class="invalid-feedback">Please enter your password!</div>
                                </div>

                                <div class="col-md-12 text-center">
                                    <button class="btn btn-primary w-50 fw-bold" type="submit">Créer</button>
                                </div>
                                <div class="col-md-12 text-center">
                                    <p class="small mb-0">J'ai un Compte? <a href="Se_Connecter.php"><b> Se
                                                Connecter</b></a></p>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

</div>