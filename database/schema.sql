CREATE TABLE products (
  id SERIAL Primary Key,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR(1000) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price VARCHAR(255) NOT NULL,
  created_at TIMESTAMP now(),
  updated_at TIMESTAMP now()
);

CREATE TABLE styles (
  style_id SERIAL Primary Key,
  productId INT,
  name VARCHAR(255) NOT NULL,
  sale_price VARCHAR(255),
  original_price VARCHAR(255) NOT NULL,
  "default?" BOOLEAN NOT NULL,
  FOREIGN KEY(productId) REFERENCES products(id)
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
  thumbnail_url VARCHAR(1000) NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);

CREATE TABLE skus (
  id SERIAL Primary Key,
  styleId INT,
  size VARCHAR(10) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY(styleId) REFERENCES styles(id)
);

CREATE INDEX idx_styles_productId ON styles(productId);

CREATE INDEX idx_related_current_id ON related(current_product_id);

CREATE INDEX idx_related_related_id ON related(current_related_id);

CREATE INDEX idx_features_product_id ON features(product_id);

CREATE INDEX idx_photos_styleId ON photos(styleId);

CREATE INDEX idx_skus_styleId ON skus(styleId);

-- \copy table_name from file_path with (format csv, header, NULL "null")