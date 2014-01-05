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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $parameters);

if($etudiant !== false)
{
                
	$sql = "SELECT * FROM transaction WHERE refVendeur = ?";
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant);  
	$pdoStatement->execute();
	$transactionsVendeur = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Transaction');
        
        $sql = "SELECT * FROM transaction WHERE refAcheteur = ?";
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $etudiant->idEtudiant); 
	$pdoStatement->execute();
	$transactionsAcheteur = $pdoStatement->fetchAll(PDO::FETCH_CLASS, 'Transaction');
        
        foreach ($transactionsVendeur as $objetTransaction) 
        {       
                $sql = "SELECT login, nom, prenom, UT, telephone, email FROM etudiant WHERE idEtudiant = ?";
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetTransaction->refAcheteur); 
                $pdoStatement->execute();
                $infosAcheteur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetTransaction->infosAcheteur = $infosAcheteur;
                
                unset($objetTransaction->infosVendeur);
                unset($objetTransaction->codeValidation);
        }
        
        foreach ($transactionsAcheteur as $objetTransaction) 
        {
                $sql = "SELECT login, nom, prenom, UT, telephone, email FROM etudiant WHERE idEtudiant = ?";
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $objetTransaction->refVendeur); 
                $pdoStatement->execute();
                $infosVendeur = $pdoStatement->fetchAll(PDO::FETCH_ASSOC);
                $objetTransaction->infosVendeur = $infosVendeur;
                
                unset($objetTransaction->infosAcheteur);
        }
        
        
        $json = array(
		'error' => false,
                'transactionsVendeur' => $transactionsVendeur,
                'transactionsAcheteur' => $transactionsAcheteur               
	);

}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>