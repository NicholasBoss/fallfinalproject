Do the following: 

1) Create a University ERD using data in university_data.pdf. All the data in this file is not already set up into entities (tables) and it doesn't have any primary keys shown. These are what query result sets might look like, not necessarily just tables themselves. Please refer to the Organizational Rules section below to help with the design process.

2) Forward engineer the University database using your ERD from step 1. Save the code displayed during that forward engineering process into an SQL file.

3) Submit your file AND an image of your ERD. (It will make the grading process faster if you submit a photo of your ERD).

Please double or even triple check your work before you submit.

When you design a database, it is common to define a set of business rules or organizational rules. These rules might come about while asking questions about how the business or organization should work. Let's assume you have already asked some questions and established the following rules.

Organizational Rules :

* Course sections play an important part in organizing course enrollments. A section is defined as a given instance of a course (imagine your enrollment in this very class, at this time, with this teacher).
* Technically, a student is enrolled in the section. So, the student relationship should be with the section table, not the course table. However, can many students be in one section? Can a student enroll in many different sections? If we have a many to many relationship, what must we do? 
* Assume only one teacher is associated with a section, but one instructor can teach more than one section. Can a teacher also be a student?
* As for the semester, consider our class section. It is only assigned to one year/term. But a given year/term can have many sections.
* Each section can have a different capacity, set by the teacher, but it should always have the same number of credits.
* HINT: You should have 7-8 tables total.
* Your many-to-many table should be named 'enrollment'.
* Your database should be named 'university'.

Submissions:

Submit one SQL file that contains the forward engineering code. Make sure the code that should work is NOT commented out. It must be runnable code. Also, submitting a screenshot of your diagram will help us grade faster.