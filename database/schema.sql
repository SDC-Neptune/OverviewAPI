CREATE TABLE products (
  id SERIAL Primary Key,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR(1000) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price INT NOT NULL
);

CREATE TABLE styles (
  id SERIAL Primary Key,
  productId INT,
  name VARCHAR(255) NOT NULL,
  sale_price INT,
  original_price INT NOT NULL,
  default_style INT NOT NULL,
  FOREIGN KEY(productId) REFERENCES products(id)
);

CREATE TABLE characteristics (
  id SERIAL Primary Key,
  product_id INT,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE related (
  id SERIAL Primary Key,
  current_product_id INT,
  related_product_id INT,
  FOREIGN KEY(current_product_id) REFERENCES products(id)
);

CREATE TABLE features (
  id SERIAL Primary Key,
  product_id INT,
  feature VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE photos (
  id SERIAL Primary Key,
  styleId INT,
  url VARCHAR(1000) NOT NULL,
  tumbnail_url VARCHAR(1000) NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);

CREATE TABLE cart (
  id SERIAL Primary Key,
  user_session INT NOT NULL,
  product_id INT,
  active INT NOT NULL,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE skus (
  id SERIAL Primary Key,
  styleId INT,
  size VARCHAR(10) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);