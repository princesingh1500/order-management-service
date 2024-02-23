package main

import (
	"log"
	"order-management/app"

	_ "github.com/lib/pq"
)

// main is invoked when this executable runs.
// Establishes a connection to desired DB and initializes the DB
func main() {

	// initialize the DB and create required tables
	app.InitDB()
	log.Println("Initialized the DB successfully")
}
