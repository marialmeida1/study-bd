-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`area` (
  `sigla` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `superarea` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`sigla`),
  INDEX `fk_area_area1_idx` (`superarea` ASC) VISIBLE,
  CONSTRAINT `fk_area_area1`
    FOREIGN KEY (`superarea`)
    REFERENCES `mydb`.`area` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `sigla` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `horas` TIME NULL,
  `custo` DECIMAL(10,2) NULL,
  `area` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`sigla`),
  INDEX `fk_curso_area_idx` (`area` ASC) VISIBLE,
  CONSTRAINT `fk_curso_area`
    FOREIGN KEY (`area`)
    REFERENCES `mydb`.`area` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`modulo` (
  `sigla` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `curso` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`sigla`),
  INDEX `fk_modulo_curso1_idx` (`curso` ASC) VISIBLE,
  CONSTRAINT `fk_modulo_curso1`
    FOREIGN KEY (`curso`)
    REFERENCES `mydb`.`curso` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`topico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`topico` (
  `sigla` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `horas` TIME NULL,
  `modulo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`sigla`),
  INDEX `fk_topico_modulo1_idx` (`modulo` ASC) VISIBLE,
  CONSTRAINT `fk_topico_modulo1`
    FOREIGN KEY (`modulo`)
    REFERENCES `mydb`.`modulo` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `sobrenome` VARCHAR(255) NULL,
  `sexo` CHAR(1) NULL,
  `datanasc` DATE NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor` (
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `curso` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`cpf`),
  INDEX `fk_professor_curso1_idx` (`curso` ASC) VISIBLE,
  CONSTRAINT `fk_professor_curso1`
    FOREIGN KEY (`curso`)
    REFERENCES `mydb`.`curso` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`matricula` (
  `curso` VARCHAR(10) NOT NULL,
  `aluno` VARCHAR(11) NOT NULL,
  `data` TIME NULL,
  `pago` TINYINT NULL,
  PRIMARY KEY (`curso`, `aluno`),
  INDEX `fk_curso_has_aluno_aluno1_idx` (`aluno` ASC) VISIBLE,
  INDEX `fk_curso_has_aluno_curso1_idx` (`curso` ASC) VISIBLE,
  CONSTRAINT `fk_curso_has_aluno_curso1`
    FOREIGN KEY (`curso`)
    REFERENCES `mydb`.`curso` (`sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_has_aluno_aluno1`
    FOREIGN KEY (`aluno`)
    REFERENCES `mydb`.`aluno` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
