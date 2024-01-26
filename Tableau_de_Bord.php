<?php $title = "Namut's"; ?>

<?php $Subtitle = "Tableau De Bord"; ?>
<?php $pageTitle = "Vues"; ?>

<?php ob_start(); ?>

<?php require_once 'view/tableau_de_bord.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>