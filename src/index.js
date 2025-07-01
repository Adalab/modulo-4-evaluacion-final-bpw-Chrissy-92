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

// ENDPOINTS API

server.get("/api/frases", async (req, res) => {
  // SELECT - Listar todas las frases (con información del personaje y el título del capítulo)

  try {
    // 1. Conectarse a la bbdd
    const conn = await getConnection();

    // 2. Lanzar sentencia SELECT
    const [results] = await conn.query(`
      SELECT 
        f.idfrases,
        f.texto AS frase,
        f.marca_tiempo,
        p.nombre,
        p.apellido,
        p.ocupacion,
        c.titulo AS capitulo
      FROM frases f
      JOIN personajes p ON f.fk_personajes = p.idpersonajes
      JOIN personajes_aparecen_capitulos pac ON p.idpersonajes = pac.personajes_idpersonajes
      JOIN capitulos c ON pac.capitulos_idcapitulos = c.idcapitulos;
    `);

    // 3. Cerrar la conexión
    await conn.end();

    // 4. Devolver un json como respuesta a la petición o un objeto con el error
    if (results.length > 0) {
      res.json({
        success: true,
        data: results.map((f) => ({
          idfrases: f.idfrases,
          frase: f.frase,
          marca_tiempo: f.marca_tiempo,
          personaje: {
            nombre: f.nombre,
            apellido: f.apellido,
            ocupacion: f.ocupacion,
          },
          capitulo: {
            titulo: f.capitulo,
          },
        })),
      });
    } else {
      res.json({
        success: false,
        message: "No se encontraron frases registradas",
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Error interno al obtener las frases",
      error: error.message,
    });
  }
});

server.post("/api/frases", async (req, res) => {
  // INSERT - Insertar una nueva frase

  // 1. Conectarse a la bbdd
  try {
    const conn = await getConnection();

    const { texto, descripcion, marca_tiempo, fk_personajes } = req.body;

    if (!texto || !fk_personajes) {
      return res.status(400).json({
        success: false,
        message: "Faltan campos obligatorios: texto o fk_personajes",
      });
    }

    // 2. Lanzar sentencia INSERT
    const [result] = await conn.query(
      `
      INSERT INTO frases (texto, descripcion, marca_tiempo, fk_personajes)
      VALUES (?, ?, ?, ?);
    `,
      [texto, descripcion || null, marca_tiempo || null, fk_personajes]
    );

    // 3. Cerrar la conexión
    await conn.end();

    // 4. Devolver un json como respuesta a la petición (con el id generado) o un objeto con el error
    res.status(201).json({
      success: true,
      data: {
        idfrases: result.insertId,
        texto,
        descripcion: descripcion || null,
        marca_tiempo: marca_tiempo || null,
        fk_personajes,
      },
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Error al insertar la frase",
      error: error.message,
    });
  }
});

server.get("/api/frases/:id", async (req, res) => {
  // SELECT - Obtener una frase específica
  const { id } = req.params;

  try {
    // 1. Conexión a la base de datos
    const conn = await getConnection();

    // 2. Lanzamos sentencia SELECT
    const [results] = await conn.query(
      `
      SELECT 
        f.idfrases,
        f.texto AS frase,
        f.marca_tiempo,
        p.nombre,
        p.apellido,
        p.ocupacion,
        c.titulo AS capitulo
      FROM frases f
      JOIN personajes p ON f.fk_personajes = p.idpersonajes
      JOIN personajes_aparecen_capitulos pac ON p.idpersonajes = pac.personajes_idpersonajes
      JOIN capitulos c ON pac.capitulos_idcapitulos = c.idcapitulos
      WHERE f.idfrases = ?;
    `,
      [id]
    );

    // 3. Cierre de conexión
    await conn.end();

    // 4. Resultado encontrado
    if (results.length > 0) {
      const frase = results[0];
      res.json({
        success: true,
        data: {
          idfrases: frase.idfrases,
          frase: frase.frase,
          marca_tiempo: frase.marca_tiempo,
          personaje: {
            nombre: frase.nombre,
            apellido: frase.apellido,
            ocupacion: frase.ocupacion,
          },
          capitulo: {
            titulo: frase.capitulo,
          },
        },
      });
    } else {
      // 5. No se encontró la frase
      res.json({
        success: false,
        message: "Frase no encontrada con el id proporcionado",
      });
    }
  } catch (error) {
    // 6. Error en la ejecución
    res.status(500).json({
      success: false,
      message: "Error interno al obtener la frase",
      error: error.message,
    });
  }
});

server.put("/api/frases/:id", async (req, res) => {
  // UPDATE - Actualizar una frase existente

  try {
    // 1. Obtener el ID de la URL y los datos del body
    const { id } = req.params;
    const { texto, descripcion, marca_tiempo, fk_personajes } = req.body;

    if (!texto || !fk_personajes) {
      return res.status(400).json({
        success: false,
        message: "Faltan campos obligatorios: texto o fk_personajes",
      });
    }

    // 2. Conectarse a la base de datos
    const conn = await getConnection();

    // 3. Ejecutar UPDATE
    const [result] = await conn.query(
      `
      UPDATE frases
      SET texto = ?, descripcion = ?, marca_tiempo = ?, fk_personajes = ?
      WHERE idfrases = ?;
    `,
      [texto, descripcion || null, marca_tiempo || null, fk_personajes, id]
    );

    // 4. Cerrar conexión
    await conn.end();

    // 5. Evaluar resultado
    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "No se encontró ninguna frase con el ID proporcionado",
      });
    }

    // 6. Devolver datos actualizados
    res.json({
      success: true,
      data: {
        idfrases: Number(id),
        texto,
        descripcion: descripcion || null,
        marca_tiempo: marca_tiempo || null,
        fk_personajes,
      },
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Error al actualizar la frase",
      error: error.message,
    });
  }
});

server.delete("/api/frases/:id", async (req, res) => {
  // DELETE - Eliminar una frase

  try {
    // 1. Conectarse a la bbdd
    const conn = await getConnection();
    const { id } = req.params;

    // Verificar si la frase existe
    const [check] = await conn.query(
      "SELECT idfrases FROM frases WHERE idfrases = ?",
      [id]
    );

    if (check.length === 0) {
      await conn.end();
      return res.status(404).json({
        success: false,
        error: "No se encontró ninguna frase con el ID proporcionado",
      });
    }

    // 2. Lanzar sentencia DELETE FROM
    const [result] = await conn.query("DELETE FROM frases WHERE idfrases = ?", [
      id,
    ]);

    // 3. Cerrar la conexión
    await conn.end();

    // 4. Devolver un json como respuesta a la petición o un objeto con el error
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Error al eliminar la frase: " + error.message,
    });
  }
});

// ENDPOINT ERROR 404
server.use(/.*/, (req, res) => {
  res.status(404).send("Esa ruta no existe");
});
