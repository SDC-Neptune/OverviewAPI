const { pool } = require('../config.js');

const getProducts = (callback, page = 1, count = 5) => {
  let offset = (page - 1) * count;
  console.log(offset);
  let queryArgs = [count, offset];
  let queryString = 'SELECT * FROM products ORDER BY id LIMIT $1 OFFSET $2';

  pool.query(queryString, queryArgs, (err, data) => {
    if (err) {
      callback(err);
    } else {
      callback(null, data.rows);
    }
  });
};

const getProductById = (callback, id) => {
  let queryArgs = [id];
  let queryString = 'SELECT p.*, json_agg(f.*) AS features FROM products p INNER JOIN features f ON f.product_id = p.id WHERE p.id = $1 GROUP BY p.id';

  pool.query(queryString, queryArgs, (err, data) => {
    if (err) {
      callback(err);
    } else {
      callback(null, data.rows[0]);
    }
  });
};

const getProductStyles = (callback, id) => {
  let queryArgs = [id];
  let queryString = 'SELECT s.style_id, s.name, s.sale_price, s.original_price, s."default?", json_agg(row_to_json (SELECT p.* FROM photos p WHERE p.styleid = s.style_id)) AS photos, json_agg(SELECT k.* FROM skus k WHERE k.styleid = s.style_id) AS skus FROM styles s WHERE productid = $1 GROUP BY s.style_id';

  // let queryString = 'SELECT s.style_id, s.name, s.sale_price, s.original_price, s."default?", json_agg(p.*) AS photos, json_agg(k.*) AS skus FROM styles s LEFT JOIN photos p ON p.styleid = s.style_id LEFT JOIN skus k ON k.styleid = s.style_id WHERE productid = $1 GROUP BY s.style_id';

  let obj = {
    'product_id': id,
  };

  pool.query(queryString, queryArgs, (err, data) => {
    if (err) {
      console.log(err);
      callback(err);
    } else {
      obj.results = data.rows;
      callback(null, obj);
    }
  });
};

const getRelatedProducts = () => {

};

const getCart = () => {

};

const addToCart = () => {

};

module.exports = {
  getProducts,
  getProductById,
  getProductStyles,
  getRelatedProducts,
  getCart,
  addToCart
};

