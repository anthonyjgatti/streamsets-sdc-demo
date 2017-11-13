CREATE DATABASE acme;

USE acme;

CREATE TABLE acme.transactions (
  cashier VARCHAR(50),
  item VARCHAR(50),
  transaction_time DATETIME,
  transaction_id INT,
  information_sku CHAR(3),
  information_price DECIMAL(13,2)
);
