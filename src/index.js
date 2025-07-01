const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");
require("dotenv").config();

// Creamos una vari con el servidor
const server = express();

// Configuramos server para que funcione bien como API
server.use(cors());
server.use(express.json({ limit: "25Mb" }));

// Arrancamos el servidor en el puerto 4000
const port = 4000;
server.listen(port, () => {
  console.log(`🚀 El servidor está vivo en <http://localhost:${port}>`);
});

// EJEMPLO DE ENDPOINT

server.get("/", (req, res) => {
  console.log("Holis"); // -> Se ve en la terminal

  res.send("Holis Adalabers!!!"); // -> Se ve en la página
});

// SECCIÓN DE SERVIDOR DE APIS

// SECCIÓN DE SERVIDOR DE FICHEROS DINÁMICOS

// SECCIÓN DE SERVIDOR DE FICHEROS ESTÁTICOS
