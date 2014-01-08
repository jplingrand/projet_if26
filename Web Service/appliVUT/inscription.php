<?php
require_once('../database/db.php');
require_once('../modelVUT/etudiant.php');

foreach($_GET as $key => $value)
{
	$parameters[":$key"] = $value;
}

$json = array(
	'error' => true
);

$config = require_once('../config.php');
$db = new DB($config['dsn'], $config['username'], $config['password'], $config['options']);

$prefixeSel = 'j5Uz74a8M2';
$suffixeSel = 'pB61yE9k03';

$password = md5($prefixeSel . $parameters[':password'] . $suffixeSel);

date_default_timezone_set('Europe/Paris');

$etudiant = new Etudiant();
$etudiant->login = $parameters[':login'];
$etudiant->password = $password;
$etudiant->nom = $parameters[':nom'];
$etudiant->prenom = $parameters[':prenom'];
$etudiant->UT = $parameters[':UT'];
$etudiant->telephone = $parameters[':telephone'];
$etudiant->email = $parameters[':email'];
$etudiant->creditVUTs = 50;
$etudiant->nbTentatives = 0;
$etudiant->dateTentative = date('Y-m-d H:i:s', time());

$token = md5(time() . $etudiant->login . $etudiant->password);
$etudiant->token = $token;

if($db->insert($etudiant, 'etudiant'))
{
        $json = array(
		'error' => false,
	);
}

// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>