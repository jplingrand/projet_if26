<?php
require_once('../database/db.php');
require_once('../modelVUT/etudiant.php');
require_once('../modelVUT/transaction.php');

$parameters = array
(
	':token' => null,
        ':idTransaction' => null,
        ':codeValidation' => null
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
        $transaction = $db->find('Transaction', 'transaction', 'idTransaction = :idTransaction AND codeValidation = :codeValidation', $parameters);
        if($transaction !== false)
        {
                if($transaction->statut == 'En cours' && $transaction->refVendeur == $etudiant->idEtudiant)
                {
                        $transaction->statut = 'Validée';

                        $sql = "UPDATE transaction SET statut = ? WHERE idTransaction = ?";
                        $pdoStatement = $db->pdo->prepare($sql);
                        $pdoStatement -> bindValue(1, $transaction->statut); 
                        $pdoStatement -> bindValue(2, $transaction->idTransaction); 
                        $pdoStatement->execute();
             
                        $etudiant->creditVUTs += $transaction->prix;
                        if($db->update($etudiant, 'etudiant', 'idEtudiant = :idEtudiant', array(':idEtudiant' => $etudiant->idEtudiant)))
                        {                                                     
                                $json = array(
                                        'error' => false,
                                );
                        }
                }
        }
}
// echo json_encode($json, JSON_PRETTY_PRINT);            5.4 required!!
echo json_encode($json);
?>
