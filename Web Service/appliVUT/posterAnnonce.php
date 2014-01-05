<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');

$parameters = array
(
	':token' => null,
	':categorie' => null,
        ':titre' => null,
        ':texte' => null,
        ':prix' => null,
        ':type' => null
);
foreach($_GET as $key => $value)
{
	$parameters[":$key"] = $value;
}

$etudiantParameters = array(
	array_shift(array_keys($parameters)) => array_shift($parameters)
);

$json = array(
	'error' => true
);

$config = require_once('../config.php');
$db = new DB($config['dsn'], $config['username'], $config['password'], $config['options']);

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);

if($etudiant !== false)
{
    
        $annonce = new Annonce();
        $annonce->refEtudiant = $etudiant->idEtudiant;
        $annonce->categorie = $parameters[':categorie'];
        $annonce->titre = $parameters[':titre'];
        $annonce->texte = $parameters[':texte'];
        $annonce->prix = $parameters[':prix'];
        $annonce->valide = true;
        $annonce->date = date('Y-m-d H:i:s');
        
        /*
        if ($parameters[':type'] == 'offre')
        {
                $annonce = new Offre();
                $annonce->refEtudiant = $etudiant->idEtudiant;
                $annonce->categorie = $parameters[':categorie'];
                $annonce->titre = $parameters[':titre'];
                $annonce->texte = $parameters[':texte'];
                $annonce->prix = $parameters[':prix'];
                $annonce->valide = true;
                $annonce->date = date('Y-m-d H:i:s');
                $annonce->photo = 'test';
        }
        else if ($parameters[':type'] == 'demande')
        {
                $annonce = new Demande();
                $annonce->refEtudiant = $etudiant->idEtudiant;
                $annonce->categorie = $parameters[':categorie'];
                $annonce->titre = $parameters[':titre'];
                $annonce->texte = $parameters[':texte'];
                $annonce->prix = $parameters[':prix'];
                $annonce->valide = true;
                $annonce->date = date('Y-m-d H:i:s');
        } 
        */
        
        if($db->insert($annonce, 'annonce'))
        {
                $json = array(
                        'error' => false,
                );
        }
}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>
