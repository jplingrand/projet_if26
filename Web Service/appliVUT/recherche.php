<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/message.php');

$parameters = array
(
	':token' => null,
	':categorie' => null,
        ':prixMin' => null,
        ':prixMax' => null,
        ':mot-cle' => null
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
                
	$sql = "SELECT * FROM annonce WHERE valide = 1 AND categorie = ? AND prix >= ? AND prix <= ? AND (titre LIKE ? OR texte LIKE ?)";   //Requête pour afficher les annonces en fonction des filtres
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $parameters[':categorie']); 
        $pdoStatement -> bindValue(2, $parameters[':prixMin']); 
        $pdoStatement -> bindValue(3, $parameters[':prixMax']);
        $pdoStatement -> bindValue(4, '%' . $parameters[':mot-cle'] . '%');
        $pdoStatement -> bindValue(5, '%' . $parameters[':mot-cle'] . '%');
	$pdoStatement->execute();
	$annonces = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Annonce');   //Création d' objets Annonce
        
        foreach ($annonces as $objetAnnonce) 
        {
                $sql = "SELECT login, UT FROM etudiant WHERE idEtudiant = ?";   //Requête pour récupérer les infos de l'annonceur
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetAnnonce->refEtudiant); 
                $pdoStatement->execute();
                $infosAnnonceur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetAnnonce->infosAnnonceur = $infosAnnonceur;
                    
                $sql = "SELECT * FROM message WHERE refAnnonce = ?";    //Requête pour récupérer les messages liés à l'annonce
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
        }
        
        
        $json = array(
		'error' => false,
                'annonces' => $annonces
	);

}
echo json_encode($json);    //Réponse JSON
?>