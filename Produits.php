<?php $title = "Namut's"; ?>

<?php $Subtitle = "Produits"; ?>

<?php $pageTitle = "Liste Des Produits"; ?>

<?php ob_start(); ?>

<?php require_once 'view/produits.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>