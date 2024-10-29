-- TABLES 
-- WHEN INSTERTING, START FROM BOTTOM AND PROCEED TO TOP

-- enrollment
  -- role
  -- person
  -- section
    -- term 
    -- course
      -- degree
        -- department


-- CREATE DEPARTMENTS
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