<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/message.php');

$parameters = array
(
	':token' => null
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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $parameters);

if($etudiant !== false)
{

	$sql = "SELECT * FROM annonce WHERE refEtudiant = ?";
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant);  
	$pdoStatement->execute();
	$annonces = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Annonce');

        foreach($annonces as $objetAnnonce)
        {
                $sql = "SELECT * FROM message WHERE refAnnonce = ?";
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetAnnonce->idAnnonce); 
                $pdoStatement->execute();
                $messages = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Message');
                        
                foreach ($messages as $objetMessage)
                {
                        $sql = "SELECT login, UT FROM etudiant WHERE idEtudiant = ?";
                        $pdoStatement = $db->pdo->prepare($sql);
                        $pdoStatement -> bindValue(1, $objetMessage->refEtudiant); 
                        $pdoStatement->execute();
                        $infosEmetteur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                        $objetMessage->infosEmetteur = $infosEmetteur;                                               
                }
                        
                $objetAnnonce->messages = $messages;
                unset($objetAnnonce->infosAnnonceur);           
        }
        
        $json = array(
		'error' => false,
                'annonces' => $annonces
	);

}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>