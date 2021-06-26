/* eslint-disable quotes */
const { pool } = require('../config.js');

const getProducts = (callback, page = 1, count = 5) => {
  let offset = (page - 1) * count;
  let queryArgs = [count, offset];
  let queryString = `
    SELECT
      *
    FROM
      products
    ORDER BY
      id
    LIMIT
      $1
    OFFSET
      $2
  `;

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
  let queryString = `
    SELECT
      p.*,
      json_agg(to_jsonb(f) #- '{id}' #- '{product_id}') AS features
    FROM
      products p
    INNER JOIN
      features f ON f.product_id = p.id
    WHERE
      p.id = $1
    GROUP BY
      p.id
  `;

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
  let queryString = `
    SELECT
      s.style_id,
      s.name,
      s.sale_price,
      s.original_price,
      s."default?",
      (SELECT json_agg(to_jsonb(p) #- '{id}' #- '{styleid}') FROM photos p WHERE (p.styleid = s.style_id)) AS photos,
      (SELECT json_object_agg(k.id, to_jsonb(k) #- '{id}' #- '{styleid}') FROM skus k WHERE (k.styleid = s.style_id)) AS skus
    FROM
      styles s
    WHERE
      productid = $1
    GROUP BY
      s.style_id
  `;

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

const getRelatedProducts = (callback, id) => {
  let queryArgs = [id];
  let queryString = `
    SELECT
      array_agg(related_product_id)
    FROM
      related
    WHERE
      current_product_id = $1
  `;

  pool.query(queryString, queryArgs, (err, data) => {
    if (err) {
      console.log(err);
      callback(err);
    } else {
      callback(null, data.rows[0].array_agg);
    }
  });
};

module.exports = {
  getProducts,
  getProductById,
  getProductStyles,
  getRelatedProducts
};

