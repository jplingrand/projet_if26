<?php
require_once('../database/db.php');
require_once('../modelVUT/etudiant.php');

$parameters = array
(
	':login' => null,
	':password' => null
);
foreach($_GET as $key => $value)
{
	$parameters[":$key"] = $value;
}

$json = array(
	'error' => true
);

$config = require_once('../config.php');
$db = new DB($config['dsn'], $config['username'], $config['password'], $config['options']);

$etudiant = $db->find('Etudiant', 'etudiant', 'login = :login AND password = :password', $parameters);

if($etudiant !== false)
{
	$token = md5(time() . $etudiant->login . $etudiant->password);
	$etudiant->token = $token;

	if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))
	{
		$json = array(
			'error' => false,
                        'idEtudiant' => $etudiant->idEtudiant,
			'token' => $etudiant->token,
                        'nom' => $etudiant->nom,
                        'prenom' => $etudiant->prenom,
                        'UT' => $etudiant->UT,
                        'telephone' => $etudiant->telephone,
                        'email' => $etudiant->email,
                        'creditVUTs' => $etudiant->creditVUTs
		);
	}
}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>