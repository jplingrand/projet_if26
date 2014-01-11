<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/message.php');

$parameters = array
(
	':token' => null,
	':idAnnonce' => null,
        ':texte' => null,
);
foreach($_GET as $key => $value)
{
	$parameters[":$key"] = $value;
}

$etudiantParameters = array(
	array_shift(array_keys($parameters)) => array_shift($parameters)
);

$annonceParameters = array(
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
    
        $annonce = $db->find('Annonce', 'annonce', 'idAnnonce = :idAnnonce', $annonceParameters);   //Récupération de l'annonce
        
        if ($annonce !== false)
        {
            
            $message = new Message();   //Création de l'objet Message
            $message->refEtudiant = $etudiant->idEtudiant;
            $message->refAnnonce = $annonce->idAnnonce;
            $message->texte = $parameters[':texte'];
            $message->date = date('Y-m-d H:i:s');            
        
                if($db->insert($message, 'message'))    //Insertion en BDD
                {
                        $json = array(
                                'error' => false,
                        );
                }
        
        }
}
echo json_encode($json);    //Réponse JSON
?>
