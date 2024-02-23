<?php $title = "Namut's"; ?>

<?php $pageTitle = "Tableau de bord"; ?>

<?php $Subtitle = "Gestion Utilisateurs"; ?>

<?php ob_start(); ?>

<?php require_once 'view/utilisateur.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>