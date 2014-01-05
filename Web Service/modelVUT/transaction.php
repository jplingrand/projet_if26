<?php
class Transaction
{
    public $idTransaction;
    public $refAcheteur;
    public $refVendeur;
    public $noteAcheteur;
    public $noteVendeur;
    public $statut;
    public $titre;
    public $prix;
    public $codeValidation;
    
    public $infosVendeur;
    public $infosAcheteur;
    
    public function toDB()
    {
	$object = get_object_vars($this);
        unset($object['infosVendeur']);
        unset($object['infosAcheteur']);
	return $object;
    }
}


?>
