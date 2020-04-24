-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: localhost    Database: odbs
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Blood_Bank`
--

DROP TABLE IF EXISTS `Blood_Bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Blood_Bank` (
  `BANK_id` char(11) COLLATE utf8mb4_general_ci NOT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `Units` int(11) NOT NULL,
  `Address` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Contact` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `pincode` char(6) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`BANK_id`),
  CONSTRAINT `blood_bank_chk_1` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-'))),
  CONSTRAINT `blood_bank_chk_2` CHECK ((`BANK_id` = _utf8mb4'BBANK%')),
  CONSTRAINT `blood_bank_chk_3` CHECK ((`Pincode` between _utf8mb4'110000' and _utf8mb4'929999'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blood_Bank`
--

LOCK TABLES `Blood_Bank` WRITE;
/*!40000 ALTER TABLE `Blood_Bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `Blood_Bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Blood_Donor`
--

DROP TABLE IF EXISTS `Blood_Donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Blood_Donor` (
  `Age` int(11) NOT NULL,
  `BLD_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `ORG_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Last_Donated` date NOT NULL,
  `Last_Checkup` date NOT NULL,
  PRIMARY KEY (`BLD_id`),
  KEY `ORG_id` (`ORG_id`),
  CONSTRAINT `blood_donor_ibfk_1` FOREIGN KEY (`ORG_id`) REFERENCES `organisation` (`ORG_id`),
  CONSTRAINT `blood_donor_chk_1` CHECK ((`age` > 17)),
  CONSTRAINT `blood_donor_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-'))),
  CONSTRAINT `blood_donor_chk_3` CHECK ((`BLD_id` = _utf8mb4'BLD%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blood_Donor`
--

LOCK TABLES `Blood_Donor` WRITE;
/*!40000 ALTER TABLE `Blood_Donor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Blood_Donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cornea`
--

DROP TABLE IF EXISTS `Cornea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cornea` (
  `ORGAN_id` char(7) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Matched_id` char(7) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Procurement_Timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `DON_id` (`DON_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  CONSTRAINT `cornea_ibfk_1` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `cornea_ibfk_2` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `cornea_ibfk_3` FOREIGN KEY (`Matched_id`) REFERENCES `cornea` (`ORGAN_id`),
  CONSTRAINT `cornea_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'C%')),
  CONSTRAINT `cornea_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cornea`
--

LOCK TABLES `Cornea` WRITE;
/*!40000 ALTER TABLE `Cornea` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cornea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor`
--

DROP TABLE IF EXISTS `Doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctor` (
  `Doc_ID` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Contact` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Speciality` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Doc_ID`),
  CONSTRAINT `doctor_chk_1` CHECK ((`Doc_ID` = _utf8mb4'DOC%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor`
--

LOCK TABLES `Doctor` WRITE;
/*!40000 ALTER TABLE `Doctor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organ_Donor`
--

DROP TABLE IF EXISTS `Organ_Donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organ_Donor` (
  `Age` int(11) NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Contact` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `ORG_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Status` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `Last_check_up_date` date DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Pincode` char(6) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`DON_id`),
  KEY `ORG_id` (`ORG_id`),
  CONSTRAINT `donor_ibfk_1` FOREIGN KEY (`ORG_id`) REFERENCES `organisation` (`ORG_id`),
  CONSTRAINT `donor_chk_1` CHECK ((`DON_id` = _utf8mb4'DON%')),
  CONSTRAINT `donor_chk_2` CHECK ((`age` > 17)),
  CONSTRAINT `donor_chk_3` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-'))),
  CONSTRAINT `donor_chk_4` CHECK ((`Pincode` between _utf8mb4'110000' and _utf8mb4'929999'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organ_Donor`
--

LOCK TABLES `Organ_Donor` WRITE;
/*!40000 ALTER TABLE `Organ_Donor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Organ_Donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Heart`
--

DROP TABLE IF EXISTS `Heart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Heart` (
  `ORGAN_id` char(7) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Matched_id` char(7) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Size` double NOT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `DON_id` (`DON_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  CONSTRAINT `heart_ibfk_1` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `heart_ibfk_2` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `heart_ibfk_3` FOREIGN KEY (`Matched_id`) REFERENCES `heart` (`ORGAN_id`),
  CONSTRAINT `heart_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'H%')),
  CONSTRAINT `heart_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Heart`
--

LOCK TABLES `Heart` WRITE;
/*!40000 ALTER TABLE `Heart` DISABLE KEYS */;
/*!40000 ALTER TABLE `Heart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kidney`
--

DROP TABLE IF EXISTS `Kidney`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Kidney` (
  `ORGAN_id` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Matched_id` char(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PRA` double NOT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `DON_id` (`DON_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  CONSTRAINT `kidney_ibfk_1` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `kidney_ibfk_2` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `kidney_ibfk_3` FOREIGN KEY (`Matched_id`) REFERENCES `kidney` (`ORGAN_id`),
  CONSTRAINT `kidney_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'KD%')),
  CONSTRAINT `kidney_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-'))),
  CONSTRAINT `kidney_chk_3` CHECK ((`PRA` between 0 and 99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Kidney`
--

LOCK TABLES `Kidney` WRITE;
/*!40000 ALTER TABLE `Kidney` DISABLE KEYS */;
/*!40000 ALTER TABLE `Kidney` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Liver`
--

DROP TABLE IF EXISTS `Liver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Liver` (
  `ORGAN_id` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Matched_id` char(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Size` double NOT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `DON_id` (`DON_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  CONSTRAINT `liver_ibfk_1` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `liver_ibfk_2` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `liver_ibfk_3` FOREIGN KEY (`Matched_id`) REFERENCES `liver` (`ORGAN_id`),
  CONSTRAINT `liver_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'LI%')),
  CONSTRAINT `liver_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Liver`
--

LOCK TABLES `Liver` WRITE;
/*!40000 ALTER TABLE `Liver` DISABLE KEYS */;
/*!40000 ALTER TABLE `Liver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lung`
--

DROP TABLE IF EXISTS `Lung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lung` (
  `ORGAN_id` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Matched_id` char(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Age` int(11) NOT NULL,
  `Size` double NOT NULL,
  `Smoking_History` int(11) NOT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `DON_id` (`DON_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  CONSTRAINT `lung_ibfk_1` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `lung_ibfk_2` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `lung_ibfk_3` FOREIGN KEY (`Matched_id`) REFERENCES `lung` (`ORGAN_id`),
  CONSTRAINT `lung_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'LU%')),
  CONSTRAINT `lung_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lung`
--

LOCK TABLES `Lung` WRITE;
/*!40000 ALTER TABLE `Lung` DISABLE KEYS */;
/*!40000 ALTER TABLE `Lung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organisation`
--

DROP TABLE IF EXISTS `Organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organisation` (
  `ORG_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Contact` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Organs_accepted` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ORG_id`),
  CONSTRAINT `organisation_chk_1` CHECK ((`ORG_id` = _utf8mb4'ORG%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organisation`
--

LOCK TABLES `Organisation` WRITE;
/*!40000 ALTER TABLE `Organisation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pancreas`
--

DROP TABLE IF EXISTS `Pancreas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pancreas` (
  `ORGAN_id` char(8) COLLATE utf8mb4_general_ci NOT NULL,
  `DON_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  `Matched_id` char(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `OPTN` double DEFAULT NULL,
  PRIMARY KEY (`ORGAN_id`),
  KEY `PAT_id` (`PAT_id`),
  KEY `Matched_id` (`Matched_id`),
  KEY `Organ_Donor` (`DON_id`),
  CONSTRAINT `pancreas_ibfk_1` FOREIGN KEY (`PAT_id`) REFERENCES `patient` (`PAT_id`),
  CONSTRAINT `pancreas_ibfk_2` FOREIGN KEY (`Matched_id`) REFERENCES `pancreas` (`ORGAN_id`),
  CONSTRAINT `pancreas_ibfk_3` FOREIGN KEY (`DON_id`) REFERENCES `Organ_Donor` (`DON_id`),
  CONSTRAINT `pancreas_chk_1` CHECK ((`ORGAN_id` = _utf8mb4'PN%')),
  CONSTRAINT `pancreas_chk_2` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pancreas`
--

LOCK TABLES `Pancreas` WRITE;
/*!40000 ALTER TABLE `Pancreas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pancreas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `Pincode` char(6) COLLATE utf8mb4_general_ci NOT NULL,
  `Last_check_up_date` date DEFAULT NULL,
  `PAT_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Contact` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Doc_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `Organ` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Age` int(11) NOT NULL,
  `Blood_Group` varchar(3) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`PAT_id`),
  KEY `Doc_id` (`Doc_id`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`Doc_id`) REFERENCES `doctor` (`Doc_ID`),
  CONSTRAINT `patient_chk_1` CHECK ((`PAT_id` = _utf8mb4'PAT%')),
  CONSTRAINT `patient_chk_2` CHECK ((`Pincode` between _utf8mb4'110000' and _utf8mb4'929999')),
  CONSTRAINT `patient_chk_3` CHECK ((`Blood_Group` in (_utf8mb4'A+',_utf8mb4'A-',_utf8mb4'B+',_utf8mb4'B-',_utf8mb4'O+',_utf8mb4' O-',_utf8mb4'AB+',_utf8mb4'AB-')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-31 18:28:48
