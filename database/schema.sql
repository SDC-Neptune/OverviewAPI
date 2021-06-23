CREATE DATABASE sdc;

USE sdc;

CREATE TABLE products (
  id INT AUTO_INCREMENT Primary Key,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price INT(255) NOT NULL
);

CREATE TABLE styles (
  id INT AUTO_INCREMENT Primary Key,
  product_id INT,
  name VARCHAR(255) NOT NULL,
  original_price INT(255) NOT NULL,
  sale_price INT(255),
  default_style INT(1) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE characteristics (
  id INT AUTO_INCREMENT Primary Key,
  product_id INT,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE related (
  id INT AUTO_INCREMENT Primary Key,
  current_product_id INT,
  related_product_id INT,
  FOREIGN KEY(current_product_id) REFERENCES products(id),
  FOREIGN KEY(related_product_id) REFERENCES products(id)
);

CREATE TABLE features (
  id INT AUTO_INCREMENT Primary Key,
  product_id INT,
  feature VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE photos (
  id INT AUTO_INCREMENT Primary Key,
  styleId INT,
  url VARCHAR(255) NOT NULL,
  tumbnail_url VARCHAR(255) NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);

CREATE TABLE cart (
  id INT AUTO_INCREMENT Primary Key,
  user_session INT(255) NOT NULL,
  product_id INT,
  active INT(1) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE skus (
  id INT AUTO_INCREMENT Primary Key,
  styleId INT,
  size VARCHAR(10) NOT NULL,
  quantity INT(255) NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);

-- mysql -u root -p password < database/schema.sql