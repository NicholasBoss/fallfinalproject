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
-- Table `university`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`role` ;

CREATE TABLE IF NOT EXISTS `university`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`person` ;

CREATE TABLE IF NOT EXISTS `university`.`person` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `person_fname` VARCHAR(45) NOT NULL,
  `person_lname` VARCHAR(45) NOT NULL,
  `person_gender` VARCHAR(20) NULL,
  `person_city` VARCHAR(45) NULL,
  `person_state` CHAR(2) NULL,
  `person_birthdate` DATE NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(45) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`degree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`degree` ;

CREATE TABLE IF NOT EXISTS `university`.`degree` (
  `degree_id` INT NOT NULL AUTO_INCREMENT,
  `degree` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`degree_id`),
  INDEX `fk_degree_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_degree_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_title` VARCHAR(45) NOT NULL,
  `course_code` CHAR(4) NOT NULL,
  `course_num` CHAR(4) NOT NULL,
  `course_credits` INT NOT NULL,
  `degree_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_degree1_idx` (`degree_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_degree1`
    FOREIGN KEY (`degree_id`)
    REFERENCES `university`.`degree` (`degree_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_semester` VARCHAR(45) NOT NULL,
  `term_year` INT NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section` INT NOT NULL,
  `section_capacity` VARCHAR(45) NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_enrollment_role1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_enrollment_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_enrollment_section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `university`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `university`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
























-- PART 2 INSERT THE STINKING ROWS!!!!!!!!
-- CREATE DEPARTMENTS
USE university;

INSERT INTO department (department) VALUES 
  ('Computer Science and Engineering')
, ('Mathematics');


-- CREATE DEGREES
INSERT INTO degree (degree, department_id) VALUES
  ('Computer Science', (SELECT department_id FROM department WHERE department = 'Computer Science and Engineering'))
, ('Web Design and Development', (SELECT department_id FROM department WHERE department = 'Computer Science and Engineering'))
, ('Data Science', (SELECT department_id FROM department WHERE department = 'Mathematics'));

-- CREATE COURSES
INSERT INTO course (course_title, course_code, course_num, course_credits, degree_id) VALUES
  ('Intro to Computing', 'CSE', '100', 1, (SELECT degree_id FROM degree WHERE degree = 'Computer Science'))
, ('Web Fundamentals', 'WDD', '130', 2, (SELECT degree_id FROM degree WHERE degree = 'Web Design and Development'))
, ('Biostatistics', 'MATH', '221B', 3, (SELECT degree_id FROM degree WHERE degree = 'Data Science'))
, ('Applied Calculus for Data Analysis', 'MATH', '119', 4, (SELECT degree_id FROM degree WHERE degree = 'Data Science'));

-- CREATE TERMS
INSERT INTO term (term_semester, term_year) VALUES
  ('Fall', 2024)
, ('Winter', 2024)
, ('Fall', 2025)
, ('Winter', 2025);

-- CREATE SECTIONS
INSERT INTO section (section, section_capacity, course_id, term_id) VALUES
  (1, 35, 
    (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = '100'),
    (SELECT term_id FROM term WHERE term_semester = 'Fall' AND term_year = 2024))
, (1, 30, 
    (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = '130'),
    (SELECT term_id FROM term WHERE term_semester = 'Fall' AND term_year = 2024))
, (2, 30, 
    (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = '130'),
    (SELECT term_id FROM term WHERE term_semester = 'Fall' AND term_year = 2024))
, (1, 40, 
    (SELECT course_id FROM course WHERE course_code = 'MATH' AND course_num = '221B'),
    (SELECT term_id FROM term WHERE term_semester = 'Fall' AND term_year = 2024))
, (1, 40, 
    (SELECT course_id FROM course WHERE course_code = 'MATH' AND course_num = '119'),
    (SELECT term_id FROM term WHERE term_semester = 'Fall' AND term_year = 2024))
, (2, 35, 
    (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = '100'),
    (SELECT term_id FROM term WHERE term_semester = 'Winter' AND term_year = 2025))
, (3, 35, 
    (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = '100'),
    (SELECT term_id FROM term WHERE term_semester = 'Winter' AND term_year = 2025))
, (1, 30, 
    (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = '130'),
    (SELECT term_id FROM term WHERE term_semester = 'Winter' AND term_year = 2025))
, (2, 30, 
    (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = '130'),
    (SELECT term_id FROM term WHERE term_semester = 'Winter' AND term_year = 2025))
, (1, 40, 
    (SELECT course_id FROM course WHERE course_code = 'MATH' AND course_num = '119'),
    (SELECT term_id FROM term WHERE term_semester = 'Winter' AND term_year = 2025));

-- CREATE ROLES
INSERT INTO role (role) VALUES
  ('Teacher')
, ('Student')
, ('TA');

-- CREATE PEOPLE
INSERT INTO person (person_fname, person_lname) VALUES
  ('John', 'Parker')
, ('Reed', 'Nielsen')
, ('George', 'Martin')
, ('Michael', 'Duncan');

INSERT INTO person (person_fname, person_lname, person_gender, person_city, person_state, person_birthdate) VALUES
  ('Marshall', 'Spence', 'M', 'Garland', 'TX', '2000-06-23')
, ('Maria', 'Clark', 'F', 'Akron', 'OH', '2002-01-25')
, ('Tracy', 'Woodward', 'F', 'Newark', 'NJ', '2002-10-04')
, ('Erick', 'Woodward', 'M', 'Newark', 'NJ', '1998-08-05')
, ('Lillie', 'Summers', 'F', 'Reno', 'NV', '1999-11-05')
, ('Nellie', 'Marquez', 'F', 'Atlanta', 'GA', '2001-06-25')
, ('Allen', 'Stokes', 'M', 'Bozeman', 'MT', '2004-09-16')
, ('Josh', 'Rollins', 'M', 'Decatur', 'TN', '1998-11-28')
, ('Janine', 'Bowers', 'F', 'Rexburg', 'ID', '2004-06-23')
, ('Kerri', 'Shah', 'F', 'Mesa', 'AZ', '2003-04-05');


-- CREATE ENROLLMENTS
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'John')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'John')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'John')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 3)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Reed')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Reed')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Reed')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Reed')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'George')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 221B'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Michael')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 119'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Michael')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 119'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Teacher')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Marshall')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Marshall')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Maria')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 221B'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Tracy')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 221B'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Erick')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 119'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Lillie')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 221B'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Lillie')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 119'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'TA')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Nellie')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 3)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Allen')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Allen')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'TA')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Allen')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'MATH 119'
   AND   section = 1)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Josh')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Janine')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'WDD 130'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Student')
);
INSERT INTO enrollment (person_id, section_id, role_id) VALUES
( (SELECT person_id FROM person WHERE person_fname = 'Kerri')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_semester, ' ', term_year) = 'Winter 2025'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 100'
   AND   section = 2)
, (SELECT role_id FROM role WHERE role = 'Student')
);















































USE university
-- part 3 - the last 10 queries
-- ----------------------------------------------------------------------
-- Query 1: Students, and their birthdays, of students born in June. 
--          Format the date to look like it is shown in the result set. 
-- ----------------------------------------------------------------------
SELECT 
	person_fname AS "first_name"
, 	person_lname AS "last_name"
, 	DATE_FORMAT(person_birthdate, '%M %d, %Y') AS "June Birthdays"
FROM person
WHERE person_birthdate LIKE "%-06-%";

-- ----------------------------------------------------------------------------
-- Query 2: Student's age in years and days as of Mar. 10, 2019.  
--          Sorted from oldest to youngest. No duplicates.  
--          (You can assume a 365 day year and ignore leap day.) 
--          Hint: Use the mod function to calculate the days left over 
--                after dividing by full years. 
--          The 5th column is just the 3rd and 4th column combined with labels.
-- ----------------------------------------------------------------------------
SELECT DISTINCT
	person_lname AS "last_name"
, 	person_fname AS "first_name"
,	person_birthdate AS "dob"
,	FLOOR(DATEDIFF('2019-03-10', person_birthdate) / 365) AS "Years"
,	MOD(DATEDIFF('2019-03-10', person_birthdate), 365) AS "Days"
,	CONCAT(
        FLOOR(DATEDIFF('2019-03-10', person_birthdate) / 365.25), ' - Yrs, ',
        DATEDIFF('2019-03-10', person_birthdate) % 365, ' - Days'
    ) AS "Years and Days"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
WHERE role = "Student"
ORDER BY person_birthdate;

-- ----------------------------------------------------------------------
-- Query 3: Who is enrolled in Web Fundamentals?
--          No Duplicates.
--          Order by person_type.
-- ----------------------------------------------------------------------
SELECT DISTINCT
	person_fname AS "first_name"
, 	person_lname AS "last_name"
,	role AS "person_type"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN course c ON s.course_id = c.course_id
WHERE course_title LIKE "%Web Fundamentals%"
ORDER BY role;

-- ----------------------------------------------------------------------
-- Query 4: Find the TAs. What are their names? 
--          Confirm that they are in fact TAs, 
--          and find what course they TA for.
-- ----------------------------------------------------------------------
SELECT DISTINCT
	person_fname AS "first_name"
, 	person_lname AS "last_name"
,	role AS "person_type"
,	course_title as "course_name"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN course c ON s.course_id = c.course_id
WHERE role = "TA";

-- ----------------------------------------------------------------------
-- Query 5: Students that take Intro to Computing in Winter. 
--          Sort by student last name.
-- ----------------------------------------------------------------------
SELECT DISTINCT
	person_fname AS "first_name"
, 	person_lname AS "last_name"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN term t ON s.term_id = t.term_id
INNER JOIN course c ON s.course_id = c.course_id
WHERE 
	course_title = "Intro to Computing" 
	AND term_semester = "Winter"
    AND role = "Student"
ORDER BY person_lname;

-- ----------------------------------------------------------------------
-- Query 6: What classes does Reed teach? 
--          Order by term_name, and section_number.
-- ----------------------------------------------------------------------
SELECT
	course_code
,	course_num
,	course_title
,	section AS "section_number"
, 	term_semester AS "term_name"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN term t ON s.term_id = t.term_id
INNER JOIN course c ON s.course_id = c.course_id
WHERE role = "Teacher" AND person_fname = "Reed"
ORDER BY term_semester ASC, section ASC;

-- ----------------------------------------------------------------------
-- Query 7: The number of students enrolled for Fall.
-- ----------------------------------------------------------------------
SELECT
	term_semester AS "term_name"
,	term_year
,	COUNT(DISTINCT person_fname) AS "Enrollment"
FROM person p
INNER JOIN enrollment e ON p.person_id = e.person_id
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN term t ON s.term_id = t.term_id
WHERE role = "Student" AND term_semester = "Fall" AND term_year = 2024;


-- ----------------------------------------------------------------------
-- Query 8: The number of courses in each department. 
--          Sort by department name.
-- ----------------------------------------------------------------------
SELECT
	department AS "department_name"
,	COUNT(DISTINCT course_title) AS "Courses"
FROM course c
INNER JOIN degree deg ON c.degree_id = deg.degree_id
INNER JOIN department dep ON deg.department_id = dep.department_id
GROUP BY dep.department;

-- -----------------------------------------------------------------------
-- Query 9: The total number of students each professor can teach.
--          Sort by that total number of students (teaching capacity).
-- -----------------------------------------------------------------------
SELECT DISTINCT
	person_fname AS "first_name"
,	person_lname AS "last_name"
,	SUM(section_capacity) AS "TeachingCapacity"
FROM enrollment e
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN person p ON e.person_id = p.person_id
INNER JOIN section s ON e.section_id = s.section_id
WHERE role = "Teacher"
GROUP BY person_fname, person_lname
ORDER BY sum(section_capacity);

-- --------------------------------------------------------------------------------
-- Query 10: Each student's total credit load for Fall, 
--           but only students with a credit load greater than or equal to three.
--           Sort by credit load in descending order. 
-- --------------------------------------------------------------------------------
SELECT DISTINCT
	person_lname AS "last_name"
,	person_fname AS "first_name"
,	SUM(course_credits) AS "Credits"
FROM enrollment e
INNER JOIN role r ON e.role_id = r.role_id
INNER JOIN person p ON e.person_id = p.person_id
INNER JOIN section s ON e.section_id = s.section_id
INNER JOIN term t ON s.term_id = t.term_id
INNER JOIN course c ON s.course_id = c.course_id
WHERE role = "Student" AND term_semester = "Fall" AND term_year = 2024
GROUP BY person_lname, person_fname
HAVING SUM(course_credits) >= 3
ORDER BY SUM(course_credits) DESC;
