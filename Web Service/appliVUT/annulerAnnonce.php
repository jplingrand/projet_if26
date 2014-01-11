<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');

$parameters = array
(
	':token' => null,
        ':idAnnonce' => null,
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
        $sql = "SELECT * FROM annonce WHERE idAnnonce = ? AND refEtudiant = ?";     //Requête pour récupérer l'annonce à annuler
	$pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $parameters[':idAnnonce']);  
        $pdoStatement -> bindValue(2, $etudiant->idEtudiant);  
	$pdoStatement->execute();
        $pdoStatement->setFetchMode(PDO::FETCH_CLASS, 'Annonce');   
	$annonce = $pdoStatement->fetch(PDO::FETCH_CLASS);  //Création de l'objet Annonce
        
        if ($annonce !== false)
        {
                $annonce->valide = false;   //Modification du statut
        }

        $sql = "UPDATE annonce SET valide = ? WHERE idAnnonce = ?";     //Mise à jour en BDD
        $pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $annonce->valide); 
        $pdoStatement -> bindValue(2, $annonce->idAnnonce); 
        $modif = $pdoStatement->execute();

        if($modif !== false)
        {
                $json = array(
                        'error' => false,
                );
        }
}
echo json_encode($json);    //Réponse JSON
?>
