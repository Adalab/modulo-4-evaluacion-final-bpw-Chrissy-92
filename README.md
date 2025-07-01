# API Frases de Los Simpson

API REST desarrollada con **Node.js**, **Express** y **MySQL** para gestionar frases de personajes de **Los Simpson**.

---

## Tecnologías utilizadas

- Node.js + Express
- MySQL
- mysql2/promise
- dotenv
- CORS

---

## Instalación y configuración

### 1. Clona el repositorio

```bash
git clone https://github.com/tu-usuario/tu-repositorio.git
cd tu-repositorio
```

### 2. Instala las dependencias:

```bash
   npm install
```

### 3. Configura las variables de entorno

Copia el archivo de ejemplo `.env.example` como `.env` y edítalo, completando tus credenciales de base de datos.

## Importar la base de datos MySQL

### 1. Crea la base de datos (si no existe)

CREATE DATABASE the_simpsons CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

### 2. Importa el dump

Desde la terminal:

```bash
   mysql -u tu_usuario -p the_simpsons < db/database_the_simpsons.sql
```

Asegúrate de que el archivo database_the_simpsons.sql esté en la carpeta /db.

## Inicia el servidor desde la carpeta del proyecto:

### Modo desarrollo (con nodemon)

```bash
   npm run dev
```

### Modo producción

```bash
   npm start
```

El servidor arrancará en: http://localhost:4000

## Endpoints disponibles

### Obtener todas las frases

- `GET /api/frases`

### Obtener una frase por ID

- `GET /api/frases/:id`

### Crear una nueva frase

- `POST /api/frases`
  {
  "texto": "¡Ay, caramba!",
  "descripcion": "Frase icónica de Bart",
  "marca_tiempo": "00:02:45",
  "fk_personajes": 1
  }

### Actualizar una frase

- `PUT /api/frases/:id`

### Eliminar una frase

- `DELETE /api/frases/:id`

## Notas

Asegúrate de tener creada la base de datos y las tablas necesarias antes de iniciar el servidor.

## Author:

Cristina Angélica Pérez Huerta
