-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`students` ;

CREATE TABLE IF NOT EXISTS `university`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(20) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`degrees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`degrees` ;

CREATE TABLE IF NOT EXISTS `university`.`degrees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(45) NOT NULL,
  `degree` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`courses` ;

CREATE TABLE IF NOT EXISTS `university`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `course_title` VARCHAR(45) NOT NULL,
  `course_code` CHAR(4) NOT NULL,
  `course_num` CHAR(4) NOT NULL,
  `credits` INT NOT NULL,
  `degree_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_courses_degrees1_idx` (`degree_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_degrees1`
    FOREIGN KEY (`degree_id`)
    REFERENCES `university`.`degrees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`teachers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`teachers` ;

CREATE TABLE IF NOT EXISTS `university`.`teachers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`sections` ;

CREATE TABLE IF NOT EXISTS `university`.`sections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` INT NOT NULL,
  `term` VARCHAR(6) NOT NULL,
  `section` INT NOT NULL,
  `capacity` VARCHAR(45) NOT NULL,
  `course_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sections_courses_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_sections_teachers1_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_teachers1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `university`.`teachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  INDEX `fk_Enrollment_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Enrollment_sections1_idx` (`section_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Enrollment_students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Enrollment_sections1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
