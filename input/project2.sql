-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: project2
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `Dname` varchar(15) NOT NULL,
  `Dnumber` int(11) NOT NULL,
  `Mgr_ssn` char(9) NOT NULL,
  `Mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  UNIQUE KEY `Dname_UNIQUE` (`Dname`),
  KEY `fk_mgr_ssn_idx` (`Mgr_ssn`),
  CONSTRAINT `fk_mgr_ssn` FOREIGN KEY (`Mgr_ssn`) REFERENCES `employee` (`Ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Headquarters',1,'888665555','1971-06-19'),('Networking',3,'110110110','2009-05-15'),('Administration',4,'987654321','1985-01-01'),('Research',5,'333445555','1978-05-22'),('Software',6,'111111100','1999-05-15'),('Hardware',7,'444444400','1998-05-15'),('Sales',8,'555555500','1997-01-01'),('HR',9,'112244668','1989-02-01'),('QA',11,'913323708','2010-02-02');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `Fname` varchar(15) NOT NULL,
  `Minit` char(1) DEFAULT NULL,
  `Lname` varchar(15) NOT NULL,
  `Ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int(11) NOT NULL,
  PRIMARY KEY (`Ssn`),
  KEY `fk_ssn_idx` (`Super_ssn`),
  KEY `fk_dno_idx` (`Dno`),
  KEY `fk_dno_idxx` (`Dno`),
  CONSTRAINT `fk_dnooo` FOREIGN KEY (`Dno`) REFERENCES `department` (`Dnumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('Lisa','G','House','101248268','1975-06-29','12 Maple St Austin TX','F',85000.00,'',7),('Sunil','D','Gupta','110110110','2001-02-01','4312 Bowen Rd Arlington TX','M',80000.00,'111111100',3),('Jared','D','James','111111100','1966-10-10','123 Peachtr Atlanta GA','M',85000.00,'',6),('Jon','C','Jones','111111101','1967-11-14','111 Allgood Atlanta GA','M',45000.00,'111111100',6),('Justin',NULL,'Mark','111111102','1966-01-12','2342 May Atlanta GA','M',40000.00,'111111100',6),('Brad','C','Knight','111111103','1968-02-13','176 Main St Atlanta GA','M',44000.00,'111111100',6),('Cameron','D','Thirteen','111422203','2001-05-04','22 Univ Blvd Arlington TX','F',80000.00,'987987987',4),('Juan','G','Linda','112244668','1965-06-23','1210 Apple St Austin TX','F',55000.00,'',9),('Johny','C','Smith','122344668','1972-01-26','1221 Diploma Dr Arlington TX','M',65000.00,'999999999',9),('John','B','Smith','123456789','1955-01-09','731 Fondren Houston TX','M',30000.00,'333445555',5),('Alex','C','Yu','1614905','1980-10-17','626 Mary St Dallas TX','M',50000.00,'444444400',6),('Debra','T','Hall','202843824','1983-03-11','45 NY St Rochester NY','F',30000.00,'555555501',6),('Richard','T','Koelbel','214370999','1976-04-03','50 Elk St Chicago IL','M',85000.00,'999999999',4),('Evan','E','Wallis','222222200','1958-01-16','134 Pelham Milwaukee WI','M',92000.00,'',7),('Josh','U','Zell','222222201','1954-05-22','266 McGrady Milwaukee WI','M',56000.00,'222222200',7),('Andy','C','Vile','222222202','1944-06-21','1967 Jordan Milwaukee WI','M',53000.00,'222222200',7),('Tom','G','Brand','222222203','1966-12-16','112 Third St Milwaukee WI','M',62500.00,'222222200',7),('Jenny','F','Vos','222222204','1967-11-11','263 Mayberry Milwaukee WI','F',61000.00,'222222201',7),('Chris','A','Carter','222222205','1960-05-21','565 Jordan Milwaukee WI','F',43000.00,'222222201',7),('John','T','Ed','222333444','1981-02-18','4505 West St Rochester NY','M',30000.00,'555555501',6),('Jennifer','A','Joy','223344667','1976-05-19','1204 Main St Miami FL','F',45000.00,'666666613',8),('willie','D','Mary','234234234','1961-12-20','101 South St Arlington TX','F',12000.00,'112244668',9),('Christina','S','Hisel','241625699','1986-07-05','37 Church Row Rochester NY','F',45000.00,'123456789',6),('Erin','A','Maxfield','242535609','1971-12-22','123 Copper St Arlington TX','F',72000.00,'555555500',8),('Wilson','A','Holmes','242916639','1971-06-02','21 South Co Arlington TX','M',72500.00,'555555500',4),('Jake','D','Sheen','245239264','1954-12-25','20 North Co Arlington TX','M',52000.00,'112244668',6),('Megan','G','Jones','254937381','1961-03-02','528 Stone CT Chicago IL','F',62000.00,'666666600',8),('Jisha','A','Carpenter','292740167','1985-05-29','194 Beachdr Miami FL','F',15000.00,'666666613',1),('Kim','C','Grace','333333300','1970-10-23','667 Mills Ave Sacramento CA','F',79000.00,'',6),('Jeff','H','Chase','333333301','1970-01-07','15 Bradbury Sacramento CA','M',44000.00,'333333300',6),('Franklin','T','Wong','333445555','1945-12-08','638 Voss Houston TX','M',40000.00,'888665555',5),('Jose','H','Barbara','343434344','1955-02-28','905 East St Kleen TX','F',35000.00,'444444400',6),('Leonard','H','Moody','349273344','1973-02-09','908 Greek Row Austin TX','M',45000.00,'444444400',7),('Percy','M','Liang','398172999','1991-06-12','14 Maple St Austin TX','M',55000.00,'',9),('Cindy','K','Burklow','432765098','1984-02-23','2015 Neil Ave Miami FL','F',45000.00,'444444402',6),('Gregory','G','Laurie','444212096','1969-09-15','78 Tree Cir Houston TX','M',90000.00,'444444400',7),('Kim','G','Ted','444222666','1968-04-15','3648 Tree Cir Austin TX','M',50000.00,'999999999',9),('Alex','D','Freed','444444400','1950-10-09','4333 Pillsbury Milwaukee WI','M',89000.00,'',7),('Bonnie','S','Bays','444444401','1956-06-19','111 Hollow Milwaukee WI','F',70000.00,'444444400',7),('Alec','C','Best','444444402','1966-06-18','233 Solid Milwaukee WI','M',60000.00,'444444400',7),('Sam','S','Snedden','444444403','1977-07-31','97 Windy St Milwaukee WI','M',48000.00,'444444400',7),('Joyce','A','English','453453453','1962-07-31','5631 Rice Oak Houston TX','F',25000.00,'333445555',5),('John','C','James','555555500','1975-06-30','766 Bloomington Sacramento CA','M',81000.00,'',8),('Nandita','K','Ball','555555501','1969-04-16','222 Howard Sacramento CA','M',62000.00,'555555500',6),('Andrea','M','Sondrini','614370310','1996-12-30','1450 Worthington St Houston TX','F',65000.00,'444444401',5),('Michael','A','Morgan','636669233','1984-05-11','26 Sunset Blvd Miami FL','M',73500.00,'666666612',5),('Bob','B','Bender','666666600','1968-04-17','8794 Garfield Chicago IL','M',96000.00,'',8),('Jill','J','Jarvis','666666601','1966-01-14','6234 Lincoln Chicago IL','F',36000.00,'666666600',9),('Kate','W','King','666666602','1966-04-16','1976 Boone Trace Chicago IL','F',44000.00,'666666600',8),('Lyle','G','Leslie','666666603','1963-06-09','417 Hancock Ave Chicago IL','M',41000.00,'666666601',8),('Billie','J','King','666666604','1960-01-01','556 Washington Chicago IL','F',38000.00,'666666603',8),('Jon','A','Kramer','666666605','1964-08-22','1988 Windy Creek Seattle WA','M',41500.00,'666666603',8),('Ray','H','King','666666606','1949-08-16','213 Delk Road Seattle WA','M',44500.00,'666666604',9),('Gerald','D','Small','666666607','1962-05-15','122 Ball Street Dallas TX','M',29000.00,'666666602',8),('Arnold','A','Head','666666608','1967-05-19','233 Spring St Dallas TX','M',33000.00,'666666602',8),('Helga','C','Pataki','666666609','1969-03-11','101 Holyoke St Dallas TX','F',32000.00,'666666602',8),('Naveen','B','Drew','666666610','1970-05-23','198 Elm St Philadelphia PA','M',34000.00,'666666607',8),('Carl','E','Reedy','666666611','1977-06-21','213 Ball St Philadelphia PA','M',32000.00,'666666610',8),('Sammy','G','Hall','666666612','1970-01-11','433 Main Street Miami FL','M',37000.00,'666666611',8),('Red','A','Bacher','666666613','1980-05-21','196 Elm Street Miami FL','M',33500.00,'666666612',8),('Ramesh','K','Narayan','666884444','1952-09-15','971 Fire Oak Humble TX','M',38000.00,'333445555',5),('Penny','G','Wolowitz','673466642','1974-01-21','42 South Blvd Miami FL','F',17000.00,'222333444',6),('Sheldon','C','Cucuou','849934919','1974-03-22','11 Hollywood Blvd Dallas TX','M',35500.00,'888665555',8),('James','E','Borg','888665555','1927-11-10','450 Stone Houston TX','M',55000.00,'',1),('James','U','Miller','906218888','1978-05-27','13 Fifth St Seattle WA','M',75000.00,'999999999',5),('Joseph','K','Kirkish','913323708','1996-03-04','22 UT Blvd Austin TX','M',95000.00,'',7),('Zach','A','Geller','913353347','1990-08-15','333 PikeWay Seattle WA','M',55000.00,'444444403',6),('Jennifer','S','Wallace','987654321','1931-06-20','291 Berry Bellaire TX','F',43000.00,'888665555',4),('Ahmad','V','Jabbar','987987987','1959-03-29','980 Dallas Houston TX','M',25000.00,'987654321',4),('Alicia','J','Zelaya','999887777','1958-07-19','3321 Castle Spring TX','F',25000.00,'987654321',4),('Roy','C','Lewallen','999999999','1977-03-02','14 Wynncrest Street Dallas TX','M',75500.00,'666666600',8);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `Dnumber` int(11) NOT NULL,
  `Dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`Dnumber`,`Dlocation`),
  CONSTRAINT `fk_dnumber` FOREIGN KEY (`Dnumber`) REFERENCES `department` (`Dnumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,' \'Houston\''),(4,' \'Stafford\''),(5,' \'Bellaire\''),(5,' \'Houston\''),(5,' \'Sugarland\''),(6,' \'Atlanta\''),(6,' \'Sacramento\''),(7,' \'Milwaukee\''),(8,' \'Chicago\''),(8,' \'Dallas\''),(8,' \'Miami\''),(8,' \'Philadephia\''),(8,' \'Seattle\''),(9,' \'Arlington\''),(11,' \'Austin\'');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `Pname` varchar(15) NOT NULL,
  `Pnumber` int(11) NOT NULL,
  `Plocation` varchar(15) DEFAULT NULL,
  `Dnum` int(11) NOT NULL,
  PRIMARY KEY (`Pnumber`),
  UNIQUE KEY `Pname_UNIQUE` (`Pname`),
  KEY `fk_dnum_idx` (`Dnum`),
  CONSTRAINT `fk_dnum` FOREIGN KEY (`Dnum`) REFERENCES `department` (`Dnumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('ProductX',1,'Bellaire',5),('ProductY',2,'Sugarland',5),('ProductZ',3,'Houston',5),('EntityAnnot',4,'Houston',5),('Computerization',10,'Stafford',4),('ConfigMgmt',11,'Atlanta',6),('DataMining',13,'Sacramento',6),('Reorganization',20,'Houston',1),('SearchEngine',22,'Arlington',6),('MotherBoard',29,'Milwaukee',7),('Newbenefits',30,'Stafford',4),('OperatingSystem',61,'Sacramento',6),('DatabaseSystems',62,'Atlanta',6),('Middleware',63,'Atlanta',6),('Advertizing',70,'Arlington',9),('InkjetPrinters',91,'Milwaukee',7),('LaserPrinters',92,'Milwaukee',7),('Human1',95,'Arlington',9);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works_on` (
  `Essn` char(9) NOT NULL,
  `Pno` int(11) NOT NULL,
  `hours` decimal(3,1) NOT NULL,
  PRIMARY KEY (`Essn`,`Pno`),
  KEY `fk_pno_idx` (`Pno`),
  KEY `fk_pnoo_idx` (`Pno`),
  CONSTRAINT `fk_pnoo` FOREIGN KEY (`Pno`) REFERENCES `project` (`Pnumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('001614905',13,18.0),('101248268',29,10.0),('111111100',61,40.0),('111111101',61,40.0),('111111102',61,40.0),('111111103',61,40.0),('111422203',4,45.0),('112244668',95,40.0),('122344668',3,10.0),('122344668',20,10.0),('122344668',30,25.0),('123456789',1,32.5),('123456789',2,7.5),('202843824',11,20.0),('214370999',10,35.0),('222222200',62,40.0),('222222201',62,48.0),('222222202',62,40.0),('222222203',62,40.0),('222222204',62,40.0),('222222205',62,40.0),('222333444',91,10.0),('223344667',63,20.0),('234234234',95,35.0),('241625699',61,4.0),('242535609',62,20.0),('242535609',70,20.0),('242916639',4,5.0),('242916639',11,20.0),('245239264',10,25.0),('245239264',11,25.0),('254937381',70,40.0),('292740167',1,25.0),('333333300',63,40.0),('333333301',63,46.0),('333445555',2,10.0),('333445555',3,10.0),('333445555',10,10.0),('333445555',20,10.0),('343434344',63,40.0),('349273344',29,15.0),('398172999',70,10.0),('432765098',63,25.0),('444212096',63,25.0),('444222666',62,25.0),('444444400',91,40.0),('444444401',91,40.0),('444444402',91,40.0),('444444403',91,40.0),('453453453',1,20.0),('453453453',2,20.0),('555555500',92,40.0),('555555501',92,44.0),('614370310',3,45.0),('636669233',4,11.0),('666666601',91,40.0),('666666603',91,40.0),('666666604',91,40.0),('666666605',92,40.0),('666666606',91,40.0),('666666607',61,40.0),('666666608',62,40.0),('666666609',63,40.0),('666666610',61,40.0),('666666611',61,40.0),('666666612',61,40.0),('666666613',61,30.0),('666666613',62,10.0),('666666613',63,10.0),('666884444',3,40.0),('673466642',22,4.0),('849934919',95,23.0),('888665555',20,5.0),('906218888',29,15.0),('913323708',92,33.0),('913353347',22,30.0),('987654321',20,15.0),('987654321',30,20.0),('987987987',10,35.0),('987987987',30,5.0),('999887777',10,10.0),('999887777',30,30.0),('999999999',1,2.0),('999999999',2,2.0),('999999999',3,4.0),('999999999',10,4.0),('999999999',20,4.0),('999999999',30,4.0),('999999999',61,4.0),('999999999',62,4.0),('999999999',63,4.0),('999999999',70,2.0),('999999999',91,2.0),('999999999',92,1.0),('999999999',95,3.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-08 18:13:10
