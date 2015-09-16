-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: otb
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add directions mode',8,'add_directionsmode'),(23,'Can change directions mode',8,'change_directionsmode'),(24,'Can delete directions mode',8,'delete_directionsmode'),(25,'Can add Tour',9,'add_tour'),(26,'Can change Tour',9,'change_tour'),(27,'Can delete Tour',9,'delete_tour'),(28,'Can add Tour Info',10,'add_tourinfo'),(29,'Can change Tour Info',10,'change_tourinfo'),(30,'Can delete Tour Info',10,'delete_tourinfo'),(31,'Can add Tour Stop',11,'add_tourstop'),(32,'Can change Tour Stop',11,'change_tourstop'),(33,'Can delete Tour Stop',11,'delete_tourstop'),(34,'Can add Tour Stop Media',12,'add_tourstopmedia'),(35,'Can change Tour Stop Media',12,'change_tourstopmedia'),(36,'Can delete Tour Stop Media',12,'delete_tourstopmedia'),(37,'Can add api access',13,'add_apiaccess'),(38,'Can change api access',13,'change_apiaccess'),(39,'Can delete api access',13,'delete_apiaccess'),(40,'Can add api key',14,'add_apikey'),(41,'Can change api key',14,'change_apikey'),(42,'Can delete api key',14,'delete_apikey'),(43,'Can add cors model',15,'add_corsmodel'),(44,'Can change cors model',15,'change_corsmodel'),(45,'Can delete cors model',15,'delete_corsmodel'),(46,'Can add size',16,'add_size'),(47,'Can change size',16,'change_size'),(48,'Can delete size',16,'delete_size'),(49,'Can add filter',17,'add_filter'),(50,'Can change filter',17,'change_filter'),(51,'Can delete filter',17,'delete_filter'),(52,'Can add image',18,'add_image'),(53,'Can change image',18,'change_image'),(54,'Can delete image',18,'delete_image'),(55,'Can add kv store',19,'add_kvstore'),(56,'Can change kv store',19,'change_kvstore'),(57,'Can delete kv store',19,'delete_kvstore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$yCLqpthbNZXN$Lo76vnGRcP8pps+NLAVgJ4jnb4fesMSZAP4Bn1OYF6E=','2015-06-16 17:33:48',1,'root','','','',1,1,'2015-03-23 16:24:44');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_permissi_user_id_7f0938558328534a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corsheaders_corsmodel`
--

DROP TABLE IF EXISTS `corsheaders_corsmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corsheaders_corsmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cors` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsheaders_corsmodel`
--

LOCK TABLES `corsheaders_corsmodel` WRITE;
/*!40000 ALTER TABLE `corsheaders_corsmodel` DISABLE KEYS */;
/*!40000 ALTER TABLE `corsheaders_corsmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-03-23 18:02:30','1','WALKING',1,'',8,1),(2,'2015-03-23 18:04:55','1','Jay\'s Awesome Burrito Tour',1,'',9,1),(3,'2015-03-23 18:05:02','1','Jay\'s Awesome Burrito Tour',2,'No fields changed.',9,1),(4,'2015-03-23 18:09:35','1','Jay\'s Awesome Burrito Tour',2,'Added Tour Stop \"Elmyr - Jay\'s Awesome Burrito Tour\".',9,1),(5,'2015-03-24 13:27:39','2','Some Other Tour',1,'',9,1),(6,'2015-03-24 15:52:12','2','Bell Street - Jay\'s Awesome Burrito Tour',1,'',11,1),(7,'2015-03-24 15:52:56','3','Where Ever - Some Other Tour',1,'',11,1),(8,'2015-03-24 16:15:27','1','Burrito',1,'',12,1),(9,'2015-04-02 19:13:30','1','Jay\'s Awesome Burrito Tour',2,'Added Tour Stop \"Raging Burrito - Jay\'s Awesome Burrito Tour\". Changed description for Tour Stop \"Elmyr - Jay\'s Awesome Burrito Tour\".',9,1),(10,'2015-04-03 14:59:31','2','Some Other Tour',2,'Changed geospatial.',9,1),(11,'2015-04-03 16:55:08','1','About - Jay\'s Awesome Burrito Tour',1,'',10,1),(12,'2015-04-08 15:53:48','2','BICYCLING',1,'',8,1),(13,'2015-04-08 15:53:56','3','TRANSIT',1,'',8,1),(14,'2015-04-08 15:54:00','1','Jay\'s Awesome Burrito Tour',2,'Changed modes. Changed position for Tour Info \"About - Jay\'s Awesome Burrito Tour\". Changed description for Tour Stop \"Raging Burrito - Jay\'s Awesome Burrito Tour\".',9,1),(15,'2015-04-08 15:54:10','1','Jay\'s Awesome Burrito Tour',2,'No fields changed.',9,1),(16,'2015-04-08 15:54:33','1','Jay\'s Awesome Burrito Tour',2,'Changed modes.',9,1),(17,'2015-04-08 16:50:27','1','Jay\'s Awesome Burrito Tour',2,'Changed modes.',9,1),(18,'2015-04-14 17:20:12','5','Elmyriachi - Jay\'s Awesome Burrito Tour',1,'',11,1),(19,'2015-04-14 20:39:42','3','Introduction - Some Other Tour',2,'Changed name, description, lat and lng.',11,1),(20,'2015-04-14 20:40:50','6','Introduction - Jay\'s Awesome Burrito Tour',1,'',11,1),(21,'2015-04-14 20:41:19','1','Jay\'s Awesome Burrito Tour',2,'Changed position for Tour Stop \"Elmyr - Jay\'s Awesome Burrito Tour\". Changed position for Tour Stop \"Bell Street - Jay\'s Awesome Burrito Tour\". Changed position for Tour Stop \"Raging Burrito - Jay\'s Awesome Burrito Tour\". Changed position for Tour Stop \"Elmyriachi - Jay\'s Awesome Burrito Tour\". Changed position for Tour Stop \"Introduction - Jay\'s Awesome Burrito Tour\".',9,1),(22,'2015-04-14 20:44:27','2','Wild Heaven Beers',2,'Changed name and description. Added Tour Stop \"Invocation - Wild Heaven Beers\". Added Tour Stop \"Ode To Mercy - Wild Heaven Beers\". Added Tour Stop \"Eschaton - Wild Heaven Beers\". Added Tour Stop \"Let There Be Light - Wild Heaven Beers\".',9,1),(23,'2015-04-14 20:45:13','2','Wild Heaven Beers',2,'Added Tour Stop \"White Blackbird - Wild Heaven Beers\". Added Tour Stop \"Civilization - Wild Heaven Beers\". Changed description for Tour Stop \"Invocation - Wild Heaven Beers\". Changed description for Tour Stop \"Ode To Mercy - Wild Heaven Beers\". Changed description for Tour Stop \"Eschaton - Wild Heaven Beers\". Changed description for Tour Stop \"Let There Be Light - Wild Heaven Beers\".',9,1),(24,'2015-04-14 20:52:13','2','Wild Heaven Beers',2,'Changed description for Tour Stop \"Invocation - Wild Heaven Beers\". Changed description for Tour Stop \"White Blackbird - Wild Heaven Beers\". Changed description for Tour Stop \"Civilization - Wild Heaven Beers\".',9,1),(25,'2015-04-15 17:50:27','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Added Tour Stop Media \"Party\".',11,1),(26,'2015-04-15 17:55:53','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Deleted Tour Stop Media \"Burrito\". Deleted Tour Stop Media \"Party\".',11,1),(27,'2015-04-15 17:56:17','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Added Tour Stop Media \"Party\".',11,1),(28,'2015-04-15 19:02:46','1','Phone - (300, 300)',1,'',16,1),(29,'2015-04-15 19:03:14','2','Tablet - (600, 600)',1,'',16,1),(30,'2015-04-15 19:03:18','2','Tablet - (600, 600)',2,'No fields changed.',16,1),(31,'2015-04-15 19:03:37','3','Desktop - (1200, 1200)',1,'',16,1),(32,'2015-04-15 19:05:00','1','Party',1,'',18,1),(33,'2015-04-15 19:05:32','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed images.',11,1),(34,'2015-04-16 15:20:46','5','Party',1,'',12,1),(35,'2015-04-16 15:26:16','5','Party',3,'',12,1),(36,'2015-04-16 15:27:15','6','Party',1,'',12,1),(37,'2015-04-16 17:34:49','1','http://172.16.83.129:8000/',2,'Changed domain and name.',6,1),(38,'2015-04-16 17:35:09','1','http://172.16.83.129:8000',2,'Changed domain.',6,1),(39,'2015-04-16 18:33:13','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Added Tour Stop Media \"Logo\".',11,1),(40,'2015-04-16 19:09:24','2','Wild Heaven Beers',2,'Changed geospatial.',9,1),(41,'2015-04-16 19:10:28','2','Wild Heaven Beers',2,'Changed position for Tour Stop \"Eschaton - Wild Heaven Beers\". Changed position for Tour Stop \"Let There Be Light - Wild Heaven Beers\". Changed position for Tour Stop \"White Blackbird - Wild Heaven Beers\". Changed position for Tour Stop \"Civilization - Wild Heaven Beers\".',9,1),(42,'2015-04-16 19:14:53','8','Invocation',1,'',12,1),(43,'2015-04-16 19:15:22','9','Ode to Mercy',1,'',12,1),(44,'2015-04-16 19:15:40','10','Civilization',1,'',12,1),(45,'2015-04-16 19:15:43','10','Civilization',2,'No fields changed.',12,1),(46,'2015-04-16 19:15:59','11','Eschaton',1,'',12,1),(47,'2015-04-16 19:16:17','12','White Blackbird',1,'',12,1),(48,'2015-04-16 19:20:33','13','Let There Be Light',1,'',12,1),(49,'2015-04-16 19:21:00','14','',1,'',12,1),(50,'2015-04-17 02:19:57','6','Introduction - Jay\'s Awesome Burrito Tour',2,'No fields changed.',11,1),(51,'2015-04-17 02:20:01','3','Introduction - Wild Heaven Beers',2,'No fields changed.',11,1),(52,'2015-04-17 02:20:06','7','Invocation - Wild Heaven Beers',2,'No fields changed.',11,1),(53,'2015-04-17 02:20:13','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'No fields changed.',11,1),(54,'2015-04-17 02:20:16','8','Ode To Mercy - Wild Heaven Beers',2,'No fields changed.',11,1),(55,'2015-04-17 02:20:20','2','Bell Street - Jay\'s Awesome Burrito Tour',2,'No fields changed.',11,1),(56,'2015-04-17 02:20:24','12','Civilization - Wild Heaven Beers',2,'No fields changed.',11,1),(57,'2015-04-17 02:20:28','4','Raging Burrito - Jay\'s Awesome Burrito Tour',2,'No fields changed.',11,1),(58,'2015-04-17 02:20:32','9','Eschaton - Wild Heaven Beers',2,'No fields changed.',11,1),(59,'2015-04-17 02:20:37','5','Elmyriachi - Jay\'s Awesome Burrito Tour',2,'No fields changed.',11,1),(60,'2015-04-17 02:20:40','10','Let There Be Light - Wild Heaven Beers',2,'No fields changed.',11,1),(61,'2015-04-17 02:20:44','11','White Blackbird - Wild Heaven Beers',2,'No fields changed.',11,1),(62,'2015-04-24 18:17:10','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed metadescription.',11,1),(63,'2015-04-24 18:17:23','5','Elmyriachi - Jay\'s Awesome Burrito Tour',2,'Changed metadescription.',11,1),(64,'2015-04-24 18:17:40','2','Bell Street - Jay\'s Awesome Burrito Tour',2,'Changed metadescription.',11,1),(65,'2015-04-24 18:18:03','4','Raging Burrito - Jay\'s Awesome Burrito Tour',2,'Changed metadescription.',11,1),(66,'2015-04-27 15:01:36','1','Jay\'s Awesome Burrito Tour',2,'Changed splashimage.',9,1),(67,'2015-04-27 15:08:00','2','Wild Heaven Beers',2,'Changed splashimage.',9,1),(68,'2015-04-28 02:22:32','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed description.',11,1),(69,'2015-04-28 02:23:05','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed description.',11,1),(70,'2015-04-30 17:40:41','1','http://otb-api.ecdsweb.org:8000',2,'Changed domain and name.',6,1),(71,'2015-04-30 17:43:29','1','http://otb-api.dev.ecdsweb.org:8000',2,'Changed domain and name.',6,1),(72,'2015-06-16 17:35:59','1','Jay\'s Awesome Burrito Tour',2,'Changed splashimage.',9,1),(73,'2015-06-16 21:51:17','1','http://172.16.83.143:8000',2,'Changed domain and name.',6,1),(74,'2015-06-17 20:09:48','14','',3,'',12,1),(75,'2015-06-17 20:09:48','13','Let There Be Light',3,'',12,1),(76,'2015-06-17 20:09:48','12','White Blackbird',3,'',12,1),(77,'2015-06-17 20:09:48','11','Eschaton',3,'',12,1),(78,'2015-06-17 20:09:48','10','Civilization',3,'',12,1),(79,'2015-06-17 20:09:48','9','Ode to Mercy',3,'',12,1),(80,'2015-06-17 20:09:48','8','Invocation',3,'',12,1),(81,'2015-06-17 20:09:48','6','Party',3,'',12,1),(82,'2015-06-17 20:09:48','7','Logo',3,'',12,1),(83,'2015-06-17 20:10:27','15','Party',1,'',12,1),(84,'2015-06-17 20:11:08','16','The Building',1,'',12,1),(85,'2015-06-17 20:11:42','17','Elmyr de Hory',1,'',12,1),(86,'2015-06-17 20:12:00','18','YUM!',1,'',12,1),(87,'2015-06-17 23:01:24','19','Sweet Auburn Curb Market',1,'',12,1),(88,'2015-06-17 23:02:46','20','Burrito',1,'',12,1),(89,'2015-06-17 23:03:48','2','Bell Street - Jay\'s Awesome Burrito Tour',2,'Changed description.',11,1),(90,'2015-06-22 15:20:04','1','Jay\'s Awesome Burrito Tour',2,'Changed position for Tour Stop \"Bell Street - Jay\'s Awesome Burrito Tour\". Changed position for Tour Stop \"Raging Burrito - Jay\'s Awesome Burrito Tour\".',9,1),(91,'2015-06-22 19:27:14','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed video_embed.',11,1),(92,'2015-06-23 00:46:31','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed position for Tour Stop Media \"Elmyr de Hory\". Changed position for Tour Stop Media \"YUM!\".',11,1),(93,'2015-06-23 14:15:18','1','Elmyr - Jay\'s Awesome Burrito Tour',2,'Changed directions_intro and direction_notes.',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'directions mode','tour','directionsmode'),(9,'Tour','tour','tour'),(10,'Tour Info','tour','tourinfo'),(11,'Tour Stop','tour','tourstop'),(12,'Tour Stop Media','tour','tourstopmedia'),(13,'api access','tastypie','apiaccess'),(14,'api key','tastypie','apikey'),(15,'cors model','corsheaders','corsmodel'),(16,'size','django_image_tools','size'),(17,'filter','django_image_tools','filter'),(18,'image','django_image_tools','image'),(19,'kv store','thumbnail','kvstore');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_image_tools_filter`
--

DROP TABLE IF EXISTS `django_image_tools_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_image_tools_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `filter_type` smallint(5) unsigned NOT NULL,
  `numeric_parameter` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_image_tools_filter`
--

LOCK TABLES `django_image_tools_filter` WRITE;
/*!40000 ALTER TABLE `django_image_tools_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_image_tools_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_image_tools_image`
--

DROP TABLE IF EXISTS `django_image_tools_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_image_tools_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `checksum` varchar(32) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `subject_position_horizontal` smallint(5) unsigned NOT NULL,
  `subject_position_vertical` smallint(5) unsigned NOT NULL,
  `was_upscaled` tinyint(1) NOT NULL,
  `title` varchar(120) NOT NULL,
  `caption` longtext NOT NULL,
  `alt_text` varchar(120) NOT NULL,
  `credit` longtext,
  PRIMARY KEY (`id`),
  KEY `django_image_tools_image_606e157c` (`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_image_tools_image`
--

LOCK TABLES `django_image_tools_image` WRITE;
/*!40000 ALTER TABLE `django_image_tools_image` DISABLE KEYS */;
INSERT INTO `django_image_tools_image` VALUES (1,'/mnt/hgfs/data/django/OpenTourBuilder/tours/media/Party.jpg','c8f7f3375723b77e9d81f18ae0211324','Party',2,2,0,'Party','No one parties like Elmyr','party!','CL');
/*!40000 ALTER TABLE `django_image_tools_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_image_tools_size`
--

DROP TABLE IF EXISTS `django_image_tools_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_image_tools_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `width` smallint(5) unsigned DEFAULT NULL,
  `height` smallint(5) unsigned DEFAULT NULL,
  `auto` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_image_tools_size`
--

LOCK TABLES `django_image_tools_size` WRITE;
/*!40000 ALTER TABLE `django_image_tools_size` DISABLE KEYS */;
INSERT INTO `django_image_tools_size` VALUES (1,'Phone',300,300,0),(2,'Tablet',600,600,0),(3,'Desktop',1200,1200,0);
/*!40000 ALTER TABLE `django_image_tools_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (4,'sessions','0001_initial','2015-03-23 16:24:25');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3lo1hf017g5witc3sdfsxer42aaqoooz','N2I2ODczZDdjZWUxODY5ZTkyMjRlODc1OTY0M2YwNDU4ZmFhZjg5NDp7Il9hdXRoX3VzZXJfaGFzaCI6IjNjNmM2MDAyZTAxMWNhYjViN2NkZGIxMzg4ZGFlODkyNzA3NTVjYzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-04-28 17:18:15'),('466i3r7tal8vo8va92rbsi08grfikoki','N2I2ODczZDdjZWUxODY5ZTkyMjRlODc1OTY0M2YwNDU4ZmFhZjg5NDp7Il9hdXRoX3VzZXJfaGFzaCI6IjNjNmM2MDAyZTAxMWNhYjViN2NkZGIxMzg4ZGFlODkyNzA3NTVjYzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-05-11 14:58:39'),('4ldzw1a7hwjzz7ypiwi1kthtj4he22li','MmNjYTliZmFmNzY2MjY3YTA4ZmZmOTViMjkyMDE2NzU0ZTRlOTkxYjp7fQ==','2015-05-14 14:49:12'),('8ewev2pn6h3gm7mqf9w0fmleywu3cflw','N2I2ODczZDdjZWUxODY5ZTkyMjRlODc1OTY0M2YwNDU4ZmFhZjg5NDp7Il9hdXRoX3VzZXJfaGFzaCI6IjNjNmM2MDAyZTAxMWNhYjViN2NkZGIxMzg4ZGFlODkyNzA3NTVjYzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-04-22 15:53:32'),('pttwnx4em920wvp8l13lky7ttnk0ce63','NDY4YzBhMTQ4MDU2NjJmMDBlNmUxNmMxNzBjOGUyNDkyMDgzMjUyYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0N2I4Njk5MTU2YTFmNmY5MzhkNjY2YjNhYzk5M2Y0MGU3ZTc5ZDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-05-14 17:39:22'),('wr16zkxonvlekark9w140ps1yr4v4okl','N2I2ODczZDdjZWUxODY5ZTkyMjRlODc1OTY0M2YwNDU4ZmFhZjg5NDp7Il9hdXRoX3VzZXJfaGFzaCI6IjNjNmM2MDAyZTAxMWNhYjViN2NkZGIxMzg4ZGFlODkyNzA3NTVjYzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2015-04-06 18:02:03'),('ydp83j86g4v83ezjgvymbv2fzjqi6xi5','NDY4YzBhMTQ4MDU2NjJmMDBlNmUxNmMxNzBjOGUyNDkyMDgzMjUyYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0N2I4Njk5MTU2YTFmNmY5MzhkNjY2YjNhYzk5M2Y0MGU3ZTc5ZDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-06-30 17:33:48');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'http://172.16.83.143:8000','172.16.83.143:8000');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apiaccess`
--

DROP TABLE IF EXISTS `tastypie_apiaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apiaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `request_method` varchar(10) NOT NULL,
  `accessed` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apiaccess`
--

LOCK TABLES `tastypie_apiaccess` WRITE;
/*!40000 ALTER TABLE `tastypie_apiaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apiaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apikey`
--

DROP TABLE IF EXISTS `tastypie_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apikey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `tastypie_apikey_3c6e0b8a` (`key`),
  CONSTRAINT `tastypie_apikey_user_id_ffeb4840e0b406b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apikey`
--

LOCK TABLES `tastypie_apikey` WRITE;
/*!40000 ALTER TABLE `tastypie_apikey` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apikey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
INSERT INTO `thumbnail_kvstore` VALUES ('sorl-thumbnail||image||01b7b9c480bd16989a622b7ed795738f','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/invocation.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||05a385bbec848eef53682ab94c6e5db9','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/4f/72/4f72bd2b748029741a567fcde8b07fd7.jpg\", \"size\": [300, 300]}'),('sorl-thumbnail||image||05a930030f8cab2a5ab9b48f0a9a94c0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/b3/13/b313ab6b93231f30ddc91bbb6f066d81.jpg\", \"size\": [629, 600]}'),('sorl-thumbnail||image||0634f436af4567fb4068043552f3cd05','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/40/e7/40e749824e17e2e528b5739a1df83e54.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||09b583ac2bc72915906bb6a3a1c105b6','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/5d/8a/5d8a3a8c910192bed1fea3eab6518cb9.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||0ade8e1ed07be45951895c5b6db46ed0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/5b/c4/5bc4c1d8fdffe72e37857ad54adde543.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||0d654b8fd954ca93a9582d524bc4383e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/7b/9c/7b9c492aab47c539cf40819c2745dfbe.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||image||0dad872f4e801bb38de0d4f7dd0a0737','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/fb/08/fb086abba4f37b9e54054652aa138eee.jpg\", \"size\": [100, 100]}'),('sorl-thumbnail||image||149fef389dd885c77abbac852c186082','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/civilization.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||1d2ce7b84af8074279c30960cbc3a2ba','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e8/10/e81021c38a96aa1a79dc4e0bb51a299f.jpg\", \"size\": [685, 300]}'),('sorl-thumbnail||image||268eb197c2714f4e394be08fd3af1f02','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/59/63/5963fe71d06ed6b84dd9a2adfa3f80c1.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||277b45060643d9c70e6ba883fbd67410','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/69/22/6922ef3a1158c54cf2efcb7aa007b0bc.jpg\", \"size\": [2491, 1400]}'),('sorl-thumbnail||image||2ebecb65d25d2d449934f43b4ac742c4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/dd/6b/dd6b9c5c950d04bc40a466c453951d5d.jpg\", \"size\": [314, 300]}'),('sorl-thumbnail||image||2fa9e84e7200e99708175ef81050cdf0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/92/08/92085e62fcc695f8e60ace352e635631.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||31c151a93275ec1fe4d57909433e252f','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/4f/c5/4fc58ae50b849497b3ad92bbadfe625e.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||32f2a6cf652db46ab6f4db34af596a59','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/68/ca/68caf0e6c713b7bb6b8ff740fdee2c2d.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||3332d9285c63077b69d123bbf1ffb4aa','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/91/6c/916c7ddb77c9869067031af7caa1775a.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||341400bb74cdb57423954f8f18792fae','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/60/30/6030e0b0bfc7c662fb8a48a22442e78a.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||image||381a2b17cd55d8a4783b25671dcc4f76','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/69/86/69865fb6e978048db3097315cccbf291.jpg\", \"size\": [1365, 767]}'),('sorl-thumbnail||image||3eeecd632ab261a69bfc81bab9a3146b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e7/cb/e7cb8ed44a872c5ba09af5308c0ce8a1.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||image||40b2961f28b72e78ce8410d5d16b6b03','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/7f/c0/7fc019218578610c4b65f04fc81511be.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||411f8c13fd5b7eb08dd8bd04e3f9ce08','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ec/f9/ecf90faaaca6ff68ea6add8502198a19.jpg\", \"size\": [228, 100]}'),('sorl-thumbnail||image||45fbd83fd91abd746481bb5174cbf4dd','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e4/29/e4290bef37d5bea2bf5d6e163076d0ee.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||46eb9014f79484c21f637bf3a29dd740','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/3e/d9/3ed9865e13f47efccbc283ea5c6ae981.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||4fb937f2b09682805d1f39acbc2199b0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"tours/DSC01046-2.jpg\", \"size\": [2000, 1124]}'),('sorl-thumbnail||image||60763e310796d278903f49284c727bca','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/Wild-Heaven-Craft-Beers1.jpg\", \"size\": [874, 834]}'),('sorl-thumbnail||image||6159025657f217bd95407195b7348996','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/4d/17/4d173a4142d39fb968e79fef5ed4accf.jpg\", \"size\": [600, 600]}'),('sorl-thumbnail||image||629912c47358f1abba3b83f85fa7e6ad','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"tours/3349577877_3899f8abbf.jpg\", \"size\": [500, 375]}'),('sorl-thumbnail||image||65b191bf627c8f7aa3878b182e0a6e03','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ce/5c/ce5c6ec3627fc6836c8fb3d60f8205e9.jpg\", \"size\": [1767, 993]}'),('sorl-thumbnail||image||6a3def5648e91797cc23ae4ad77b4586','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e5/35/e535fbd66db7bb2b8884236d24891f90.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||6b8731f45e73d542fe417215c6caf968','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/let-there-be-light.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||6f4a9272842921ed77f99d45b7964b5e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/3e/0c/3e0c3edd168ae580e8c9b4eef045bb6c.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||725ef751bcefe23f63f5e20b91b678df','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/ode-to-mercy.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||7e6a18759e07c84c0d2e8af3296df49c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/0a/5a/0a5a8381d4820e87c6247f8a83937399.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||857e3b222f10362cc454f13feda85557','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/b1/1a/b11a7c40546519fcd573da037495c284.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||950b85038641fdc1eaa2c21074f575be','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/7f/ed/7fed4ca5861b031a587b27a15f160094.jpg\", \"size\": [105, 100]}'),('sorl-thumbnail||image||990a30112f27be0424266352d05fbbb6','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/3d/7a/3d7af2e25779268829e28cff0bfc7740.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||99171e1dd943088d75e883677b3a69cf','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ef/90/ef906717f6a74cd2e1344d53593f36d1.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||image||9a14c8cfe12f2686028db577b85018a1','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e7/e0/e7e058ff64cd682ce006f8f9a106067e.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||ab7919cf79fadf3df6aac1d9be936eb4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/white-blackbird.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||ae5e33c0bc4e8eaad020cc67389c555a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/eschaton.jpg\", \"size\": [258, 336]}'),('sorl-thumbnail||image||b0ed3aab3aaa8bdd1c391a81af73f8c5','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/0d/a2/0da2e8b0dfdd3c6a3cc4c78e833c773f.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||image||b0f7e85c3c7913445723735436484f8e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/26/6a/266a56e6636de843e6fa2089ac454e5f.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||b43cea8847cc1ee416fbd4e06a68f0fc','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/8f/9a/8f9a54a8a5d6e46a4e6f9e86136b668a.jpg\", \"size\": [419, 400]}'),('sorl-thumbnail||image||b4a7150418f418bbf603343d7a7088b1','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/19/98/1998b30a50705939a56a18cd3333d47c.jpg\", \"size\": [1370, 600]}'),('sorl-thumbnail||image||b4e1361c5edc57cc28327979e723a839','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/1311422543-photo_module-17.jpg\", \"size\": [500, 219]}'),('sorl-thumbnail||image||b83031073ef4d3c1e7e731d41e6ac3b4','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/72/83/728384ba57e8b74876994106406a1ae8.jpg\", \"size\": [1867, 1400]}'),('sorl-thumbnail||image||baa1b4dd72507b77eb826f5d86fe63d2','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/de/a5/dea57aef307f9df442fa757791e4c2ab.jpg\", \"size\": [1324, 993]}'),('sorl-thumbnail||image||c83cd9a5022d9f2b24c1ab523da2e6e0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/26/b3/26b32156ddbd3d678dec03f7d4e0b494.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||c9d1d8cee271a8cb5f976ed06350b7e7','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/93/4a/934aa6f814d361af81765a10895d5338.jpg\", \"size\": [1023, 767]}'),('sorl-thumbnail||image||c9fd0b63e39a380ecf760373a48bd0cb','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/d0/4d/d04d089a3ee81bc5fabd6ed362d2dfd0.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||d0d935ae3c2749d6933375a00a462bd0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/54/7c/547c0c82fc899018a76850ef82931a49.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||dbc1846000a2be076dae30adb9d9b24e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/a0/63/a0631af609980a1bcee106092182cd96.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||dc81109b439cc0d9e153d56992e476f0','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/f7/fd/f7fdf4d83c4e4c16d9abd0460c600f2c.jpg\", \"size\": [461, 600]}'),('sorl-thumbnail||image||e02319b35dfd0aee49b9c0e95a4a5c8e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/2f/4d/2f4da41013610ddacc64dbea389a0ab5.jpg\", \"size\": [307, 400]}'),('sorl-thumbnail||image||e091ddcf53bb9319105eaf2fbd5b4af8','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/0d/65/0d65de54caa5318de5e76e96c44b1efb.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||e128f8d43e1445118963dd2c41891edb','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/78/9c/789c507c32e266e6afde9f9b6d63c58c.jpg\", \"size\": [400, 400]}'),('sorl-thumbnail||image||ea2124882f569e27f51c2cc418b13aa9','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/6e/6f/6e6ff81c987779b4acb30acb0c077a1f.jpg\", \"size\": [80, 80]}'),('sorl-thumbnail||image||f28bc034a5152b793dab23a8d8b37a97','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ca/88/ca8848d458bbff673ac4538b596bb2e1.jpg\", \"size\": [913, 400]}'),('sorl-thumbnail||image||fa7f8f9e2028ba6b0879b2c45010fb0b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"stops/MOD5-TShirt-02_400x400.png\", \"size\": [400, 400]}'),('sorl-thumbnail||image||fb0004920df485f217d45eae66303474','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/70/f3/70f3de9a5ab15a511a458e7cedd23450.jpg\", \"size\": [77, 100]}'),('sorl-thumbnail||image||fcb95beab8a6874f913f11500cd0c93e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/35/2f/352f6c260525cd0f0e1c1e5330a85aa7.jpg\", \"size\": [230, 300]}'),('sorl-thumbnail||thumbnails||01b7b9c480bd16989a622b7ed795738f','[\"ea2124882f569e27f51c2cc418b13aa9\"]'),('sorl-thumbnail||thumbnails||149fef389dd885c77abbac852c186082','[\"e091ddcf53bb9319105eaf2fbd5b4af8\"]'),('sorl-thumbnail||thumbnails||4fb937f2b09682805d1f39acbc2199b0','[\"381a2b17cd55d8a4783b25671dcc4f76\"]'),('sorl-thumbnail||thumbnails||60763e310796d278903f49284c727bca','[\"857e3b222f10362cc454f13feda85557\"]'),('sorl-thumbnail||thumbnails||629912c47358f1abba3b83f85fa7e6ad','[\"c9d1d8cee271a8cb5f976ed06350b7e7\"]'),('sorl-thumbnail||thumbnails||6b8731f45e73d542fe417215c6caf968','[\"0634f436af4567fb4068043552f3cd05\"]'),('sorl-thumbnail||thumbnails||725ef751bcefe23f63f5e20b91b678df','[\"d0d935ae3c2749d6933375a00a462bd0\"]'),('sorl-thumbnail||thumbnails||ab7919cf79fadf3df6aac1d9be936eb4','[\"990a30112f27be0424266352d05fbbb6\"]'),('sorl-thumbnail||thumbnails||ae5e33c0bc4e8eaad020cc67389c555a','[\"09b583ac2bc72915906bb6a3a1c105b6\"]'),('sorl-thumbnail||thumbnails||b4e1361c5edc57cc28327979e723a839','[\"c9fd0b63e39a380ecf760373a48bd0cb\"]'),('sorl-thumbnail||thumbnails||fa7f8f9e2028ba6b0879b2c45010fb0b','[\"9a14c8cfe12f2686028db577b85018a1\"]');
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_directionsmode`
--

DROP TABLE IF EXISTS `tour_directionsmode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_directionsmode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mode` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_directionsmode`
--

LOCK TABLES `tour_directionsmode` WRITE;
/*!40000 ALTER TABLE `tour_directionsmode` DISABLE KEYS */;
INSERT INTO `tour_directionsmode` VALUES (1,'WALKING'),(2,'BICYCLING'),(3,'TRANSIT');
/*!40000 ALTER TABLE `tour_directionsmode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tour`
--

DROP TABLE IF EXISTS `tour_tour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_tour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `description` longtext NOT NULL,
  `metadescription` longtext NOT NULL,
  `slug` varchar(50) NOT NULL,
  `default_mode` varchar(50) NOT NULL,
  `fb_app_id` varchar(50) NOT NULL,
  `fb_page_id` varchar(50) NOT NULL,
  `twitter_acct` varchar(50) NOT NULL,
  `google_analytics` longtext NOT NULL,
  `splashimage` varchar(100) NOT NULL,
  `geospatial` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tour`
--

LOCK TABLES `tour_tour` WRITE;
/*!40000 ALTER TABLE `tour_tour` DISABLE KEYS */;
INSERT INTO `tour_tour` VALUES (1,'Jay\'s Awesome Burrito Tour',0,'<p>Jay really likes burritos. Here are his favaorite places in Atlanta.</p>','','jays-awesome-burrito-tour','','','','','','tours/3349577877_3899f8abbf_z.jpg',1),(2,'Wild Heaven Beers',0,'<p>They make yummy ones.</p>','','wild-heaven-beers','','','','','','',0);
/*!40000 ALTER TABLE `tour_tour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tour_modes`
--

DROP TABLE IF EXISTS `tour_tour_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_tour_modes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tour_id` int(11) NOT NULL,
  `directionsmode_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tour_id` (`tour_id`,`directionsmode_id`),
  KEY `tour_tour_modes_1ffb913d` (`tour_id`),
  KEY `tour_tour_modes_405a1c12` (`directionsmode_id`),
  CONSTRAINT `tour_tour_modes_tour_id_17caee5b06f6520d_fk_tour_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour_tour` (`id`),
  CONSTRAINT `tou_directionsmode_id_400e094cbfb09c76_fk_tour_directionsmode_id` FOREIGN KEY (`directionsmode_id`) REFERENCES `tour_directionsmode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tour_modes`
--

LOCK TABLES `tour_tour_modes` WRITE;
/*!40000 ALTER TABLE `tour_tour_modes` DISABLE KEYS */;
INSERT INTO `tour_tour_modes` VALUES (32,1,1),(33,1,2),(34,1,3),(28,2,1);
/*!40000 ALTER TABLE `tour_tour_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tourinfo`
--

DROP TABLE IF EXISTS `tour_tourinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_tourinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `info_slug` varchar(50) NOT NULL,
  `tour_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `info_slug` (`info_slug`),
  KEY `tour_tourinfo_1ffb913d` (`tour_id`),
  CONSTRAINT `tour_tourinfo_tour_id_d9e0dae9d052362_fk_tour_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tourinfo`
--

LOCK TABLES `tour_tourinfo` WRITE;
/*!40000 ALTER TABLE `tour_tourinfo` DISABLE KEYS */;
INSERT INTO `tour_tourinfo` VALUES (1,'About','<p>About my awesome burrito tour.</p>',0,'about',1);
/*!40000 ALTER TABLE `tour_tourinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tourstop`
--

DROP TABLE IF EXISTS `tour_tourstop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_tourstop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `metadescription` longtext NOT NULL,
  `article_link` varchar(525) NOT NULL,
  `video_embed` varchar(50) NOT NULL,
  `video_poster` varchar(100) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `park_lat` double DEFAULT NULL,
  `park_lng` double DEFAULT NULL,
  `directions_intro` longtext NOT NULL,
  `direction_notes` longtext NOT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `tour_id` int(11) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tour_tourstop_1ffb913d` (`tour_id`),
  KEY `tour_tourstop_2dbcba41` (`slug`),
  CONSTRAINT `tour_tourstop_tour_id_3f3235f92d434bae_fk_tour_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tour_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tourstop`
--

LOCK TABLES `tour_tourstop` WRITE;
/*!40000 ALTER TABLE `tour_tourstop` DISABLE KEYS */;
INSERT INTO `tour_tourstop` VALUES (1,'Elmyr','<p>Bean and rice burrito add BBQ tofu.</p>\r\n<p>Deep v scenester quinoa mumblecore gastropub Wes Anderson master cleanse, taxidermy sartorial cold-pressed before they sold out salvia drinking vinegar lo-fi authentic. PBR paleo quinoa, semiotics raw denim bespoke asymmetrical cray cred try-hard beard leggings. Try-hard gluten-free Thundercats banh mi twee slow-carb +1 polaroid mumblecore, normcore skateboard tilde paleo. Flannel quinoa roof party actually bespoke tilde. Squid lumbersexual hashtag semiotics Kickstarter, artisan umami Godard meggings fashion axe irony meditation. Plaid hella cardigan, single-origin coffee pork belly sustainable cold-pressed pickled letterpress pug sartorial Shoreditch Odd Future 90\'s trust fund. Bicycle rights synth fingerstache biodiesel narwhal squid McSweeney\'s, hella sustainable gluten-free PBR sriracha.</p>\r\n<p>Intelligentsia twee keytar farm-to-table kogi. Chia Tumblr four dollar toast, sartorial photo booth iPhone you probably haven\'t heard of them vegan skateboard. Swag Blue Bottle pug, bicycle rights narwhal occupy tote bag. Banksy kale chips migas, narwhal fingerstache four loko lomo cold-pressed semiotics craft beer tousled Echo Park. Hoodie heirloom swag +1 hashtag. Cornhole Tumblr tousled fixie shabby chic, quinoa 8-bit. Gluten-free squid Portland flannel viral drinking vinegar.</p>\r\n<p>Shabby chic quinoa Pinterest flannel pour-over. Before they sold out cardigan Etsy, dreamcatcher mumblecore Odd Future single-origin coffee banh mi cliche cronut twee distillery Banksy post-ironic. Deep v irony Truffaut Shoreditch cornhole, Etsy Kickstarter gastropub occupy asymmetrical selvage gluten-free. Yr mumblecore raw denim crucifix. Schlitz tousled put a bird on it pour-over lo-fi PBR&amp;B sustainable meditation 90\'s banjo, vegan normcore. Cronut freegan ugh, Helvetica typewriter Intelligentsia narwhal iPhone pickled four loko beard Vice before they sold out. Beard meggings occupy Kickstarter gastropub bespoke, paleo retro forage master cleanse.</p>\r\n<p>3 wolf moon cred selfies, locavore Williamsburg beard Austin actually skateboard small batch pour-over keffiyeh. VHS keytar Neutra, bicycle rights Tumblr Thundercats skateboard raw denim. Pitchfork cred quinoa, Truffaut beard craft beer migas chambray Portland chillwave four dollar toast. Flexitarian Bushwick locavore hashtag PBR&amp;B. Tote bag wayfarers bicycle rights, jean shorts selfies Intelligentsia ethical roof party scenester stumptown quinoa XOXO bitters street art. Readymade XOXO Marfa Tumblr literally. Messenger bag plaid dreamcatcher literally 3 wolf moon cray.</p>\r\n<p>Deep v scenester quinoa mumblecore gastropub Wes Anderson master cleanse, taxidermy sartorial cold-pressed before they sold out salvia drinking vinegar lo-fi authentic. PBR paleo quinoa, semiotics raw denim bespoke asymmetrical cray cred try-hard beard leggings. Try-hard gluten-free Thundercats banh mi twee slow-carb +1 polaroid mumblecore, normcore skateboard tilde paleo. Flannel quinoa roof party actually bespoke tilde. Squid lumbersexual hashtag semiotics Kickstarter, artisan umami Godard meggings fashion axe irony meditation. Plaid hella cardigan, single-origin coffee pork belly sustainable cold-pressed pickled letterpress pug sartorial Shoreditch Odd Future 90\'s trust fund. Bicycle rights synth fingerstache biodiesel narwhal squid McSweeney\'s, hella sustainable gluten-free PBR sriracha.</p>\r\n<p>Intelligentsia twee keytar farm-to-table kogi. Chia Tumblr four dollar toast, sartorial photo booth iPhone you probably haven\'t heard of them vegan skateboard. Swag Blue Bottle pug, bicycle rights narwhal occupy tote bag. Banksy kale chips migas, narwhal fingerstache four loko lomo cold-pressed semiotics craft beer tousled Echo Park. Hoodie heirloom swag +1 hashtag. Cornhole Tumblr tousled fixie shabby chic, quinoa 8-bit. Gluten-free squid Portland flannel viral drinking vinegar.</p>\r\n<p>Shabby chic quinoa Pinterest flannel pour-over. Before they sold out cardigan Etsy, dreamcatcher mumblecore Odd Future single-origin coffee banh mi cliche cronut twee distillery Banksy post-ironic. Deep v irony Truffaut Shoreditch cornhole, Etsy Kickstarter gastropub occupy asymmetrical selvage gluten-free. Yr mumblecore raw denim crucifix. Schlitz tousled put a bird on it pour-over lo-fi PBR&amp;B sustainable meditation 90\'s banjo, vegan normcore. Cronut freegan ugh, Helvetica typewriter Intelligentsia narwhal iPhone pickled four loko beard Vice before they sold out. Beard meggings occupy Kickstarter gastropub bespoke, paleo retro forage master cleanse.</p>\r\n<p>3 wolf moon cred selfies, locavore Williamsburg beard Austin actually skateboard small batch pour-over keffiyeh. VHS keytar Neutra, bicycle rights Tumblr Thundercats skateboard raw denim. Pitchfork cred quinoa, Truffaut beard craft beer migas chambray Portland chillwave four dollar toast. Flexitarian Bushwick locavore hashtag PBR&amp;B. Tote bag wayfarers bicycle rights, jean shorts selfies Intelligentsia ethical roof party scenester stumptown quinoa XOXO bitters street art. Readymade XOXO Marfa Tumblr literally. Messenger bag plaid dreamcatcher literally 3 wolf moon cray.</p>','Great place in Little 5 Points.','','6wy_mXuEsP0','',33.763651,-84.351388,NULL,NULL,'Bike rack on the side of the building.','<p>Here are some note?</p>',1,1,'elmyr'),(2,'Bell Street','<p>Green chili burrito with chipolte salsa.</p>','Sweet Auburn Curb Market','','','',33.754098,-84.380158,NULL,NULL,'','',3,1,'bell-street'),(3,'Introduction','<h4>Wild Heaven Craft Beers is a Georgia brewery&nbsp;founded by lifelong Georgians &ndash; Nick Purdy and Eric Johnson.</h4>','','','','',NULL,NULL,NULL,NULL,'','',0,2,'introduction'),(4,'Raging Burrito','<p>pretty good</p>','On the very pleasant Decatur Square','','','',33.774471,-84.295422,NULL,NULL,'','',2,1,'raging-burrito'),(5,'Elmyriachi','<p>By the gensius behind Elmyr, this place has a patio!!!!</p>','In Kirkwood.','','','',33.75247,-84.323818,NULL,NULL,'','',4,1,'elmyriachi'),(6,'Introduction','<p>Jay really really likes burritos</p>','','','','',33.754318,-84.389791,NULL,NULL,'','',0,1,'introduction'),(7,'Invocation','<p>Belgian-style Golden Ale</p>\r\n<p>8.5% ABV | 48 IBU | 8 SRM</p>\r\n<p>We brew our Strong Golden Ale all-grain, giving it a deep and complex taste. Belgian aromatic malts add hints of dried fruit, while generous Noble and West Coast hops deliver an earthy spiciness. It finishes semi-dry with lingering tropical fruits and spicy notes from Belgian yeast. Suggested food pairings: Roasted chicken, grilled pork chops, salmon, Portobello mushrooms, Gouda or Gruyere cheese.</p>','','','','',NULL,NULL,NULL,NULL,'','',1,2,'invocation'),(8,'Ode To Mercy','<p>Imperial Brown Ale 8.2% ABV | 40 IBU | 20 SRM What could possibly be better than the combination of deep roasted malts, coffee, oak, and a smooth, creamy finish? Ode To Mercy overflows with bold flavors woven into a very balanced and approachable beer that finishes with creamy lingering hints of oak, coffee (specially blended by Athens, GA&rsquo;s 1000 Faces), and roasted goodness. Bright citrus hops peek through from time to time, adding additional layers of complexity. Suggested food pairings: Barbecued chicken, Kielbasa, prime rib, cheesecake, English Cheddar Cheese, pate, and Munster cheese.</p>','','','','',NULL,NULL,NULL,NULL,'','',2,2,'ode-to-mercy'),(9,'Eschaton','<p>Belgian-style Quadrupel Ale 10.5% ABV | 20 IBU | 22 SRM How about a big, malty beer that evokes a good red wine and with a drier finish than you&rsquo;d expect at 10.5% ABV? Eschaton is a one-of-a-kind oaked all-malt Quadrupel (or &ldquo;Belgian Strong Dark&rdquo; if you prefer) that abounds with dark fruit and pit fruit flavors as well as earthy spiciness. Vanilla oak and warm viniferous notes assert themselves as the beer warms to reveal additional layers of delicious complexity. Suggested food pairings: Lamb, rabbit, duck, Stilton cheese, Belgian chocolate, tart fruit desserts.</p>','','','','',NULL,NULL,NULL,NULL,'','',4,2,'eschaton'),(10,'Let There Be Light','<p>American Pale Ale 4.7% ABV | 30 IBU | 7.3 SRM Who says lighter beers have to be boring? Let There Be Light is Wild Heaven&rsquo;s first &ldquo;sessionable&rdquo; beer, coming in at only 4.7%, yet FULL of flavor. Starting with both barley and wheat, we added two rare hops&mdash;Nelson Sauvin and Sorachi Ace&mdash;along with a bit of orange peel, to create a complex beer with a citrus note that will change the way you think about &ldquo;light&rdquo; beer. Suggested food pairings: Wings, fish &amp; chips, Tomme-style cheese, brunch (the citrus picks up nicely), burgers.</p>','','','','',NULL,NULL,NULL,NULL,'','',5,2,'let-there-be-light'),(11,'White Blackbird','<p>Belgian-style Saison 6% ABV | 15.5 IBU | 7 SRM Our Belgian Saison is brewed with generous amounts of pink peppercorns to accentuate the herbal, earthy, spicy notes of this amazing yeast. Korean pears marinated in Chardonnay are added to fermentation along with French oak. The result is a host of savory flavors melding together into a wonderful new spin on a well-known style. Finishes dry with woody earthy hints and elegantly well rounded fruit and spice notes.</p>','','','','',NULL,NULL,NULL,NULL,'','',6,2,'white-blackbird'),(12,'Civilization','<p>English-style Barleywine 12% ABV | 40 IBU | 13.5 SRM Built on the backbone of a classic English Barleywine with the addition of dried Prussian lemons, tart cherries, and cranberries. Dark fruit abounds with roasted goodness in each sip. Hints of melon and tropical notes on the nose. Long lingering finish that is rich yet not cloying that is reminiscent of fresh baked bread, bright citrus, and mellow pit fruit. Bold and complex at 12% with new layers emerging as your goblet warms.</p>','','','','',NULL,NULL,NULL,NULL,'','',3,2,'civilization');
/*!40000 ALTER TABLE `tour_tourstop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_tourstopmedia`
--

DROP TABLE IF EXISTS `tour_tourstopmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_tourstopmedia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `source_link` varchar(525) NOT NULL,
  `metadata` longtext NOT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `tour_stop_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tour_tourstopmedia_9a715b3b` (`tour_stop_id`),
  CONSTRAINT `tour_tourstopm_tour_stop_id_70e6678b94c3502b_fk_tour_tourstop_id` FOREIGN KEY (`tour_stop_id`) REFERENCES `tour_tourstop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_tourstopmedia`
--

LOCK TABLES `tour_tourstopmedia` WRITE;
/*!40000 ALTER TABLE `tour_tourstopmedia` DISABLE KEYS */;
INSERT INTO `tour_tourstopmedia` VALUES (15,'Party','Elmyr knows how to party.','stops/1311422543-photo_module-17_PqR5eiQ.jpg','','',0,1),(16,'The Building','It\'s not great, but it\'s wonderful.','stops/20210308_WwnoNHuMkWilnmVXocIMc5diwpd0eMu6t062CZT5YVU.jpg','','',1,1),(17,'Elmyr de Hory','Named for this forger.','stops/Elmyr_de_hory.jpg','','',3,1),(18,'YUM!','','stops/ls.jpg','','',2,1),(19,'Sweet Auburn Curb Market','Counter','stops/110502123450_photo.jpg','','',0,2),(20,'Burrito','All the good stuff','stops/bellST.jpg','','',1,2);
/*!40000 ALTER TABLE `tour_tourstopmedia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-24 16:05:16
