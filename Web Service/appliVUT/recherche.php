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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);

if($etudiant !== false)
{
        //$annonces = $db->search('Annonce', 'annonce', 'categorie = :categorie AND prix >= :prixMin AND prix <= :prixMax AND titre = :mot-cle', $parameters);
        
	$sql = "SELECT * FROM annonce WHERE valide = 1 AND categorie = ? AND prix >= ? AND prix <= ? AND (titre LIKE ? OR texte LIKE ?)";
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $parameters[':categorie']); 
        $pdoStatement -> bindValue(2, $parameters[':prixMin']); 
        $pdoStatement -> bindValue(3, $parameters[':prixMax']);
        $pdoStatement -> bindValue(4, '%' . $parameters[':mot-cle'] . '%');
        $pdoStatement -> bindValue(5, '%' . $parameters[':mot-cle'] . '%');
	$pdoStatement->execute();
	$annonces = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Annonce');
        
        foreach ($annonces as $objetAnnonce) 
        {
                $sql = "SELECT login, UT FROM etudiant WHERE idEtudiant = ?";
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetAnnonce->refEtudiant); 
                $pdoStatement->execute();
                $infosAnnonceur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetAnnonce->infosAnnonceur = $infosAnnonceur;
                    
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
        }
        
        
        $json = array(
		'error' => false,
                'annonces' => $annonces
	);

}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>