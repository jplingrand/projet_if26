<?php
class Message
{
	public $idMessage;
        public $refEtudiant;
	public $refAnnonce;
	public $texte;
	public $date;
        
        
        public $infosEmetteur;

	public function toDB()
	{
		$object = get_object_vars($this);
		unset($object['infosEmetteur']);
		return $object;
	}
}