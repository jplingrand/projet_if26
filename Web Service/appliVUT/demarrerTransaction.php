<?php
require_once('../database/db.php');
require_once('../modelVUT/annonce.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/transaction.php');

function random($car) {
$string = "";
$chaine = "0123456789abcdefghijklmnpqrstuvwxy";
srand((double)microtime()*1000000);
for($i=0; $i<$car; $i++) {
$string .= $chaine[rand()%strlen($chaine)];
}
return $string;
}

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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);

if($etudiant !== false)
{
        $annonce = $db->find('Annonce', 'annonce', 'idAnnonce = :idAnnonce', $parameters);
        if($annonce != false)
        {
                if($annonce->valide == true && $etudiant->creditVUTs >= $annonce->prix)
                {
                        $annonce->valide = false;

                        $sql = "UPDATE annonce SET valide = ? WHERE idAnnonce = ?";
                        $pdoStatement = $db->pdo->prepare($sql);
                        $pdoStatement -> bindValue(1, $annonce->valide); 
                        $pdoStatement -> bindValue(2, $annonce->idAnnonce); 
                        $pdoStatement->execute();

                        $transaction = new Transaction();
                        $transaction->refAcheteur = $etudiant->idEtudiant;
                        $transaction->refVendeur = $annonce->refEtudiant;
                        $transaction->noteAcheteur = 10;
                        $transaction->noteVendeur = 10;
                        $transaction->statut = 'En cours';                
                        $transaction->titre = $annonce->titre;
                        $transaction->prix = $annonce->prix;

                        $codeValidation = random(8);
                        $transaction->codeValidation = $codeValidation;

                        if($db->insert($transaction, 'transaction'))
                        {       
                                $etudiant->creditVUTs -= $transaction->prix;
                                if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))
                                {                                                     
                                        $json = array(
                                                'error' => false,
                                        );
                                }
                        }
                }
        }  
}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>
