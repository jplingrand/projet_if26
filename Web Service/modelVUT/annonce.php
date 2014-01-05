<?php
class Annonce 
{
    public $idAnnonce;
    public $refEtudiant;
    public $categorie;
    public $titre;
    public $texte;
    public $prix;
    public $valide;
    public $date;
    
    
    public $messages;
    public $infosAnnonceur;

    public function toDB()
    {
	$object = get_object_vars($this);
        $object['type'] = 'offre';
        $object['photo'] = '';
        unset($object['messages']);
        unset($object['infosAnnonceur']);
	return $object;
    }
    
}

/*
class Demande extends Annonce
{
      
    public function toDB()
    {
	$object = get_object_vars($this);
        $object['type'] = 'demande';
        $object['photo'] = '';
        unset($object['messages']);
	return $object;
    }
}

class Offre extends Annonce
{
    public $photo;
 
    public function toDB()
    {
	$object = get_object_vars($this);
        $object['type'] = 'offre';
        unset($object['messages']);
	return $object;
    }
}
*/

?>
