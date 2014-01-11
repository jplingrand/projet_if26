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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $parameters);   //Requête pour vérifier le token de l'étudiant 

if($etudiant !== false)     //Test si le token est bon
{

	$sql = "SELECT * FROM annonce WHERE refEtudiant = ?";   //Requête pour afficher toutes les annonces de l'étudiant
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant);  
	$pdoStatement->execute();
	$annonces = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Annonce');   //Création d'objets Annonce

        foreach($annonces as $objetAnnonce)
        {
                $sql = "SELECT * FROM message WHERE refAnnonce = ?";        //Requête pour afficher tous les messages liés à une annonce
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetAnnonce->idAnnonce); 
                $pdoStatement->execute();
                $messages = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Message');   //Création d'objets Message
                        
                foreach ($messages as $objetMessage)
                {
                        $sql = "SELECT login, UT FROM etudiant WHERE idEtudiant = ?";   //Requête pour afficher les infos de l'émetteur
                        $pdoStatement = $db->pdo->prepare($sql);
                        $pdoStatement -> bindValue(1, $objetMessage->refEtudiant); 
                        $pdoStatement->execute();
                        $infosEmetteur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                        $objetMessage->infosEmetteur = $infosEmetteur;                                               
                }
                        
                $objetAnnonce->messages = $messages;
                unset($objetAnnonce->infosAnnonceur);   //Car l'annonceur = l'étudiant connecté   
        }
        
        //Infos sur les annonces au format JSON
        $json = array(
		'error' => false,
                'annonces' => $annonces
	);

}
echo json_encode($json);    //Réponse JSON
?>