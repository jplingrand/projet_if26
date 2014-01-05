<?php

return array
(
	'dsn' => 'mysql:dbname=virtuals_uts;host=localhost',
	'username' => 'root',
	'password' => '',
	'options' => array
	(
		PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"
	)
);
