<?php $title = "Namut's"; ?>

<?php $pageTitle = "Clients"; ?>

<?php $Subtitle = "Liste Des Clients"; ?>

<?php ob_start(); ?>

<?php require_once 'view/clients.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>