<?php $title = "Namut's"; ?>
<?php
$Subtitle = "Liste Des Approvisionnements";
?>

<?php $pageTitle = "Approvisionnements"; ?>

<?php ob_start(); ?>

<?php require_once 'view/approvisionnements.php' ?>

<?php $content = ob_get_clean(); ?>

<?php require('templates/layout.php') ?>