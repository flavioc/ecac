-- MySQL dump 10.13  Distrib 5.1.32, for apple-darwin9.5.0 (i386)
--
-- Host: localhost    Database: adult
-- ------------------------------------------------------
-- Server version	5.1.32

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
-- Table structure for table `adult`
--

DROP TABLE IF EXISTS `adult`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `adult` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `age` int(11) DEFAULT NULL,
  `workclass` enum('private','self_emp_not_inc','self_emp_inc','federal_gov','local_gov','state_gov','without_pay','never_worked','unknown') DEFAULT NULL,
  `fnlwgt` int(11) DEFAULT NULL,
  `education` enum('bachelors','some_college','11th','hs_grad','prof_school','assoc_acdm','assoc_voc','9th','7th_8th','12th','masters','1st_4th','10th','doctorate','5th_6th','preschool') DEFAULT NULL,
  `education_num` int(11) DEFAULT NULL,
  `marital_status` enum('married_civ_spouse','divorced','never_married','separated','widowed','married_spouse_absent','married_af_spouse') DEFAULT NULL,
  `occupation` enum('tech_support','craft_repair','other_service','sales','exec_managerial','prof_specialty','handlers_cleaners','machine_op_inspct','adm_clerical','farming_fishing','transport_moving','priv_house_serv','protective_serv','armed_forces','unknown') DEFAULT NULL,
  `relationship` enum('wife','own_child','husband','not_in_family','other_relative','unmarried') DEFAULT NULL,
  `race` enum('white','asian_pac_islander','amer_indian_eskimo','other','black') DEFAULT NULL,
  `sex` enum('male','female') DEFAULT NULL,
  `capital_gain` int(11) DEFAULT NULL,
  `capital_loss` int(11) DEFAULT NULL,
  `hours_per_week` int(11) DEFAULT NULL,
  `native_country` enum('united_states','cambodia','england','puerto_rico','canada','germany','outlying_us','india','japan','greece','south','china','cuba','iran','honduras','philippines','italy','poland','jamaica','vietnam','mexico','portugal','ireland','france','dominican_republic','laos','ecuador','taiwan','haiti','columbia','hungary','guatemala','nicaragua','scotland','thailand','yugoslavia','el_salvador','trinadad_tobago','peru','hong','holand_netherlands','unknown') DEFAULT NULL,
  `plus_50` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=280037 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'adult'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-10-22 14:10:41
