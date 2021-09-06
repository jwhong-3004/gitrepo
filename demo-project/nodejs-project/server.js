'use strict';

const express = require('express');

// 상수
const HOST = '0.0.0.0';
const PORT = 8080;

// 앱
const app = express();
app.get('/', (req, res) => {
  res.send('NodeJS Project');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);