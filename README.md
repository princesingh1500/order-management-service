# Order Microservice : RESTful API service in golang using Gin
## Introduction

A simple RESTful API microservice written in Go using the gin framework. This service exposes the APIs for the following operations related to orders :
1. Add an order
2. Get an order details
3. Update an order

All requests made to this service store their data in PostgreSQL.

## Pre-requisites / Service Dependency

Make sure you have the following installed:

1. PostgreSQL server, and running on local machine or a working environment
2. Go Language (1.8 or above)
3. Clone the application
4. Install Go package dependencies by running the below commands from **$GOPATH/src** (go workspace)

    `go get github.com/gin-gonic/gin
    go get gopkg.in/gorp.v1
    go get -u github.com/lib/pq`
5. Log into PostgreSQL DB, and create a `order_management` database. Further details explained in next section.    

## Setting up PostgreSQL DB for Order service

**For the order service, a new database `order_management` needs to be created into PostgreSQL server.** Using the **psql tool** or **pgAdmin 4 GUI interface**, execute the SQL script to create this new DB. The SQL script is present at the following location in the codebase :
    
    scripts/db/create_db.sql

## Initializing the PostgreSQL Database for Order Service
Before initializing the DB to support this service, please ensure to put the correct DB configs w.r.t your testing environment in the following file in codebase :
    
    configs/dbconf.json
Typically, the values for **password** key might need to be changed : 
    
    {
      "host": "localhost",
      "port": 5432,
      "user": "postgres",
      "password": "xxxx",
      "dbname": "order_management"
    }
    
Once the correct values for DB configs are replaced, run the following command from the directory in which **`db.go`** is located ($GOPATH/src/order/cmd/db). This command will run the executable to initialize the DB.
    
    go run db.go

## Starting the Service
1. Start Go order service locally. Run the following command from the directory in which **`main.go`** is located ($GOPATH/src/order/cmd/main). This command will run the executable to start the service.
    
    `go run main.go`
    
2. Play with order endpoints to add/update/get order.

The endpoints can be invoked using the popular `curl` command or any REST client such as `POSTMAN`, etc.

* _Ping to check service health_
    
    
    HTTP METHOD : HEAD
    URL : http://localhost:8080/v1/order

* _Create a new order_

    
    HTTP METHOD : POST
    URL : http://localhost:8080/v1/order
    Content-Type : application/json; charset=utf-8
    RAW DATA : {
                 "customer_name": "Mikko Suominen",
                 "products": [
                   {"product_id":5,"product_ean":"6480201379621"},
                   {"product_id":6,"product_ean":"3912345123412"}
                 ]
               }

* _Show an existing order details_
    
    
    HTTP METHOD : GET
    URL : http://localhost:8080/v1/order/{order_id}
    SAMPLE URL : http://localhost:8080/v1/order/10

* Update an existing order
    
    
    HTTP METHOD : PUT
    URL : http://localhost:8080/v1/order/{order_id}
    SAMPLE URL : http://localhost:8080/v1/order/10
    Content-Type : application/json; charset=utf-8
    RAW DATA : {
                 "customer_name": "David Suominen",
                 "products": [
                   {"product_id":4,"product_ean":"658020137962"},
                   {"product_id":6,"product_ean":"3912345123412"}
                 ]
               }
               
## Source Code Documentation (godoc)

The source code documentation for this service can be found as a HTML file located at the following location in the codebase :

    docs/godoc.html

The above HTML documentation has been generated by running the godoc command from **$GOPATH/src** folder as shown below :

`godoc -html order/app > godoc.html`

## Limitations

In the order microservice and the v1 ver. of the Order APIs, there are a few limitations due to the given time constraints. However, these limitations can be resolved in subsequent commits to this repo.

The limitations are listed below :

1. _Foreign Key Constraint_ : The tables required for the Order microservice have been created through the code, when the DB is initialized. On one particular table named 'order_products', foreign key constraints could not be specified as currently, there is no support for foreign keys in package gorp.
2. _Update API_ : v1 ver. of update API supports only product details updation in the existing order. New products addition and existing products deletion from existing order can be supported in v2 ver. of API.
3. _Support for DB transactions_ : Ideally, the add/update operations for writing/updating data on the postgres DB should happen in a transaction. If all data operations are success, then only transaction should be committed, else it should be rollbacked. Support for all data operations on DB that change its state to happen in a single transaction for each API request is pending.
 