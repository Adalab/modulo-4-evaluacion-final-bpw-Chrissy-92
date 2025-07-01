CREATE DATABASE  IF NOT EXISTS `the_simpsons` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `the_simpsons`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: the_simpsons
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `capitulos`
--

DROP TABLE IF EXISTS `capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos` (
  `idcapitulos` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `numero_episodio` int DEFAULT NULL,
  `temporada` int DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `sinopsis` longtext,
  PRIMARY KEY (`idcapitulos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos`
--

LOCK TABLES `capitulos` WRITE;
/*!40000 ALTER TABLE `capitulos` DISABLE KEYS */;
INSERT INTO `capitulos` VALUES (1,'Lisa’s First Word',10,4,'1992-12-03','La familia Simpson recuerda los momentos alrededor del nacimiento de Lisa. A lo largo del episodio, se muestra cómo Bart, siendo bebé, vivió varios episodios clave de su infancia. En particular, cuando entra inesperadamente en la habitación y presencia una escena íntima entre Homero y Marge, exclama sorprendido “¡Ay, caramba!”, que resulta ser su primera palabra'),(2,'Simpsons Roasting on an Open Fire',1,1,'1989-12-17','Homer es Papá Noel, apuesta su paga extra, pierde y adopta a Santa’s Little Helper. Debuta su icónica expresión “D’oh!”'),(3,' Little Big Mom',10,11,'2000-12-03','En este capítulo, Homero acompaña a Marge y su madre a una excursión de esquí. Ned Flanders aparece con un ceñido traje de esquí mostrando una figura admirada por Homero, quien observa su trasero y exclama con humor: “¡Estúpido Flanders y su erotismo!');
/*!40000 ALTER TABLE `capitulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frases`
--

DROP TABLE IF EXISTS `frases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frases` (
  `idfrases` int NOT NULL AUTO_INCREMENT,
  `texto` longtext NOT NULL,
  `marca_tiempo` time DEFAULT NULL,
  `descripcion` longtext,
  `fk_personajes` int NOT NULL,
  PRIMARY KEY (`idfrases`),
  KEY `fk_frases_personajes_idx` (`fk_personajes`),
  CONSTRAINT `fk_frases_personajes` FOREIGN KEY (`fk_personajes`) REFERENCES `personajes` (`idpersonajes`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frases`
--

LOCK TABLES `frases` WRITE;
/*!40000 ALTER TABLE `frases` DISABLE KEYS */;
INSERT INTO `frases` VALUES (1,'D\'oh',NULL,NULL,2),(2,'Si no tienes nada bueno que decir, ven a sentarte aquí conmigo',NULL,NULL,1),(3,'Muy bien. No me casaré nunca',NULL,NULL,4),(4,'Es curioso cómo la música puede hacer que los recuerdos vuelvan',NULL,NULL,4),(6,'¡Excelente!',NULL,NULL,5),(7,'¡Ay, caramba!',NULL,NULL,3),(8,'Tiene todo el dinero del mundo, pero hay algo que no puede comprar… Un dinosaurio.',NULL,NULL,2),(9,'¡Estúpido Flanders y su erotismo!','00:12:34','Homero se burla de Ned Flanders en tono jocoso.',2);
/*!40000 ALTER TABLE `frases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes`
--

DROP TABLE IF EXISTS `personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes` (
  `idpersonajes` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `ocupacion` varchar(100) DEFAULT NULL,
  `descripcion` longtext,
  PRIMARY KEY (`idpersonajes`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes`
--

LOCK TABLES `personajes` WRITE;
/*!40000 ALTER TABLE `personajes` DISABLE KEYS */;
INSERT INTO `personajes` VALUES (1,'Marge','Simpson','Ama de casa','Marjorie Marge B. Simpson, (de soltera Bouvier; nacida el 19 de marzo), es la feliz ama de casa y madre de tiempo completo de la familia Simpson. Con su esposo Homero, tiene tres hijos: Bart, Lisa y Maggie Simpson. Marge es la fuerza moralista en su familia. A menudo, proporciona una voz fundamental en medio de las payasadas de su familia al tratar de mantener el orden en la casa de los Simpson. Aparte de sus deberes en el hogar, Marge coqueteó brevemente con una serie de carreras que van desde oficial de policía hasta activista contra la violencia.'),(2,'Homer','Simpson','Inspector de Seguridad Nuclear','Homer Jay Simpson, anteriormente conocido como Max Power, es el padre de la familia Simpson. Tiene sobrepeso, es perezoso e ignorante, pero también es muy devoto de su esposa e hijos. Trabaja como inspector de seguridad de bajo nivel en la planta de energía nuclear de Springfield. Tiene una escasa capacidad de concentración, además ser muy impulsivo, que complementa con su pasión efímera por varias aficiones y empresas. Homero es propenso a las explosiones emocionales, muy envidioso de sus vecinos (la familia de Ned Flanders), y fácilmente se enfada con Bart, estrangulándolo con frecuencia. No muestra ningún remordimiento por ello y no trata de ocultar sus acciones a la gente de fuera de la familia, incluso hace caso omiso del bienestar de su hijo. Estos hechos se pueden atribuir a que Homero no se da cuenta de sus responsabilidades.'),(3,'Bart','Simpson','Estudiante en la Escuela primaria de Springfield','Bartholomew JoJo \\\"Bart\\\" Simpson (23 de febrero de 1979) es el hijo mayor travieso, rebelde, incomprendido, disruptivo y \\\"potencialmente peligroso\\\" de la familia Simpson en Los Simpson. Es el único hijo de Homero y Marge Simpson, y el hermano mayor de Lisa y Maggie. También ha sido apodado \\\"Cosmo\\\", después de descubrir un cometa en \\\"El cometa de Bart\"\\.'),(4,'Lisa ','Simpson','Estudiante en la escuela primaria de Springfield, Monitor de pasillo, Anteriormente: Niñera','Lisa Marie Simpson (nacida el 9 de mayo) es una carismática niña de 8 años que supera el nivel de rendimiento estándar de los niños de su edad. No para sorpresa de todos, ella también es el centro moral de su familia. En su educación, Lisa carece de la participación de los padres de Homero y Marge, lo que la lleva a pasatiempos como tocar el saxofón y la guitarra, montar y cuidar caballos, e interés en estudios avanzados. En la escuela, la popularidad de Lisa se ve afectada por aquellos que la ven como una superdotada geek, lo que la deja con solo unos pocos amigos. Lisa Simpson es una niña inteligente, ingeniosa e independiente que se enfoca en sus metas y se esfuerza por alcanzar su potencial, y a los 8 años ya es miembro de MENSA con un coeficiente intelectual de 159'),(5,'Charles Montgomery','Burns','Propietario de la planta de energía nuclear de Springfield','Es el propietario y operador de la planta de energía nuclear de Springfield');
/*!40000 ALTER TABLE `personajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes_aparecen_capitulos`
--

DROP TABLE IF EXISTS `personajes_aparecen_capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes_aparecen_capitulos` (
  `personajes_idpersonajes` int NOT NULL,
  `capitulos_idcapitulos` int NOT NULL,
  PRIMARY KEY (`personajes_idpersonajes`,`capitulos_idcapitulos`),
  KEY `fk_personajes_has_capitulos_capitulos1_idx` (`capitulos_idcapitulos`),
  KEY `fk_personajes_has_capitulos_personajes1_idx` (`personajes_idpersonajes`),
  CONSTRAINT `fk_personajes_has_capitulos_capitulos1` FOREIGN KEY (`capitulos_idcapitulos`) REFERENCES `capitulos` (`idcapitulos`),
  CONSTRAINT `fk_personajes_has_capitulos_personajes1` FOREIGN KEY (`personajes_idpersonajes`) REFERENCES `personajes` (`idpersonajes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes_aparecen_capitulos`
--

LOCK TABLES `personajes_aparecen_capitulos` WRITE;
/*!40000 ALTER TABLE `personajes_aparecen_capitulos` DISABLE KEYS */;
INSERT INTO `personajes_aparecen_capitulos` VALUES (3,1),(2,2),(2,3);
/*!40000 ALTER TABLE `personajes_aparecen_capitulos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01 14:51:24
