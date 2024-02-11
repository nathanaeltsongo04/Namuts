<?php $title = "Namut's"; ?>

<?php $pageTitle = "Tableau de bord"; ?>

<?php $Subtitle = "Liste des Fournisseurs"; ?>

<?php ob_start(); ?>

<?php require_once 'view/fournisseurs.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>