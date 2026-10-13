-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: patientportal
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int NOT NULL,
  `AppointmentDate` date NOT NULL,
  `AppointmentTime` time NOT NULL,
  `DurationMinutes` int NOT NULL DEFAULT '30',
  `Reason` varchar(255) DEFAULT NULL,
  `Status` varchar(20) NOT NULL DEFAULT 'Scheduled',
  PRIMARY KEY (`AppointmentID`),
  UNIQUE KEY `PatientID` (`PatientID`,`AppointmentDate`,`AppointmentTime`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,1,'2024-09-05','09:00:00',30,'Annual physical','Completed'),(2,2,'2024-09-06','10:00:00',30,'Follow up hypertension','Completed'),(3,3,'2024-09-09','11:00:00',45,'Chest pain evaluation','Completed'),(4,4,'2024-09-10','09:30:00',30,'Birth control consult','Completed'),(5,5,'2024-09-11','14:00:00',30,'Asthma check','Completed'),(6,6,'2024-09-12','08:00:00',45,'Head Trauma','Completed'),(7,7,'2024-09-13','13:00:00',30,'Respiratory infection','Completed'),(8,8,'2024-09-16','10:30:00',60,'Cardiac stress test','Completed'),(9,9,'2024-09-17','09:00:00',30,'Headache evaluation','Completed'),(10,10,'2024-09-18','11:00:00',45,'Thyroid follow up','Completed'),(11,11,'2024-09-19','14:30:00',30,'Prenatal visit','Completed'),(12,12,'2024-09-20','08:30:00',60,'Post operation cardiac check','Completed'),(13,13,'2024-09-23','09:00:00',30,'Pediatric well-child visit','Completed'),(14,14,'2024-09-24','10:00:00',30,'Annual physical','Completed'),(15,15,'2024-09-25','11:30:00',30,'Pulmonary function test','Completed'),(16,16,'2024-09-26','09:00:00',45,'Endocrine consult','Completed'),(17,17,'2024-09-27','13:00:00',30,'OB prenatal check','Completed'),(18,18,'2024-09-30','10:00:00',60,'Cardiac review','Completed'),(19,19,'2024-10-01','09:30:00',30,'Routine check-up','Completed'),(20,20,'2024-10-02','11:00:00',30,'Allergy review','Completed'),(21,21,'2024-10-03','14:00:00',30,'Migraine management','Completed'),(22,22,'2024-10-04','09:00:00',30,'Annual physical','Completed'),(23,23,'2024-10-07','10:30:00',30,'Prenatal visit','Completed'),(24,24,'2024-10-08','08:30:00',45,'Hypertension follow up','Completed'),(25,25,'2024-10-09','13:00:00',30,'Asthma management','Completed'),(26,26,'2024-10-10','09:00:00',30,'Annual physical','Completed'),(27,1,'2024-11-05','10:00:00',30,'Lab results review','Scheduled'),(28,3,'2024-11-06','11:00:00',45,'Cardiology follow up','Scheduled'),(29,6,'2024-11-07','09:00:00',45,'Diabetes management','Scheduled'),(30,8,'2024-11-08','14:00:00',60,'Cardiac consultation','Cancelled'),(31,5,'2024-12-01','10:00:00',30,'Asthma follow-up','Scheduled');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointmentdoctor`
--

DROP TABLE IF EXISTS `appointmentdoctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentdoctor` (
  `AppointmentID` int NOT NULL,
  `DoctorID` int NOT NULL,
  PRIMARY KEY (`AppointmentID`,`DoctorID`),
  KEY `DoctorID` (`DoctorID`),
  CONSTRAINT `appointmentdoctor_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointment` (`AppointmentID`),
  CONSTRAINT `appointmentdoctor_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointmentdoctor`
--

LOCK TABLES `appointmentdoctor` WRITE;
/*!40000 ALTER TABLE `appointmentdoctor` DISABLE KEYS */;
INSERT INTO `appointmentdoctor` VALUES (1,1),(3,1),(8,1),(14,1),(22,1),(26,1),(27,1),(2,2),(4,2),(19,2),(24,2),(3,3),(8,3),(12,3),(18,3),(28,3),(30,3),(10,4),(16,4),(29,4),(5,5),(7,5),(12,5),(15,5),(18,5),(25,5),(6,6),(9,6),(21,6),(13,7),(20,7),(11,8),(17,8),(23,8);
/*!40000 ALTER TABLE `appointmentdoctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditlog` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `TableName` varchar(60) NOT NULL,
  `Action` varchar(10) NOT NULL,
  `RecordID` int DEFAULT NULL,
  `ChangeTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Details` text,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
INSERT INTO `auditlog` VALUES (1,'Appointment','INSERT',31,'2026-04-13 22:18:43','New appointment for PatientID 5 on 2024-12-01 at 10:00:00 | Status: Scheduled');
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `DiagnosisID` int NOT NULL AUTO_INCREMENT,
  `EntryID` int NOT NULL,
  `ICD10Code` varchar(10) DEFAULT NULL,
  `DiagnosisName` varchar(200) NOT NULL,
  `DiagnosisDate` date NOT NULL,
  `Status` varchar(30) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`DiagnosisID`),
  KEY `EntryID` (`EntryID`),
  CONSTRAINT `diagnosis_ibfk_1` FOREIGN KEY (`EntryID`) REFERENCES `medicalrecordentry` (`EntryID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
INSERT INTO `diagnosis` VALUES (1,1,'E78.5','Hyperlipidemia','2024-09-05','Active'),(2,2,'I10','Essential Hypertension','2024-09-06','Chronic'),(3,3,'R07.9','Chest pain, unspecified','2024-09-09','Active'),(4,3,'I25.10','Coronary artery disease','2024-09-09','Suspected'),(5,5,'J45.20','Mild intermittent asthma','2024-09-11','Chronic'),(6,6,'E11.9','Head Trauma','2024-09-12','Chronic'),(7,7,'J18.9','Community-acquired pneumonia','2024-09-13','Active'),(8,8,'I25.10','Coronary artery disease','2024-09-16','Active'),(9,9,'G44.20','Tension-type headache','2024-09-17','Active'),(10,10,'E03.9','Hypothyroidism','2024-09-18','Chronic'),(11,12,'I50.9','Heart failure','2024-09-20','Chronic'),(12,14,'E66.01','Morbid obesity','2024-09-24','Active'),(13,15,'J44.1','COPD with acute exacerbation','2024-09-25','Chronic'),(14,16,'E11.9','Type 2 diabetes mellitus','2024-09-26','Chronic'),(15,16,'E78.5','Hyperlipidemia','2024-09-26','Active'),(16,18,'I50.9','Congestive heart failure','2024-09-30','Chronic'),(17,21,'G43.109','Migraine with aura','2024-10-03','Chronic'),(18,22,'K21.0','GERD with esophagitis','2024-10-04','Active'),(19,24,'I10','Essential Hypertension','2024-10-08','Chronic'),(20,25,'J45.30','Mild persistent asthma','2024-10-09','Chronic'),(21,2,'E78.5','Hyperlipidemia','2024-09-06','Active'),(22,6,'E78.5','Hyperlipidemia','2024-09-12','Active'),(23,8,'I10','Essential Hypertension','2024-09-16','Chronic'),(24,10,'E78.5','Hyperlipidemia','2024-09-18','Active'),(25,15,'J96.00','Acute respiratory failure','2024-09-25','Resolved'),(26,18,'I10','Essential Hypertension','2024-09-30','Chronic'),(27,7,'J22','Acute lower respiratory infection','2024-09-13','Resolved'),(28,1,'Z00.00','Encounter for adult health exam','2024-09-05','Resolved');
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Specialty` varchar(80) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `OfficeAddress` varchar(200) NOT NULL,
  PRIMARY KEY (`DoctorID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Kenzo','Tenma','Internal Medicine','210-555-0101','k.tenma@clinic.org','100 Medical Plaza, San Antonio, TX'),(2,'Marcus','Fenix','Family Medicine','210-555-0102','m.fenix@clinic.org','100 Medical Plaza, San Antonio, TX'),(3,'Leon','Kennedy','Cardiology','210-555-0103','l.kennedy@clinic.org','200 Heart Center Dr, San Antonio, TX'),(4,'Edward','Elric','Endocrinology','210-555-0104','e.elric@clinic.org','100 Medical Plaza, San Antonio, TX'),(5,'Tony','Chopper','Pulmonology','210-555-0105','t.chopper@clinic.org','300 Lung & Allergy Blvd, San Antonio, TX'),(6,'Light','Yagami','Neurology','210-555-0106','l.yagami@clinic.org','400 Neuro Wing, San Antonio, TX'),(7,'Yuji','Itadori','Pediatrics','210-555-0107','y.itadori@clinic.org','500 Childrens Way, San Antonio, TX'),(8,'Hinata','Hyuga','Obstetrics & Gynecology','210-555-0108','h.hyuga@clinic.org','600 Womens Health Ave, San Antonio, TX');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalchart`
--

DROP TABLE IF EXISTS `medicalchart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalchart` (
  `ChartID` int NOT NULL AUTO_INCREMENT,
  `RecordID` int NOT NULL,
  `CurrentAfflictions` text,
  `PastAfflictions` text,
  `CurrentTreatments` text,
  `PastTreatments` text,
  `Prognosis` text,
  `LastUpdated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ChartID`),
  UNIQUE KEY `RecordID` (`RecordID`),
  CONSTRAINT `medicalchart_ibfk_1` FOREIGN KEY (`RecordID`) REFERENCES `medicalrecord` (`RecordID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalchart`
--

LOCK TABLES `medicalchart` WRITE;
/*!40000 ALTER TABLE `medicalchart` DISABLE KEYS */;
INSERT INTO `medicalchart` VALUES (1,1,'Hyperlipidemia','None significant','Atorvastatin 20mg','None','Good; annual follow-up','2026-04-13 22:18:43'),(2,2,'Hypertension, Hyperlipidemia','None significant','Lisinopril, Amlodipine, HCTZ, Atorvastatin','None','Stable with medication','2026-04-13 22:18:43'),(3,3,'Coronary artery disease, Hypertension','Appendectomy 2005','Nitroglycerin PRN, cardiac monitoring','Aspirin','Guarded; pending catheterization','2026-04-13 22:18:43'),(4,4,'None active','None','OCP Ortho Tri-Cyclen','None','Good','2026-04-13 22:18:43'),(5,5,'Asthma','None','Albuterol inhaler PRN','Oral steroids 2022','Stable','2026-04-13 22:18:43'),(6,6,'Type 2 DM, Hyperlipidemia','None','Metformin, Atorvastatin','None','Chronic, managed','2026-04-13 22:18:43'),(7,7,'Community-acquired pneumonia (resolved)','None','Completed azithromycin','None','Full recovery','2026-04-13 22:18:43'),(8,8,'Coronary artery disease, Heart failure','MI 2019, CABG 2024','Carvedilol, Furosemide','Aspirin (completed)','Stable post-CABG','2026-04-13 22:18:43'),(9,9,'Tension headaches','None','Ibuprofen PRN','None','Good','2026-04-13 22:18:43'),(10,10,'Hypothyroidism, Hyperlipidemia','None','Levothyroxine, Vitamin D3, Atorvastatin','None','Stable','2026-04-13 22:18:43'),(11,11,'Pregnancy (G1P0)','None','Iron supplements, prenatal vitamins','None','Good; uncomplicated','2026-04-13 22:18:43'),(12,12,'Heart failure, CAD','CABG 2024','Carvedilol, Furosemide, Lisinopril','None','Improving','2026-04-13 22:18:43'),(13,13,'None','None','Up to date on vaccines','None','Good','2026-04-13 22:18:43'),(14,14,'Morbid obesity','None','Dietary counseling','None','Good with intervention','2026-04-13 22:18:43'),(15,15,'COPD','Pneumonia 2021','Tiotropium inhaler','Oral steroids','Chronic, managed','2026-04-13 22:18:43'),(16,16,'Type 2 DM, Hyperlipidemia','None','Metformin, Rosuvastatin','None','Stable','2026-04-13 22:18:43'),(17,17,'Pregnancy (G2P1)','None','Prenatal vitamins','None','Good','2026-04-13 22:18:43'),(18,18,'CHF, Hypertension','None','Lisinopril, Spironolactone','Furosemide 2022','Stable, chronic','2026-04-13 22:18:43'),(19,19,'None','None','None','None','Good','2026-04-13 22:18:43'),(20,20,'Seasonal allergies','None','Antihistamine PRN','None','Good','2026-04-13 22:18:43'),(21,21,'Chronic migraine','None','Topiramate','None','Managed','2026-04-13 22:18:43'),(22,22,'GERD','None','Omeprazole','Antacids','Good','2026-04-13 22:18:43'),(23,23,'Pregnancy (G1P0)','None','Prenatal vitamins','None','Good','2026-04-13 22:18:43'),(24,24,'Hypertension','None','Lisinopril, Losartan','HCTZ','Guarded','2026-04-13 22:18:43'),(25,25,'Asthma','None','Fluticasone inhaler','Albuterol PRN','Stable','2026-04-13 22:18:43'),(26,26,'None','None','None','None','Good; labs pending','2026-04-13 22:18:43');
/*!40000 ALTER TABLE `medicalchart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalrecord`
--

DROP TABLE IF EXISTS `medicalrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalrecord` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastUpdated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecordID`),
  UNIQUE KEY `PatientID` (`PatientID`),
  CONSTRAINT `medicalrecord_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalrecord`
--

LOCK TABLES `medicalrecord` WRITE;
/*!40000 ALTER TABLE `medicalrecord` DISABLE KEYS */;
INSERT INTO `medicalrecord` VALUES (1,1,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(2,2,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(3,3,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(4,4,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(5,5,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(6,6,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(7,7,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(8,8,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(9,9,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(10,10,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(11,11,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(12,12,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(13,13,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(14,14,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(15,15,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(16,16,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(17,17,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(18,18,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(19,19,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(20,20,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(21,21,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(22,22,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(23,23,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(24,24,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(25,25,'2026-04-13 22:18:43','2026-04-13 22:18:43'),(26,26,'2026-04-13 22:18:43','2026-04-13 22:18:43');
/*!40000 ALTER TABLE `medicalrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalrecordentry`
--

DROP TABLE IF EXISTS `medicalrecordentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalrecordentry` (
  `EntryID` int NOT NULL AUTO_INCREMENT,
  `RecordID` int NOT NULL,
  `DoctorID` int NOT NULL,
  `AppointmentID` int DEFAULT NULL,
  `EntryDate` date NOT NULL,
  `ChiefComplaint` varchar(255) DEFAULT NULL,
  `VitalSigns` text,
  `ClinicalNotes` text,
  `Prognosis` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EntryID`),
  KEY `RecordID` (`RecordID`),
  KEY `DoctorID` (`DoctorID`),
  KEY `AppointmentID` (`AppointmentID`),
  CONSTRAINT `medicalrecordentry_ibfk_1` FOREIGN KEY (`RecordID`) REFERENCES `medicalrecord` (`RecordID`),
  CONSTRAINT `medicalrecordentry_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`),
  CONSTRAINT `medicalrecordentry_ibfk_3` FOREIGN KEY (`AppointmentID`) REFERENCES `appointment` (`AppointmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalrecordentry`
--

LOCK TABLES `medicalrecordentry` WRITE;
/*!40000 ALTER TABLE `medicalrecordentry` DISABLE KEYS */;
INSERT INTO `medicalrecordentry` VALUES (1,1,1,1,'2024-09-05','Annual physical','BP 118/76, HR 72, SpO2 99%','Patient healthy; mild hyperlipidemia noted. [Addendum: follow-up labs ordered]','Good'),(2,2,2,2,'2024-09-06','Elevated blood pressure','BP 148/92, HR 80, SpO2 98%','Hypertension not well controlled; medication adjusted.','Stable with treatment'),(3,3,3,3,'2024-09-09','Chest pain','BP 155/95, HR 88, SpO2 96%','Atypical chest pain; ECG changes noted.','Guarded'),(4,4,2,4,'2024-09-10','Contraception review','BP 112/70, HR 68, SpO2 100%','Patient counseled on options; OCP prescribed.','Good'),(5,5,5,5,'2024-09-11','Asthma flare','BP 120/78, HR 76, SpO2 95%','Mild asthma exacerbation; inhaler technique reviewed.','Stable'),(6,6,6,6,'2024-09-12','Headaches','BP 132/84, HR 74, SpO2 98%','Tension-type headaches; lifestyle modification advised.','Chronic, managed'),(7,7,5,7,'2024-09-13','Respiratory symptoms','BP 116/74, HR 82, SpO2 97%','Community-acquired pneumonia; antibiotics started.','Expected full recovery'),(8,8,3,8,'2024-09-16','Cardiac evaluation','BP 145/90, HR 86, SpO2 97%','Stress test mildly abnormal; cath lab referral placed.','Guarded pending cath'),(9,9,6,9,'2024-09-17','Headaches','BP 122/78, HR 70, SpO2 99%','Tension-type headaches; lifestyle modification advised.','Good'),(10,10,4,10,'2024-09-18','Thyroid check','BP 128/80, HR 68, SpO2 99%','Hypothyroidism, levothyroxine dose adjusted.','Stable'),(11,11,8,11,'2024-09-19','Prenatal visit','BP 110/68, HR 74, SpO2 100%','20-week anatomy scan normal, iron supplements added.','Good'),(12,12,3,12,'2024-09-20','Post op cardiac check','BP 138/86, HR 80, SpO2 98%','Six-week post CABG; healing well, EF 50%.','Improving'),(13,13,7,13,'2024-09-23','Well child visit','BP 100/62, HR 84, SpO2 100%','Growth and development normal, vaccines up to date.','Good'),(14,14,1,14,'2024-09-24','Annual physical','BP 120/78, HR 72, SpO2 100%','Healthy adult; advised weight management.','Good'),(15,15,5,15,'2024-09-25','Shortness of breath','BP 126/80, HR 78, SpO2 94%','FEV1 reduced; COPD moderate severity confirmed.','Chronic, managed'),(16,16,4,16,'2024-09-26','Hormone concerns','BP 134/88, HR 76, SpO2 99%','Type 2 DM and hyperlipidemia; statin therapy initiated.','Stable'),(17,17,8,17,'2024-09-27','Prenatal check','BP 108/66, HR 72, SpO2 100%','28-week visit; glucose challenge test ordered.','Good'),(18,18,3,18,'2024-09-30','Cardiac review','BP 142/88, HR 84, SpO2 97%','CHF NYHA Class II; diuretic adjusted.','Stable, chronic'),(19,19,2,19,'2024-10-01','Routine check-up','BP 114/72, HR 70, SpO2 100%','Healthy; Somewhat Schizo.','Good'),(20,20,7,20,'2024-10-02','Allergy concerns','BP 102/64, HR 80, SpO2 100%','Seasonal allergies; antihistamine prescribed.','Good'),(21,21,6,21,'2024-10-03','Migraine','BP 118/76, HR 68, SpO2 99%','Chronic migraine with aura; topiramate started.','Managed'),(22,22,1,22,'2024-10-04','Annual physical','BP 122/78, HR 72, SpO2 99%','Mild GERD noted; PPI trial started.','Good'),(23,23,8,23,'2024-10-07','Prenatal visit','BP 106/64, HR 76, SpO2 100%','32-week visit; fetal growth appropriate.','Good'),(24,24,2,24,'2024-10-08','Hypertension follow-up','BP 150/96, HR 82, SpO2 98%','BP still elevated; second antihypertensive added.','Guarded'),(25,25,5,25,'2024-10-09','Asthma management','BP 116/72, HR 76, SpO2 96%','Persistent asthma; controller inhaler prescribed.','Stable'),(26,26,1,26,'2024-10-10','Annual physical','BP 124/80, HR 74, SpO2 100%','Healthy; lab work ordered.','Good');
/*!40000 ALTER TABLE `medicalrecordentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `BloodType` varchar(5) DEFAULT NULL,
  `Allergies` text,
  `Ethnicity` varchar(80) DEFAULT NULL,
  `Religion` varchar(80) DEFAULT NULL,
  `ReligiousRestrictions` text,
  `Pronouns` varchar(30) DEFAULT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `AccountID` int NOT NULL,
  `PrimaryDoctorID` int NOT NULL,
  PRIMARY KEY (`PatientID`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `AccountID` (`AccountID`),
  KEY `PrimaryDoctorID` (`PrimaryDoctorID`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `portalaccount` (`AccountID`),
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`PrimaryDoctorID`) REFERENCES `doctor` (`DoctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Stan','Smith','1975-04-12','O+','Penicillin','Caucasian','Christian',NULL,'He/Him','210-555-1001','ssmith@email.com',1,1),(2,'Magaret','Williams','1988-07-23','A+','Sulfa','Hispanic','Catholic',NULL,'She/Her','210-555-1002','mwilliams@email.com',2,2),(3,'Roger','Johnson','1962-11-05','B-','Latex','African American','Baptist',NULL,'He/Him','210-555-1003','rjohnson@email.com',3,3),(4,'Angelica','Garcia','1995-03-18','AB+','None','Hispanic','Catholic',NULL,'She/Her','210-555-1004','agarcia@email.com',4,2),(5,'Linda','Belcher','1980-09-30','O-','Aspirin','Caucasian','Catholic','No blood transfusions','She/Her','210-555-1005','lbelcher@email.com',5,1),(6,'Joel','Miller','1971-06-14','A-','Codeine','Caucasian','Protestant',NULL,'He/Him','210-555-1006','jmiller@email.com',6,6),(7,'Davey','Jones','1990-12-01','B+','Ibuprofen','Caucasian','None',NULL,'She/Her','210-555-1007','djones@email.com',7,5),(8,'Thomas','Davis','1955-02-28','O+','Shellfish','African American','Methodist',NULL,'He/Him','210-555-1008','tdavis@email.com',8,3),(9,'Susan','Wilson','1983-08-09','A+','None','Asian','Buddhist','No pork derivatives','She/Her','210-555-1009','swilson@email.com',9,6),(10,'Brian','Griffin','1967-05-20','AB-','Morphine','Caucasian','agnostic',NULL,'He/Him','210-555-1010','bgriffin@email.com',10,4),(11,'Carol','Taylor','1992-10-17','O+','Amoxicillin','Hispanic','Catholic',NULL,'She/Her','210-555-1011','ctaylor@email.com',11,8),(12,'Paul','Walker','1958-01-07','A+','Tetracycline','Caucasian','Lutheran',NULL,'He/Him','210-555-1012','pwalker@email.com',12,3),(13,'Emma','watson','2001-07-15','B+','Peanuts','Caucasian','None',NULL,'She/Her','210-555-1013','ewatson@email.com',13,7),(14,'Omar','Jackson','1977-03-23','O-','None','African American','Muslim','Halal medications preferred','He/Him','210-555-1014','ojackson@email.com',14,1),(15,'Walter','White','1985-11-11','A-','Cephalosporins','Caucasian','Agnostic',NULL,'He/Him','210-555-1015','wwhite@email.com',15,5),(16,'Kevin','Harris','1969-04-04','B-','Iodine','African American','Baptist',NULL,'He/Him','210-555-1016','khalris@email.com',16,4),(17,'Nina','Martin','1997-09-25','O+','Latex','Hispanic','Catholic',NULL,'She/Her','210-555-1017','nmartin@email.com',17,8),(18,'Yusuf','Thompson','1948-12-30','A+','NSAIDs','African American','Muslim','Halal medications preferred','He/Him','210-555-1018','ythompson@email.com',18,3),(19,'Lain','Iwakura','1993-06-06','AB+','None','Asian','Catholic',NULL,'She/Her','210-555-1019','liwakura@email.com',19,2),(20,'Zach','Martinez','2003-02-14','O+','Bee stings','Hispanic','Catholic',NULL,'He/Him','210-555-1020','zmartinez@email.com',20,7),(21,'Boa','Hancock','1986-08-08','B+','Penicillin','Asian','None',NULL,'She/Her','210-555-1021','bhancock@email.com',21,6),(22,'Clark','Kent','1972-05-19','A-','Codeine','Caucasian','Protestant',NULL,'He/Him','210-555-1022','ckent@email.com',22,1),(23,'Julia','Lewis','1991-03-27','O+','Sulfa','Caucasian','None',NULL,'She/Her','210-555-1023','jlewis@email.com',23,8),(24,'Kevin','Robinson','1965-10-10','AB+','None','African American','Baptist',NULL,'He/Him','210-555-1024','krobin@email.com',24,2),(25,'Yor','Forger','2000-01-22','A+','Amoxicillin','Caucasian','Agnostic',NULL,'She/Her','210-555-1025','yforger@email.com',25,5),(26,'Luis','Miguel','1979-07-07','O-','None','Hispanic','Catholic',NULL,'He/Him','210-555-1026','lmiguel@email.com',26,1);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portalaccount`
--

DROP TABLE IF EXISTS `portalaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portalaccount` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(60) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastLogin` datetime DEFAULT NULL,
  PRIMARY KEY (`AccountID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portalaccount`
--

LOCK TABLES `portalaccount` WRITE;
/*!40000 ALTER TABLE `portalaccount` DISABLE KEYS */;
INSERT INTO `portalaccount` VALUES (1,'ssmith_patient','hashed_pw_001','2023-01-10 08:00:00','2024-11-01 09:15:00'),(2,'mwilliams_p','hashed_pw_002','2023-02-14 10:30:00','2024-10-20 14:00:00'),(3,'rjohnson_p','hashed_pw_003','2023-03-01 09:00:00','2024-11-02 11:00:00'),(4,'agarcia_p','hashed_pw_004','2023-04-05 07:45:00','2024-11-05 08:30:00'),(5,'lbelcher_p','hashed_pw_005','2023-05-18 13:00:00','2024-09-15 16:00:00'),(6,'jmiller_p','hashed_pw_006','2023-06-22 11:15:00','2024-10-28 10:45:00'),(7,'djones_p','hashed_pw_007','2023-07-30 08:30:00','2024-11-03 09:00:00'),(8,'tdavis_p','hashed_pw_008','2023-08-14 14:00:00','2024-10-15 12:00:00'),(9,'swilson_p','hashed_pw_009','2023-09-09 09:45:00','2024-11-06 08:00:00'),(10,'bgriffin_p','hashed_pw_010','2023-10-03 10:00:00','2024-10-30 13:30:00'),(11,'ctaylor_p','hashed_pw_011','2023-10-17 15:30:00','2024-11-01 14:00:00'),(12,'pwalker_p','hashed_pw_012','2023-11-08 08:15:00','2024-10-22 09:30:00'),(13,'ewatson_p','hashed_pw_013','2023-11-25 11:00:00','2024-11-04 10:15:00'),(14,'ojackson_p','hashed_pw_014','2023-12-01 07:30:00','2024-11-02 08:45:00'),(15,'wwhite_p','hashed_pw_015','2024-01-10 13:15:00','2024-10-18 15:00:00'),(16,'khalris_p','hashed_pw_016','2024-01-20 09:00:00','2024-11-05 10:00:00'),(17,'nmartin_p','hashed_pw_017','2024-02-05 10:30:00','2024-10-25 11:30:00'),(18,'ythompson_p','hashed_pw_018','2024-02-18 08:45:00','2024-11-03 09:45:00'),(19,'liwakura_p','hashed_pw_019','2024-03-12 14:00:00','2024-10-29 14:30:00'),(20,'zmartinez_p','hashed_pw_020','2024-03-28 11:30:00','2024-11-06 07:30:00'),(21,'bhancock_p','hashed_pw_021','2024-04-15 09:15:00','2024-10-20 12:00:00'),(22,'ckent_p','hashed_pw_022','2024-04-28 10:00:00','2024-11-01 11:00:00'),(23,'jlewis_p','hashed_pw_023','2024-05-10 07:45:00','2024-10-27 08:15:00'),(24,'krobin_p','hashed_pw_024','2024-05-22 13:30:00','2024-10-31 13:00:00'),(25,'yforger_p','hashed_pw_025','2024-06-07 08:00:00','2024-11-04 09:00:00'),(26,'lmiguel_p','hashed_pw_026','2024-06-19 11:00:00','2024-11-05 10:30:00');
/*!40000 ALTER TABLE `portalaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `PrescriptionID` int NOT NULL AUTO_INCREMENT,
  `EntryID` int NOT NULL,
  `DrugName` varchar(100) NOT NULL,
  `Dosage` varchar(50) NOT NULL,
  `Frequency` varchar(50) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date DEFAULT NULL,
  `RefillsAllowed` int NOT NULL DEFAULT '0',
  `Notes` text,
  PRIMARY KEY (`PrescriptionID`),
  KEY `EntryID` (`EntryID`),
  CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`EntryID`) REFERENCES `medicalrecordentry` (`EntryID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (1,1,'Atorvastatin','20 mg','Once daily at bedtime','2024-09-05',NULL,6,'Monitor liver enzymes in 3 months'),(2,2,'Lisinopril','10 mg','Once daily','2024-09-06',NULL,6,'Monitor potassium and creatinine'),(3,2,'Amlodipine','5 mg','Once daily','2024-09-06',NULL,6,'May cause ankle edema'),(4,4,'Ortho Tri-Cyclen','28 tabs','Once daily','2024-09-10','2025-09-10',11,'Take at same time each day'),(5,5,'Albuterol','90 mcg','Every 4-6 hrs as needed','2024-09-11',NULL,3,'Rescue inhaler; carry at all times'),(6,6,'Ibuprofen','400 mg','Every 6 hrs as needed','2024-09-12',NULL,6,'Take with food; monitor for headache relief'),(7,7,'Azithromycin','500 mg','Once daily for 5 days','2024-09-13','2024-09-18',0,'Complete full course'),(8,9,'Ibuprofen','400 mg','Every 6 hrs as needed','2024-09-17','2024-10-17',1,'Take with food'),(9,10,'Levothyroxine','75 mcg','Once daily fasting','2024-09-18',NULL,6,'Take 30 min before breakfast'),(10,12,'Carvedilol','6.25 mg','Twice daily','2024-09-20',NULL,6,'Do not stop abruptly'),(11,12,'Furosemide','40 mg','Once daily in morning','2024-09-20',NULL,6,'Monitor electrolytes'),(12,15,'Tiotropium','18 mcg','Once daily inhaled','2024-09-25',NULL,3,'COPD maintenance inhaler'),(13,15,'Prednisone','40 mg','Once daily for 5 days','2024-09-25','2024-09-30',0,'Taper as directed'),(14,16,'Metformin','500 mg','Once daily with dinner','2024-09-26',NULL,6,'Titrate up as tolerated'),(15,16,'Rosuvastatin','10 mg','Once daily at bedtime','2024-09-26',NULL,6,'Check CK if muscle pain'),(16,18,'Lisinopril','20 mg','Once daily','2024-09-30',NULL,6,'CHF management'),(17,18,'Spironolactone','25 mg','Once daily','2024-09-30',NULL,6,'Monitor potassium'),(18,21,'Topiramate','25 mg','Once daily increasing','2024-10-03',NULL,3,'Increase to 50 mg after 2 weeks'),(19,22,'Omeprazole','20 mg','Once daily before breakfast','2024-10-04',NULL,3,'8-week trial'),(20,24,'Losartan','50 mg','Once daily','2024-10-08',NULL,6,'Second agent for BP control'),(21,25,'Fluticasone','44 mcg','Twice daily inhaled','2024-10-09',NULL,3,'Controller inhaler; rinse mouth after use'),(22,2,'Hydrochlorothiazide','25 mg','Once daily in morning','2024-09-06',NULL,6,'Monitor sodium and potassium'),(23,6,'Atorvastatin','40 mg','Once daily at bedtime','2024-09-12',NULL,6,'Combined hyperlipidemia management'),(24,8,'Nitroglycerin','0.4 mg','PRN for chest pain SL','2024-09-16',NULL,2,'Call 911 if no relief after 3 doses'),(25,10,'Vitamin D3','2000 IU','Once daily with meal','2024-09-18',NULL,6,'Supplement for hypothyroid patients');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-13 22:21:48
