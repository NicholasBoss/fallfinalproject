-- Your column names may not match mine
-- This can be used, but make sure you use your column names
INSERT INTO enrollment
(person_id, section_id, role_id)
VALUES
( (SELECT person_id 
   FROM person 
   WHERE CONCAT(fname, ' ', lname) = 'John Smith')
, (SELECT section_id
   FROM   section s
   INNER JOIN course c ON s.course_id = c.course_id
   INNER JOIN term t ON s.term_id = t.term_id
   WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024'
   AND   CONCAT(course_code, ' ', course_num) = 'CSE 251'
   AND   section_num = 1)
, (SELECT role_id 
   FROM role 
   WHERE person_type = 'Student')
),