<?php $title = "Namut's"; ?>

<?php $pageTitle = "Tableau de bord"; ?>

<?php $Subtitle = "Gestion des Produits"; ?>

<?php ob_start(); ?>

<?php require_once 'view/produits.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>