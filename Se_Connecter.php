<?php $title = "Namut's"; ?>

<?php ob_start(); ?>

<?php require_once 'view/seconnecter.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/Authentification.php') ?>