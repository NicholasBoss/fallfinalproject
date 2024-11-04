USE university;

-- QUESTION 1
SELECT person_fname as fname, person_lname as lname, role as person_type, CONCAT(course_code, ' ', course_num) as course, section as section_number, term_semester as term_name, term_year
FROM person p
INNER JOIN enrollment e
ON p.person_id = e.person_id
INNER JOIN role r
ON e.role_id = r.role_id
INNER JOIN section s
ON e.section_id = s.section_id
INNER JOIN term t
ON s.term_id = t.term_id
INNER JOIN course c
ON s.course_id = c.course_id
WHERE CONCAT(p.person_fname, ' ', p.person_lname) = 'Allen Stokes'
ORDER BY s.section


-- QUESTION 2
-- SELECT person_fname as fname, person_lname as lname, role as person_type, course_title as course_name, section as section_number, term_semester as term_name, term_year
-- FROM person p
-- INNER JOIN enrollment e
-- ON p.person_id = e.person_id
-- INNER JOIN role r
-- ON e.role_id = r.role_id
-- INNER JOIN section s
-- ON e.section_id = s.section_id
-- INNER JOIN term t
-- ON s.term_id = t.term_id
-- INNER JOIN course c
-- ON s.course_id = c.course_id
-- WHERE c.course_title = 'Intro to Computing' AND r.role = 'Student';

-- QUESTION 3
-- students enrolled in Applied Calculus (COUNT)
-- SELECT COUNT(*) as "Students enrolled in Applied Calculus for Data Analysis"
-- FROM enrollment e
-- INNER JOIN role r
-- ON e.role_id = r.role_id
-- INNER JOIN section s
-- ON e.section_id = s.section_id
-- INNER JOIN course c
-- ON s.course_id = c.course_id
-- WHERE c.course_title = "Applied Calculus for Data Analysis" AND r.role = "Student";
