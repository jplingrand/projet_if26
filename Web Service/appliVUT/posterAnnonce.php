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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);   //Requête pour vérifier le token de l'étudiant 

if($etudiant !== false)     //Test si le token est bon
{
    
        $annonce = new Annonce();   //Création de l'objet annonce
        $annonce->refEtudiant = $etudiant->idEtudiant;
        $annonce->categorie = $parameters[':categorie'];
        $annonce->titre = $parameters[':titre'];
        $annonce->texte = $parameters[':texte'];
        $annonce->prix = $parameters[':prix'];
        $annonce->valide = true;
        $annonce->date = date('Y-m-d H:i:s');
        
        
        if($db->insert($annonce, 'annonce'))    //Insertion de l'annonce en BDD
        {
                $json = array(
                        'error' => false,
                );
        }
}
echo json_encode($json);    //Réponse JSON
?>
