<?php

namespace Core;

use PDO; //including PDO for db queries


class Database {

	// Class Properties
	private $connection;
	private $statement;

	//Calls whtn intantiating the Database class
	// The construct requires three varibles
	// config contaning configurations data - is an array
	// database username and password
	public function __construct(
		array $config, 
		string $username = 'root', 
		string $password = '1111111111'
	) {	

		//Making a query
		//Eg. passed as array ['']
		//		['host'  	=> 'localhost',
			// 'port'  	=> 3306,
			// 'dbname' 	=> 'futsal',
			// 'charset' 	=> 'utf8mb4'],
		//This becomes
		//mysqli:host:localhost;port:3306;dbname:futsal;charset:utf8mb4;
		$dsn = "mysql:" . http_build_query($config, '', ';');

		//Intantiating the PDO class
		//And assigning a variable
		$this->connection = new PDO($dsn, $username, $password, [
			PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
			PDO::ATTR_EMULATE_PREPARES   => false,
			PDO::ATTR_STRINGIFY_FETCHES  => false,
		]);

	}


	// Function to make query to db
	public function query($query, $params = []) {

		//Assign as a variable
		$this->statement = $this->connection->prepare($query);

		//Executing the query
		$this->statement->execute($params);

		// Returning this Database Class
		// THis is beacause we can chain other functions and methods
		// Eg. $db->query({variables})->get();
		return $this;

	}

	
	public function get() {

		return $this->statement->fetchAll();

	}

	public function total() {

		return $this->statement->fetchColumn();

	}

	public function find() {

		return $this->statement->fetch();

	}

	public function findOrfail() {

		$result = $this->statement->fetch();

		if(!$result) 

			abort404();

		return $result;

	}


}


