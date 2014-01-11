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

$sql = "SELECT idEtudiant, nbTentatives, dateTentative FROM etudiant WHERE login = ?";  //Requête pour tester si le login fait l'objet d'un bannissement (après 3 tentatives de connexion et durant 10 minutes)
$pdoStatement = $db->pdo->prepare($sql);
$pdoStatement -> bindValue(1, $parameters[':login']);  
$pdoStatement->execute();
$infosTestLogin = $pdoStatement->fetch(PDO::FETCH_ASSOC);

$testLogin = new Etudiant();    //Création d'un objet Etudiant temporaire $testLogin pour tester le bannissement
$testLogin->idEtudiant = $infosTestLogin['idEtudiant'];
$testLogin->nbTentatives = $infosTestLogin['nbTentatives'];
$testLogin->dateTentative = $infosTestLogin['dateTentative'];

date_default_timezone_set('Europe/Paris');      //Configuration du fuseau horaire pour l'utilisation ultérieure de time()

if ($testLogin->nbTentatives < 3 || (time() - strtotime($testLogin->dateTentative)) > 600) {    //Test si login non banni
    
        $prefixeSel = 'j5Uz74a8M2';
        $suffixeSel = 'pB61yE9k03';
        
        $password = md5($prefixeSel . $parameters[':password'] . $suffixeSel);  //Chiffrement et salage
    
        $sql = "SELECT * FROM etudiant WHERE login = ? and password = ?";   //Requête pour récupérer les informations de l'étudiant
        $pdoStatement = $db->pdo->prepare($sql);
        $pdoStatement -> bindValue(1, $parameters[':login']); 
        $pdoStatement -> bindValue(2, $password); 
        $pdoStatement->execute();
        $pdoStatement->setFetchMode(PDO::FETCH_CLASS, 'Etudiant');
        $etudiant = $pdoStatement->fetch(PDO::FETCH_CLASS);     //Affectation des infos à un objet Etudiant
                
        if($etudiant !== false)     //Test si bonne combinaison login/mot de passe
        {
                $token = md5(time() . $etudiant->login . $etudiant->password);  //Modification du token
                $etudiant->token = $token;
                $etudiant->nbTentatives = 0;

                if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))   //Mise à jour des données en BDD (token)
                {
                        //Infos de l'étudiant au format JSON
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
        else    //Si mauvaise combinaison
        {
                $testLogin->nbTentatives ++;
                $sql = "UPDATE etudiant SET nbTentatives = ?, dateTentative = CURRENT_TIMESTAMP WHERE idEtudiant = ?";  //Mise à jour des données en BDD (tentative)
                $pdoStatement = $db->pdo->prepare($sql);
                $pdoStatement -> bindValue(1, $testLogin->nbTentatives);
                $pdoStatement -> bindValue(2, $testLogin->idEtudiant);
                $pdoStatement->execute();                
        }
}


echo json_encode($json);    //Réponse en JSON
?>