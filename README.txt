STUDENT & SKILL MANAGEMENT SYSTEM
=================================

Requirements:
- XAMPP (Apache + MySQL)
- PHP with PDO MySQL enabled
- Existing database: Student_Skill_Internship_Management_System
- Tables expected: Student, Department, Course, Enrollment, Skill, Skill_Category,
  Student_Skill, Skill_Level, Certificate, Instructor, Training_Program

INSTALL:
1. Copy the StudentSkills folder to C:\xampp\htdocs\
2. Start Apache and MySQL from XAMPP Control Panel.
3. Open phpMyAdmin and verify the database exists.
4. Open api/db.php and set $password to your actual MySQL password.
5. Open http://localhost/StudentSkills/

SIGN-IN:
Use an email already registered in Student.Email or Instructor.Email.
This sample uses email-only sign-in for coursework demonstration. Do not deploy it
to a public server without adding proper password authentication and authorization.

DEBUG:
- Open http://localhost/StudentSkills/api/tables.php after signing in to test tables.
- JSON "Please sign in first." is expected when not logged in.
- If database connection fails, check database name, username, password and MySQL status.
- Ensure files are saved as UTF-8 without a BOM and PHP files start with <?php.
