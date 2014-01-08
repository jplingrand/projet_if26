<?php
require_once('../database/db.php');
require_once('../modelVUT/etudiant.php');

$parameters = array
(
	':login' => null,
	':password' => null
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

$sql = "SELECT idEtudiant, nbTentatives, dateTentative FROM etudiant WHERE login = ?";
$pdoStatement = $db->pdo->prepare($sql);
$pdoStatement -> bindValue(1, $parameters[':login']);  
$pdoStatement->execute();
$infosTestLogin = $pdoStatement->fetch(PDO::FETCH_ASSOC);

$testLogin = new Etudiant();
$testLogin->idEtudiant = $infosTestLogin['idEtudiant'];
$testLogin->nbTentatives = $infosTestLogin['nbTentatives'];
$testLogin->dateTentative = $infosTestLogin['dateTentative'];

date_default_timezone_set('Europe/Paris');

if ($testLogin->nbTentatives < 3 || (time() - strtotime($testLogin->dateTentative)) > 600) {
    
        $prefixeSel = 'j5Uz74a8M2';
        $suffixeSel = 'pB61yE9k03';
        
        $password = md5($prefixeSel . $parameters[':password'] . $suffixeSel);
    
        $sql = "SELECT * FROM etudiant WHERE login = ? and password = ?";
        $pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $parameters[':login']); 
        $pdoStatement -> bindValue(2, $password); 
        $pdoStatement->execute();
        $pdoStatement->setFetchMode(PDO::FETCH_CLASS, 'Etudiant');
        $etudiant = $pdoStatement->fetch(PDO::FETCH_CLASS);
                
        if($etudiant !== false)
        {
                $token = md5(time() . $etudiant->login . $etudiant->password);
                $etudiant->token = $token;
                $etudiant->nbTentatives = 0;

                if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))
                {
                        $json = array(
                                'error' => false,
                                'idEtudiant' => $etudiant->idEtudiant,
                                'token' => $etudiant->token,
                                'nom' => $etudiant->nom,
                                'prenom' => $etudiant->prenom,
                                'UT' => $etudiant->UT,
                                'telephone' => $etudiant->telephone,
                                'email' => $etudiant->email,
                                'creditVUTs' => $etudiant->creditVUTs
                        );
                }
        }
        else
        {
                $testLogin->nbTentatives ++;
                $sql = "UPDATE etudiant SET nbTentatives = ?, dateTentative = CURRENT_TIMESTAMP WHERE idEtudiant = ?";
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $testLogin->nbTentatives);
                $pdoStatement -> bindValue(2, $testLogin->idEtudiant);
                $pdoStatement->execute();                
        }
}


// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>