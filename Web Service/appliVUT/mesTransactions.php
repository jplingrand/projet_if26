<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/transaction.php');

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
                
	$sql = "SELECT * FROM transaction WHERE refVendeur = ?";    //Requête pour afficher toutes les transactions où l'étudiant est le vendeur
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant);  
	$pdoStatement->execute();
	$transactionsVendeur = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Transaction');    //Création d'objets Transaction
        
        $sql = "SELECT * FROM transaction WHERE refAcheteur = ?";       //Requête pour afficher toutes les transactions où l'étudiant est l'acheteur
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant); 
	$pdoStatement->execute();
	$transactionsAcheteur = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Transaction');       //Création d'objets Transaction
        
        foreach ($transactionsVendeur as $objetTransaction) 
        {       
                $sql = "SELECT login, nom, prenom, UT, telephone, email FROM etudiant WHERE idEtudiant = ?";    //Requête pour récupérer les infos sur l'acheteur
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetTransaction->refAcheteur); 
                $pdoStatement->execute();
                $infosAcheteur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetTransaction->infosAcheteur = $infosAcheteur;
                
                unset($objetTransaction->infosVendeur);     //Car l'étudiant connecté est le vendeur
                unset($objetTransaction->codeValidation);
        }
        
        foreach ($transactionsAcheteur as $objetTransaction) 
        {
                $sql = "SELECT login, nom, prenom, UT, telephone, email FROM etudiant WHERE idEtudiant = ?";    //Requête pour récupérer les infos sur le vendeur
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetTransaction->refVendeur); 
                $pdoStatement->execute();
                $infosVendeur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetTransaction->infosVendeur = $infosVendeur;
                
                unset($objetTransaction->infosAcheteur);    //Car l'étudiant connecté est l'acheteur
        }
        
        //Infos sur les transactions au format JSON
        $json = array(
		'error' => false,
                'transactionsVendeur' => $transactionsVendeur,
                'transactionsAcheteur' => $transactionsAcheteur               
	);

}
echo json_encode($json);    //Réponse JSON
?>