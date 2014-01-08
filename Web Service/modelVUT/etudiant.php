<?php
class Etudiant
{
	public $idEtudiant;
	public $login;
        public $password;
        public $token;
        public $nom;
	public $prenom;
	public $UT;
	public $telephone;
        public $email;
        public $creditVUTs;
        public $nbTentatives;
        public $dateTentative;
        

	public function toDB()
	{
		$object = get_object_vars($this);
		return $object;
	}
}