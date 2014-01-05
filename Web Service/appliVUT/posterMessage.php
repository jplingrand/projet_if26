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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);

if($etudiant !== false)
{
    
        $annonce = $db->find('Annonce', 'annonce', 'idAnnonce = :idAnnonce', $annonceParameters);
        
        if ($annonce !== false)
        {
            
            $message = new Message();
            $message->refEtudiant = $etudiant->idEtudiant;
            $message->refAnnonce = $annonce->idAnnonce;
            $message->texte = $parameters[':texte'];
            $message->date = date('Y-m-d H:i:s');            
        
                if($db->insert($message, 'message'))
                {
                        $json = array(
                                'error' => false,
                        );
                }
        
        }
}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>
