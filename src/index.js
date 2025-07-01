const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");
require("dotenv").config();

// Creamos una vari con el servidor
const server = express();

// Configuramos server para que funcione bien como API
server.use(cors());
server.use(express.json({ limit: "25Mb" }));

// Función para conectar con la base de datos

async function getConnection() {
  const connData = {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  };

  const conn = await mysql.createConnection(connData);
  await conn.connect();

  return conn;
}

// Arrancamos el servidor en el puerto 4000
const port = 4000;
server.listen(port, () => {
  console.log(`🚀 El servidor está vivo en <http://localhost:${port}>`);
});

// ENDPOINTS API

server.get("/api/frases", async (req, res) => {
  // SELECT * - Listar todas las frases(con información del personaje y el título del capítulo)

  // 1. Hacer las validaciones que consideremos

  // 2. Conectarse a la bbdd
  const conn = await getConnection();

  // 3. Lanzar sentencia SELECT

  // 4. Cerrar la conexión

  // 5. Devolver un json como respuesta a la petición
  //    o un objeto con el error
});

server.post("/api/frases", async (req, res) => {
  // INSERT INTO -> DEVUELVE UN OBJETO CON SUCCESS Y EL ID/DATOS CREADOS O UN ERROR
  // 1. Hacer las validaciones que consideremos
  // 2. Conectarse a la bbdd
  // 3. Lanzar sentencia INSERT
  // 4. Cerrar la conexión
  // 5. Devolver un json como respuesta a la petición (con el id generado)
  //    o un objeto con el error
});

server.get("/api/frases:id", (req, res) => {
  // SELECT FROM id = - Obtener una frase específica
  // DEVOLVER UN ARRAY DE OBJ
});

server.put("/api/frases/:id", async (req, res) => {
  // UPDATE -> Actualizar una frase existente
  // 1. Hacer las validaciones que consideremos
  // 2. Conectarse a la bbdd
  // 3. Lanzar sentencia UPDATE
  // 4. Cerrar la conexión
  // 5. Devolver un json como respuesta a la petición
  //    o un objeto con el error
  // {success: false, error: "" }
  // {success: true, id:}
});

server.delete("/api/frases/:id", async (req, res) => {
  // DELETE FROM -> Eliminar una frase
  // 1. Hacer las validaciones que consideremos
  // 2. Conectarse a la bbdd
  // 3. Lanzar sentencia DELETE FROM
  // 4. Cerrar la conexión
  // 5. Devolver un json como respuesta a la petición
  //    o un objeto con el error
  // {success: false, error: "" }
  // {success: true}
});

// ENDPOINT ERROR 404
server.use(/.*/, (req, res) => {
  res.status(404).send("Esa ruta no existe");
});
