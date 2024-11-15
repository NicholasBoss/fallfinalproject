-- REMOVE THIS LINE AND PASTE pt1-b file here (Should contain the Forward Engineering code and the inserts)
USE `university`;

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

