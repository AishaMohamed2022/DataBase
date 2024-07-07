-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema lifemakers
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `lifemakers` ;

-- -----------------------------------------------------
-- Schema lifemakers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lifemakers` DEFAULT CHARACTER SET utf8 ;
USE `lifemakers` ;

-- -----------------------------------------------------
-- Table `lifemakers`.`neadypeaple`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`neadypeaple` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`neadypeaple` (
  `state` INT NOT NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`state`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`person` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`person` (
  `ssn` VARCHAR(14) NOT NULL,
  `gender` VARCHAR(4) NULL,
  `phone` VARCHAR(20) NULL,
  `Bd` DATE NULL,
  `city` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`ssn`),
  UNIQUE INDEX `Pssn_UNIQUE` (`ssn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Donations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Donations` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Donations` (
  `ID` INT NOT NULL,
  `class` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `don-id_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Needypeople`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Needypeople` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Needypeople` (
  `person_ssn` VARCHAR(14) NOT NULL,
  `state` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `Donations_ID` INT NULL,
  INDEX `fk_Needy people_person1_idx` (`person_ssn` ASC),
  PRIMARY KEY (`person_ssn`),
  INDEX `fk_Needy people_Donations1_idx` (`Donations_ID` ASC),
  CONSTRAINT `fk_Needy people_person1`
    FOREIGN KEY (`person_ssn`)
    REFERENCES `lifemakers`.`person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Needy people_Donations1`
    FOREIGN KEY (`Donations_ID`)
    REFERENCES `lifemakers`.`Donations` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Folders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Folders` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Folders` (
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Campaign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Campaign` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Campaign` (
  `mang_ssn` VARCHAR(14) NOT NULL,
  `time` VARCHAR(45) NULL,
  `duration` VARCHAR(20) NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`, `mang_ssn`),
  INDEX `fk_Campaign_Volunteer1_idx` (`mang_ssn` ASC),
  CONSTRAINT `fk_Campaign_Volunteer1`
    FOREIGN KEY (`mang_ssn`)
    REFERENCES `lifemakers`.`Volunteer` (`Person_ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Locality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Locality` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Locality` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `Lname_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Volunteer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Volunteer` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Volunteer` (
  `Person_ssn` VARCHAR(14) NULL,
  `Locality_name` VARCHAR(45) NOT NULL,
  `Folders_Fname` VARCHAR(45) NOT NULL,
  `Campaign_name` VARCHAR(45) NOT NULL,
  INDEX `fk_Volunteer_Folders1_idx` (`Folders_Fname` ASC),
  INDEX `fk_Volunteer_Campaign1_idx` (`Campaign_name` ASC),
  INDEX `fk_Volunteer_Locality1_idx` (`Locality_name` ASC),
  INDEX `fk_Volunteer_Person1_idx` (`Person_ssn` ASC),
  PRIMARY KEY (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`),
  CONSTRAINT `work on`
    FOREIGN KEY (`Folders_Fname`)
    REFERENCES `lifemakers`.`Folders` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mange`
    FOREIGN KEY (`Campaign_name`)
    REFERENCES `lifemakers`.`Campaign` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `work in`
    FOREIGN KEY (`Locality_name`)
    REFERENCES `lifemakers`.`Locality` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Volunteer_Person1`
    FOREIGN KEY (`Person_ssn`)
    REFERENCES `lifemakers`.`person` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Adminstrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Adminstrator` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Adminstrator` (
  `Person_ssn` VARCHAR(14) NULL,
  `salary` FLOAT NULL,
  `Locality_name` VARCHAR(45) NOT NULL,
  INDEX `fk_Adminstrator_Locality1_idx` (`Locality_name` ASC),
  INDEX `fk_Adminstrator_Person1_idx` (`Person_ssn` ASC),
  PRIMARY KEY (`Person_ssn`),
  CONSTRAINT `fk_Adminstrator_Locality1`
    FOREIGN KEY (`Locality_name`)
    REFERENCES `lifemakers`.`Locality` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Adminstrator_Person1`
    FOREIGN KEY (`Person_ssn`)
    REFERENCES `lifemakers`.`person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`money`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`money` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`money` (
  `Donations_ID` INT NOT NULL,
  `amount` INT NOT NULL,
  INDEX `fk_money_Donations1_idx` (`Donations_ID` ASC),
  PRIMARY KEY (`Donations_ID`, `amount`),
  CONSTRAINT `fk_money_Donations1`
    FOREIGN KEY (`Donations_ID`)
    REFERENCES `lifemakers`.`Donations` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Material` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Material` (
  `Donations_ID` INT NOT NULL,
  `amount` INT NOT NULL,
  INDEX `fk_Material_Donations1_idx` (`Donations_ID` ASC),
  PRIMARY KEY (`Donations_ID`, `amount`),
  CONSTRAINT `fk_Material_Donations1`
    FOREIGN KEY (`Donations_ID`)
    REFERENCES `lifemakers`.`Donations` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`locality_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`locality_location` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`locality_location` (
  `L_name` VARCHAR(45) NOT NULL,
  `L_location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`L_name`, `L_location`),
  CONSTRAINT `L_name`
    FOREIGN KEY (`L_name`)
    REFERENCES `lifemakers`.`Locality` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`Board_of_trusts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`Board_of_trusts` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`Board_of_trusts` (
  `Person_ssn` VARCHAR(14) NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`Person_ssn`),
  INDEX `fk_Board of trusts_Person1_idx` (`Person_ssn` ASC),
  CONSTRAINT `fk_Board of trusts_Person1`
    FOREIGN KEY (`Person_ssn`)
    REFERENCES `lifemakers`.`person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`raise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`raise` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`raise` (
  `Donations_ID` INT NULL,
  `Campaign_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Donations_ID`, `Campaign_name`),
  INDEX `fk_Donations_has_Campaign_Campaign1_idx` (`Campaign_name` ASC),
  INDEX `fk_Donations_has_Campaign_Donations1_idx` (`Donations_ID` ASC),
  CONSTRAINT `fk_Donations_has_Campaign_Donations1`
    FOREIGN KEY (`Donations_ID`)
    REFERENCES `lifemakers`.`Donations` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Donations_has_Campaign_Campaign1`
    FOREIGN KEY (`Campaign_name`)
    REFERENCES `lifemakers`.`Campaign` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lifemakers`.`accept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lifemakers`.`accept` ;

CREATE TABLE IF NOT EXISTS `lifemakers`.`accept` (
  `Donations_ID` INT NOT NULL,
  `V_ssn` VARCHAR(14) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`Donations_ID`, `V_ssn`, `date`),
  INDEX `fk_Donations_has_Volunteer_Volunteer1_idx` (`V_ssn` ASC),
  INDEX `fk_Donations_has_Volunteer_Donations1_idx` (`Donations_ID` ASC),
  CONSTRAINT `fk_Donations_has_Volunteer_Donations1`
    FOREIGN KEY (`Donations_ID`)
    REFERENCES `lifemakers`.`Donations` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Donations_has_Volunteer_Volunteer1`
    FOREIGN KEY (`V_ssn`)
    REFERENCES `lifemakers`.`Volunteer` (`Person_ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`person`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('12345678 ', 'M', '010666667 ', '1980-11-12', 'Ashmoun  ', 'Abul Hadid emad ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('32345678 ', 'M', '010666766', '1990-03-18', 'el-Bajour     ', 'Emad Abdel Alim  ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('42345678   ', 'M', '010667666  ', '1993-04-19', 'Tala   ', 'Rabee Mohammed    ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('52345678  ', 'M', '010676666', '1991-10-22', ' el shohada  ', 'Mohamed ayman ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('62345678 ', 'M', '010766666', '1989-12-04', 'Berket Al-Sabaa', 'Muhammad Mukhtar ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('26345678 ', 'M', '010777776 ', '1985-04-06', 'tala   ', 'Ramadan Fahim      ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('72345678 ', 'M', '010777767', '1986-03-17', 'el-Sadat   ', 'Hamada Muhammad    ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('92345678', 'M', '010776777', '1989-07-19 ', 'Menouf   ', 'Ibrahim Mohamed          ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('21345678 ', 'M', '010767777 ', '1986-04-20 ', 'Menouf    ', 'Mohammed Abu Hadid   ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('31345678 ', 'M', '010677777 ', '1984-02-20', 'Shebin Al-Koum    ', 'Jalal Abdul Salam         ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('41345678', 'M', '010555554', '1955-07-15 ', 'cairo', 'Mohsen Al-Nomani Hafez ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('51345678', 'M', '010555545', '1970-06-05 ', 'giza', 'Mohamed Ahmed Yahya');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('61345678 ', 'M', '010555455', '1964-12-08 ', 'cairo', 'Osama Abdel Rahman Hussein ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('71345678 ', 'M', '010554555', '1965-03-30', 'cairo', 'Ahmed Gamal El Din Musa ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('81345678 ', 'F', '010545555', '1974-07-13 ', 'dakahlia', 'Noha Ali Ahmed El Desouky');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('91345678 ', 'M', '010455555', '1980-10-28', 'cairo', 'Omar Muhammad Al-Sunaiti');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('11245678 ', 'M', '010444445', '1989-01-21 ', 'cairo', 'Haitham Nasser Darwish ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('21245678 ', 'M', '010444454', '1958-09-16 ', 'cairo', 'Ahmed Gamal El Din  Musa ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('31245678 ', 'M', '010444544', '1998-04-12', 'cairo', 'Mohamed Faris ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('41245678 ', 'F', '010445444', '1999-05-24 ', 'Menoufia ', 'Yemeni Rifaat ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('51245678 ', 'M', '010454444', '1999-11-03 ', 'menouf ', 'Ahmed Bahey ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('61245678 ', 'M', '010544444', '1997-06-12 ', 'Giza ', 'Mahmoud Abed Wahab ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('71245678 ', 'F', '010444443', '1998-02-13 ', 'Bagour', 'Rofida Muhammad ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('81245678 ', 'M', '010444434', '1996-04-02 ', 'el sharkeya ', 'Saif Tharwat ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('91245678', 'M', '010444344', '2000-09-02', 'Sohag ', 'Mahmoud Abdullah ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('13245678 ', 'F', '010443444', '1997-08-22', 'Minya ', 'Duha Ahmed ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('23245678 ', 'M', '010434444', '1996-11-21 ', 'Minya ', 'Mahmoud Khaled ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('33245678 ', 'M', '010344444', '1998-03-18 ', 'Minya ', 'Walid Galal ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('43245678 ', 'F', '010333334', '2000-06-16 ', 'Minya', 'Areej Magdy ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('53245678 ', 'M', '010333343', '1998-01-20 ', 'Samalout ', 'Wael Taha ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('63245678 ', 'F', '010333433', '1997-08-14', 'Dakahlia ', 'Sahar Ahmed ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('73245678', 'M', '010334333', '1999-09-03 ', 'Mansoura – Dakahlia ', 'Islam Al-Saeed ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('83245678', 'M', '010343333', '1996-05-09 ', 'Beheira ', 'Mahmoud Beltaji ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('93245678 ', 'F', '010433333', '2005-12-12', 'Tanta ', 'Doaa Al-Najjar ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('11235678 ', 'M', '010333332', '2004-10-13 ', 'Gharbia ', 'Mustafa Kashtina ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('21235678 ', 'F', '010333323', '2005-02-10 ', 'el sharkeya ', 'Eman Muhammad ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('31235678 ', 'M', '010333233', '2004-10-22 ', 'Zagazig ', 'Seif Tharwat ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('41235678 ', 'M', '010332333', '2003-11-02 ', 'Zagazig ', 'Ahmed Riba ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('51235678 ', 'F', '010323333', '2002-03-19', 'Alexandria ', 'Baraa Mohamed ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('61235678 ', 'F', '010233333', '2002-10-25 ', 'Kafr Saqr – sharkeya ', 'Aisha Muhammad ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('71235678 ', 'F', '010222222', '2002-07-23', 'Abu Hammad – sharkeya', 'Reem Amr ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('81235678 ', 'F', '010222221', '2001-04-28 ', 'Fayoum ', 'Yasmine Said ');
INSERT INTO `lifemakers`.`person` (`ssn`, `gender`, `phone`, `Bd`, `city`, `name`) VALUES ('91235678 ', 'F', '010222212', '2001-08-27 ', 'fayoUm ', 'Shrouk wazer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Donations`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Donations` (`ID`, `class`) VALUES (300, 'صدقة');
INSERT INTO `lifemakers`.`Donations` (`ID`, `class`) VALUES (100, 'زكاة');
INSERT INTO `lifemakers`.`Donations` (`ID`, `class`) VALUES (200, 'صدقة جارية');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Needypeople`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('12345678 ', 'work', 'geres-  Ashmoun  ', 200);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('32345678 ', 'work', 'kafr el dawar -  el-Bajour     ', 100);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('52345678  ', 'clothes ', 'el erakeya-     el shohada  ', 300);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('62345678 ', 'operator  ', 'horen -   Berket Al-Sabaa', 300);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('21345678 ', 'clothes', 'tta-   Menouf    ', 300);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('31345678 ', 'operation', 'gamal abdel naser street-  Shebin Al-Koum    ', 300);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('72345678 ', 'operation ', 'el akhmas- el-Sadat   ', 300);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('42345678 ', 'work', 'Kamshesh,Tala', 200);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('26345678 ', 'work ', 'kafr el sadat  -  tala   ', 100);
INSERT INTO `lifemakers`.`Needypeople` (`person_ssn`, `state`, `address`, `Donations_ID`) VALUES ('92345678', 'work', 'manshaat sultan -  Menouf   ', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Folders`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Folders` (`name`, `description`) VALUES ('Pharmacy', 'in every branch of the foundation there a room contain medicine getted free to the neefy people they need it');
INSERT INTO `lifemakers`.`Folders` (`name`, `description`) VALUES ('Research', 'here a team responsible for looking for needy people in the different villages and make researches about their state');
INSERT INTO `lifemakers`.`Folders` (`name`, `description`) VALUES ('Volunteer management', ': its an hr team which responsible for making the interview and care about volunteers');
INSERT INTO `lifemakers`.`Folders` (`name`, `description`) VALUES ('Exhibitions', 'a team responsible for collect the donated clothes and sort it and make exhibitions to buy it cheap');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Campaign`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Campaign` (`mang_ssn`, `time`, `duration`, `name`) VALUES ('31245678 ', 'رمضان ', '1 شهر', 'رزق حلال ');
INSERT INTO `lifemakers`.`Campaign` (`mang_ssn`, `time`, `duration`, `name`) VALUES ('81245678 ', 'الشتاء ', '3 شهر', 'دفا ');
INSERT INTO `lifemakers`.`Campaign` (`mang_ssn`, `time`, `duration`, `name`) VALUES ('23245678 ', 'الاجازة', '2 شهر', 'اتجنن ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Locality`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Menofia ');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Cairo');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Giza ');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Dakahlia ');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Sharkia');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Al behera');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Alexandria');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Fayom ');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Al gharbia ');
INSERT INTO `lifemakers`.`Locality` (`name`) VALUES ('Sohag ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Volunteer`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('31245678 ', 'Cairo ', 'Volunteer management', 'رزق حلال ');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('31245678 ', 'Cairo ', 'Volunteer management', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('31245678 ', 'Cairo ', 'Volunteer management', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('41245678 ', 'Menoufia ', 'Exhibitions', 'رزق حلال ');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('41245678 ', 'Menoufia ', 'Exhibitions', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('71245678 ', 'Menoufia ', 'Research', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('81245678 ', 'Sharkia', 'PHARMACY', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('81245678 ', 'Sharkia', 'PHARMACY', 'رزق حلال ');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('81245678 ', 'Sharkia', 'PHARMACY', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('23245678 ', 'Minya ', 'Research', 'رزق حلال ');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('23245678 ', 'Minya ', 'Research', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('33245678 ', 'Minya ', 'Volunteer management', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('33245678 ', 'Minya ', 'Volunteer management', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('43245678 ', 'Minya ', 'PHARMACY', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('43245678 ', 'Minya ', 'PHARMACY', 'رزق حلال ');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('43245678 ', 'Minya ', 'PHARMACY', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('53245678 ', 'Minya ', 'Exhibitions', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('53245678 ', 'Minya ', 'Exhibitions', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('63245678 ', 'Dakahlia ', 'Research', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('63245678 ', 'Dakahlia ', 'Research', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('93245678 ', 'Gharbia ', 'Volunteer management', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('93245678 ', 'Gharbia ', 'Volunteer management', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('31235678 ', 'Sharkia', 'Research', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('31235678 ', 'Sharkia', 'Research', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('41235678 ', 'Sharkia', 'Exhibitions', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('41235678 ', 'Sharkia', 'Exhibitions', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('61235678 ', 'Sharkia', 'Volunteer management', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('61235678 ', 'Sharkia', 'Volunteer management', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('61235678 ', 'Sharkia', 'Volunteer management', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('71235678 ', 'Sharkia', 'pharmacy', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('71235678 ', 'Sharkia', 'pharmacy', 'رزق حلال');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('81235678 ', 'Fayoum ', 'Exhibitions', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('81235678 ', 'Fayoum ', 'Exhibitions', 'اتجنن');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('91235678 ', 'Fayoum ', 'research ', 'دفا');
INSERT INTO `lifemakers`.`Volunteer` (`Person_ssn`, `Locality_name`, `Folders_Fname`, `Campaign_name`) VALUES ('91235678 ', 'Fayoum ', 'research ', 'رزق حلال');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Adminstrator`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('91245678', 3000, 'Sohag ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('51245678 ', 5000, 'menoufia');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('73245678', 3000, 'Dakahlia ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('83245678', 3000, 'Beheira ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('21235678 ', 4000, 'Sharkia');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('51235678 ', 3000, 'Alexandria ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('91235678 ', 3000, 'fayom ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('61245678 ', 5000, 'Giza ');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('31245678 ', 6000, 'cairo');
INSERT INTO `lifemakers`.`Adminstrator` (`Person_ssn`, `salary`, `Locality_name`) VALUES ('13245678 ', 3000, 'Minya ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`money`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (100, 1000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (100, 2000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (100, 3500);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (100, 7000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (100, 3000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (200, 10000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (200, 3000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (200, 4000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (300, 2500);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (300, 2000);
INSERT INTO `lifemakers`.`money` (`Donations_ID`, `amount`) VALUES (300, 3000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Material`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Material` (`Donations_ID`, `amount`) VALUES (200 , 3 );
INSERT INTO `lifemakers`.`Material` (`Donations_ID`, `amount`) VALUES (300, 15 );
INSERT INTO `lifemakers`.`Material` (`Donations_ID`, `amount`) VALUES (300, 20 );
INSERT INTO `lifemakers`.`Material` (`Donations_ID`, `amount`) VALUES (300, 14 );

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`locality_location`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Menofia ', 'shebin el kom');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Menofia ', 'ashmoun');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Menofia ', 'menoufia university');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Cairo', 'maadi ');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Giza ', 'dokki');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Giza ', 'embaba');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Dakahlia ', 'el mansoura');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Sharkia', 'zagazig ');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Sharkia', 'Belbeis');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Sharkia', '10 th ramadan ');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Al behera ', 'damanhor');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Alexandria ', 'alexandria');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Fayom', 'fayom  ');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('Al garbia ', 'tanta');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('El minya ', 'El miya');
INSERT INTO `lifemakers`.`locality_location` (`L_name`, `L_location`) VALUES ('red sea', 'el kosser');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`Board_of_trusts`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('41345678 ', 'Chairman of the Board of Trustees');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('51345678', 'vice president');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('61345678 ', 'cashier');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('71345678 ', 'member');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('81345678 ', 'member');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('91345678 ', 'member');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('11245678 ', 'member');
INSERT INTO `lifemakers`.`Board_of_trusts` (`Person_ssn`, `type`) VALUES ('21245678 ', 'member');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`raise`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`raise` (`Donations_ID`, `Campaign_name`) VALUES (100, 'رزق حلال ');
INSERT INTO `lifemakers`.`raise` (`Donations_ID`, `Campaign_name`) VALUES (300, 'دفا ');
INSERT INTO `lifemakers`.`raise` (`Donations_ID`, `Campaign_name`) VALUES (200, 'اتجنن');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lifemakers`.`accept`
-- -----------------------------------------------------
START TRANSACTION;
USE `lifemakers`;
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (100 , '91235678 ', '2021-05-01');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (100, '71235678 ', '2021-05-13');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (100, '91235678 ', '2021-05-05');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (100 , '61235678 ', '2021-04-26');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (100, '63245678 ', '2021-11-10');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (200 , '43245678 ', '2021-06-11');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (200, '81245678', '2021-06-23');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (200, '71245678 ', '2021-07-28');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (300, '41245678 ', '2021-09-09');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (300, '81245678 ', '2021-10-18');
INSERT INTO `lifemakers`.`accept` (`Donations_ID`, `V_ssn`, `date`) VALUES (300, '23245678 ', '2021-04-19');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
