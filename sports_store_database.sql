---------------------------------------------------
/*
    This file contains the commands for creating
    the database, its tables, their columns,
    and importing the data which in the csv files
    into the tables of the database
*/
---------------------------------------------------

DROP DATABASE IF EXISTS sports_store;
CREATE DATABASE sports_store;

---------------------------------------------------

DROP TABLE IF EXISTS info;
CREATE TABLE info(
    product_name VARCHAR(100),
    product_id VARCHAR(15) PRIMARY KEY,
    description VARCHAR(500)
);

-- To load data into the tables
LOAD DATA LOCAL INFILE 'path\info.csv'
    INTO TABLE info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

---------------------------------------------------

DROP TABLE IF EXISTS finance;
CREATE TABLE finance(
    product_id VARCHAR(15) PRIMARY KEY,
    listing_price DECIMAL(6, 2),
    sale_price DECIMAL(6, 2),
    discount DECIMAL(2, 2),
    revenue DECIMAL(8,2)
);

-- To load data into the tables
LOAD DATA LOCAL INFILE 'path\finance.csv'
INTO TABLE finance
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

---------------------------------------------------

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
    product_id VARCHAR(15) PRIMARY KEY,
    rating DECIMAL(2, 1),
    reviews INT
);

-- To load data into the tables
LOAD DATA LOCAL INFILE 'path\reviews.csv' INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

---------------------------------------------------

DROP TABLE IF EXISTS traffic;
CREATE TABLE traffic(
    product_id VARCHAR(15),
    last_visited DATETIME
);

-- To load data into the tables
LOAD DATA LOCAL INFILE 'path\traffic.csv' INTO TABLE traffic
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

---------------------------------------------------

DROP TABLE IF EXISTS brands;
CREATE TABLE brands(
    product_id VARCHAR(15),
    brand VARCHAR(15)
);

-- To load data into the tables
LOAD DATA LOCAL INFILE 'path\brands.csv' INTO TABLE brands
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

---------------------------------------------------