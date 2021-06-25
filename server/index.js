const express = require('express');
const morgan = require('morgan');
const db = require('../database/index.js');

const app = express();
const PORT = 3005;

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.get('/products', (req, res) => {
  db.getProducts((err, data) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).send(data);
    }
  }, req.body.page, req.body.count);
});

app.get('/products/:productid', (req, res) => {
  let id = req.params.productid;
  db.getProductById((err, data) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).send(data);
    }
  }, id);
});

app.get('/products/:productid/styles', (req, res) => {
  let id = req.params.productid;
  db.getProductStyles((err, data) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.status(200).send(data);
    }
  }, id);
});

app.get('/products/:productid/related', (req, res) => {
  res.send('related products');
});

app.get('/cart', (req, res) => {
  res.send('cart');
});

app.post('/cart', (req, res) => {
  res.send('cart post');
});


app.listen(PORT, () => {
  console.log('Listening on port ' + PORT);
});