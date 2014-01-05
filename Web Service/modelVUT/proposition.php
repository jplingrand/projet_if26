<?php
class Proposition
{
    public $idProposition;
    public $refDemande;
    public $refEtudiant;
    public $texte;
    public $prix;
    
    public function toDB()
    {
	$object = get_object_vars($this);
	return $object;
    }
}

?>