CREATE DATABASE acme;
GRANT ALL PRIVILEGES ON acme.* TO 'sdc_user'@'%' IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON acme.* TO 'sdc_user'@'localhost' IDENTIFIED BY 'mysql';
USE mydb

CREATE TABLE transactions (
  transaction_id BIGINT,
  transaction_time DATETIME,
  cashier VARCHAR(50),
  item VARCHAR(50),
  information_sku CHAR(3),
  information_price DECIMAL(13,2)
);
