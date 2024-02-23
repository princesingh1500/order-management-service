-- Database: order_management

-- DROP DATABASE order_management;

CREATE DATABASE order_management
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE = template0;

COMMENT ON DATABASE order_management
    IS 'Database to store all microservices data';