-- MySQL Script generated by MySQL Workbench
-- Fri May 22 17:12:40 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema desafiomirante
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema desafiomirante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `desafiomirante` DEFAULT CHARACTER SET utf8 ;
USE `desafiomirante` ;

-- -----------------------------------------------------
-- Table `desafiomirante`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desafiomirante`.`profile` ;

CREATE TABLE IF NOT EXISTS `desafiomirante`.`profile` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafiomirante`.`app_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desafiomirante`.`app_user` ;

CREATE TABLE IF NOT EXISTS `desafiomirante`.`app_user` (
  `id` INT NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_app_user_profile_idx` (`profile_id` ASC),
  CONSTRAINT `fk_app_user_profile`
    FOREIGN KEY (`profile_id`)
    REFERENCES `desafiomirante`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafiomirante`.`operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desafiomirante`.`operator` ;

CREATE TABLE IF NOT EXISTS `desafiomirante`.`operator` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `app_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_operator_app_user1_idx` (`app_user_id` ASC),
  CONSTRAINT `fk_operator_app_user1`
    FOREIGN KEY (`app_user_id`)
    REFERENCES `desafiomirante`.`app_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafiomirante`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desafiomirante`.`person` ;

CREATE TABLE IF NOT EXISTS `desafiomirante`.`person` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `doc_number` VARCHAR(14) NOT NULL,
  `birth_date` DATETIME NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `operator_id` INT NOT NULL,
  `type` INT NULL COMMENT '1. Pessoa Física\n2. Pessoa Jurídica',
  `mother_name` VARCHAR(100) NULL,
  `father_name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_person_app_user1_idx` (`operator_id` ASC),
  CONSTRAINT `fk_person_app_user1`
    FOREIGN KEY (`operator_id`)
    REFERENCES `desafiomirante`.`app_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafiomirante`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `desafiomirante`.`phone` ;

CREATE TABLE IF NOT EXISTS `desafiomirante`.`phone` (
  `id` INT NOT NULL,
  `ddd` VARCHAR(3) NOT NULL,
  `number` VARCHAR(10) NOT NULL,
  `type` INT NOT NULL COMMENT '1. Celular\n2. Fixo\n3. Comercial',
  `creation_date` DATETIME NOT NULL,
  `app_user_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_phone_app_user1_idx` (`app_user_id` ASC),
  INDEX `fk_phone_person1_idx` (`person_id` ASC),
  CONSTRAINT `fk_phone_app_user1`
    FOREIGN KEY (`app_user_id`)
    REFERENCES `desafiomirante`.`app_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `desafiomirante`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `desafiomirante`.`profile` (`id`, `title`) VALUES ('1', 'Administrador');
INSERT INTO `desafiomirante`.`profile` (`id`, `title`) VALUES ('2', 'Gerente');
INSERT INTO `desafiomirante`.`app_user` (`id`, `login`, `password`, `profile_id`) VALUES ('1', 'mirante01', '$2a$10$7kbXCnAWrx25BNSd/Af2Ge8cYGWFjj0Sx7buRd1A5t7gn/4soUtiO', '1');
INSERT INTO `desafiomirante`.`app_user` (`id`, `login`, `password`, `profile_id`) VALUES ('2', 'fmarques899', '$2a$10$nGtfJasSDyit5wVC7Mo4MuXhKEi4.rENLY5ZEOzdWCPY/y6FqnbGi', '1');

