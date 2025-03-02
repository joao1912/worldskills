const express = require("express")

const app = express();

const bgColor = process.env.BG_COLOR;

app.get('/', (req, res) => 
  res.send(`<body style="margin: 0; height: 100vh; background-color: ${bgColor.toLowerCase()};"></body>`)
);

app.listen(80, () => 
console.log('Servidor iniciado na porta 80')
);
