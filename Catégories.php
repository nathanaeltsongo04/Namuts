<?php $title = "Namut's"; ?>

<?php $pageTitle = "Tableau de bord"; ?>

<?php $Subtitle = "Liste des Catégories"; ?>

<?php ob_start(); ?>

<?php require_once 'view/categories.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>