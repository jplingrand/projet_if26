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

$etudiant = $db->find('Etudiant', 'etudiant', 'token = :token', $etudiantParameters);   //Requête pour vérifier le token de l'étudiant 

if($etudiant !== false)     //Test si le token est bon
{
        $annonce = $db->find('Annonce', 'annonce', 'idAnnonce = :idAnnonce', $parameters);  //Récupération de l'annonce
        if($annonce != false)
        {
                if($annonce->valide == true && $etudiant->creditVUTs >= $annonce->prix) //Test si l'étudiant peut payer le montant annoncé et si l'annonce est valide
                {
                        $annonce->valide = false;   //Modification du statut

                        $sql = "UPDATE annonce SET valide = ? WHERE idAnnonce = ?";     //Mise à jour en BDD
                        $pdoStatement = $db->pdo->prepare($sql);
                        $pdoStatement -> bindValue(1, $annonce->valide); 
                        $pdoStatement -> bindValue(2, $annonce->idAnnonce); 
                        $pdoStatement->execute();

                        $transaction = new Transaction();       //Création d'un objet Transaction correspondant à l'annonce
                        $transaction->refAcheteur = $etudiant->idEtudiant;
                        $transaction->refVendeur = $annonce->refEtudiant;
                        $transaction->noteAcheteur = 10;
                        $transaction->noteVendeur = 10;
                        $transaction->statut = 'En cours';                
                        $transaction->titre = $annonce->titre;
                        $transaction->prix = $annonce->prix;

                        $codeValidation = random(8);    //Génération d'un code de validation destiné à l'acheteur
                        $transaction->codeValidation = $codeValidation;

                        if($db->insert($transaction, 'transaction'))    //Insertion de la transaction en BDD
                        {       
                                $etudiant->creditVUTs -= $transaction->prix;    //Compte VUT de l'acheteur débité
                                if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))   //Mise à jour en BDD
                                {                                                     
                                        $json = array(
                                                'error' => false,
                                        );
                                }
                        }
                }
        }  
}
echo json_encode($json);    //Réponse JSON
?>
