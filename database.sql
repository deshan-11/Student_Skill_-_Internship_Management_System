CREATE DATABASE IF NOT EXISTS Student_Skill_Internship_Management_System;
USE Student_Skill_Internship_Management_System;


--Department Table
CREATE TABLE IF NOT EXISTS Department (
    department_id VARCHAR(100) PRIMARY KEY NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

INSERT INTO Department (department_id, department_name, Description) VALUES
('D001', 'Computing', 'Department of Computing'),
('D002', 'Information Technology', 'Department of IT'),
('D003', 'Software Engineering', 'Department of Software Engineering'),
('D004', 'Business Management', 'Department of Business Management'),
('D005', 'Accounting', 'Department of Accounting'),
('D006', 'Marketing', 'Department of Marketing'),
('D007', 'Human Resources', 'Department of Human Resources'),
('D008', 'Engineering', 'Department of Engineering'),
('D009', 'Mathematics', 'Department of Mathematics'),
('D010', 'Statistics', 'Department of Statistics'),
('D011', 'Cyber Security', 'Department of Cyber Security'),
('D012', 'Data Science', 'Department of Data Science'),
('D013', 'Networking', 'Department of Networking'),
('D014', 'Multimedia', 'Department of Multimedia'),
('D015', 'Graphic Design', 'Department of Graphic Design'),
('D016', 'Hospitality', 'Department of Hospitality'),
('D017', 'Tourism', 'Department of Tourism'),
('D018', 'English', 'Department of English'),
('D019', 'Communication', 'Department of Communication'),
('D020', 'Law', 'Department of Law');

--Course Table
CREATE TABLE IF NOT EXISTS Course (
    Course_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    department_id VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO Course (Course_ID, Course_Name, Credits, department_id) VALUES
('C001', 'Database Fundamentals', 3, 'D001'),
('C002', 'Web Development', 4, 'D002'),
('C003', 'Programming Basics', 3, 'D003'),
('C004', 'Software Design', 4, 'D004'),
('C005', 'Business Communication', 3, 'D005'),
('C006', 'Financial Accounting', 3, 'D006'),
('C007', 'Digital Marketing', 3, 'D007'),
('C008', 'Network Administration', 4, 'D008'),
('C009', 'Cyber Security Basics', 3, 'D009'),
('C010', 'Data Analytics', 4, 'D010'),
('C011', 'Python Programming', 3, 'D011'),
('C012', 'Java Programming', 4, 'D012'),
('C013', 'Mobile App Development', 4, 'D013'),
('C014', 'Cloud Fundamentals', 3, 'D014'),
('C015', 'Machine Learning', 4, 'D015'),
('C016', 'Statistics for Computing', 3, 'D016'),
('C017', 'Project Management', 3, 'D017'),
('C018', 'UI UX Design', 3, 'D018'),
('C019', 'Graphic Design Basics', 3, 'D019'),
('C020', 'Computer Architecture', 4, 'D020');

--STUDENT TABLE
CREATE TABLE IF NOT EXISTS Student (
    Student_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    department_id VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO Student (Student_ID, First_Name, Last_Name, Date_of_Birth, Gender, Email, department_id) VALUES
('S001', 'Amal', 'Perera', '2002-01-15', 'Male', 'amal001@example.com', 'D001'),
('S002', 'Nimal', 'Silva', '2001-02-20', 'Male', 'nimal002@example.com', 'D002'),
('S003', 'Kamal', 'Fernando', '2002-03-10', 'Male', 'kamal003@example.com', 'D003'),
('S004', 'Tharushi', 'Jayasinghe', '2003-04-12', 'Female', 'tharushi004@example.com', 'D004'),
('S005', 'Kasun', 'Bandara', '2001-05-18', 'Male', 'kasun005@example.com', 'D005'),
('S006', 'Nethmi', 'Wijesinghe', '2002-06-22', 'Female', 'nethmi006@example.com', 'D006'),
('S007', 'Dinuka', 'Herath', '2003-07-05', 'Male', 'dinuka007@example.com', 'D007'),
('S008', 'Sachini', 'Perera', '2002-08-14', 'Female', 'sachini008@example.com', 'D008'),
('S009', 'Isuru', 'Silva', '2001-09-09', 'Male', 'isuru009@example.com', 'D009'),
('S010', 'Pavithra', 'Fernando', '2003-10-21', 'Female', 'pavithra010@example.com', 'D010'),
('S011', 'Malith', 'Jayasinghe', '2002-11-11', 'Male', 'malith011@example.com', 'D011'),
('S012', 'Sanduni', 'Bandara', '2001-12-17', 'Female', 'sanduni012@example.com', 'D012'),
('S013', 'Dilan', 'Herath', '2002-01-25', 'Male', 'dilan013@example.com', 'D013'),
('S014', 'Chamodi', 'Silva', '2003-02-08', 'Female', 'chamodi014@example.com', 'D014'),
('S015', 'Ravindu', 'Perera', '2001-03-19', 'Male', 'ravindu015@example.com', 'D015'),
('S016', 'Ishara', 'Fernando', '2002-04-24', 'Female', 'ishara016@example.com', 'D016'),
('S017', 'Gayan', 'Wijesinghe', '2003-05-13', 'Male', 'gayan017@example.com', 'D017'),
('S018', 'Lakshan', 'Bandara', '2001-06-28', 'Male', 'lakshan018@example.com', 'D018'),
('S019', 'Anuki', 'Herath', '2002-07-16', 'Female', 'anuki019@example.com', 'D019'),
('S020', 'Mihiri', 'Silva', '2003-08-07', 'Female', 'mihiri020@example.com', 'D020');

--Student_Phone Table
CREATE TABLE IF NOT EXISTS Student_Phone (
    Student_ID VARCHAR(100),
    Phone_Number VARCHAR(15) NOT NULL,
    PRIMARY KEY (Student_ID, Phone_Number),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

INSERT INTO Student_Phone (Student_ID, Phone_Number) VALUES
('S001', '0712345678'),
('S002', '0723456789'),
('S003', '0734567890'),
('S004', '0745678901'),
('S005', '0756789012'),
('S006', '0767890123'),
('S007', '0778901234'),
('S008', '0789012345'),
('S009', '0790123456'),
('S010', '0701234567'),
('S011', '0712345679'),
('S012', '0723456790'),
('S013', '0734567901'),
('S014', '0745679012'),
('S015', '0756789123'),
('S016', '0767891234'),
('S017', '0778902345'),
('S018', '0789013456'),
('S019', '0790124567'),
('S020', '0701235678');

--Instructor Table
CREATE TABLE IF NOT EXISTS Instructor ( 
    Instructor_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Instructor_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    department_id VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO Instructor (Instructor_ID, Instructor_Name, Email, department_id) VALUES
('I001', 'Amal Perera', 'amal.i001@example.com', 'D013'),
('I002', 'Nimal Silva', 'nimal.i002@example.com', 'D016'),
('I003', 'Kamal Fernando', 'kamal.i003@example.com', 'D003'),
('I004', 'Tharushi Jayasinghe', 'tharushi.i004@example.com', 'D004'),
('I005', 'Kasun Bandara', 'kasun.i005@example.com', 'D005'),
('I006', 'Sachini Wijesinghe', 'sachini.i006@example.com', 'D020'),
('I007', 'Isuru Gunawardena', 'isuru.i007@example.com', 'D007'),
('I008', 'Gayan Rajapaksha', 'gayan.i008@example.com', 'D008'),
('I009', 'Mihiri Herath', 'mihiri.i009@example.com', 'D020'),
('I010', 'Saman Senanayake', 'saman.i010@example.com', 'D010'),
('I011', 'Dinuka Dissanayake', 'dinuka.i011@example.com', 'D011'),
('I012', 'Pavithra Wickramasinghe', 'pavithra.i012@example.com', 'D012'),
('I013', 'Malith Abeysekara', 'malith.i013@example.com', 'D013'),
('I014', 'Lakshan Karunaratne', 'lakshan.i014@example.com', 'D014'),
('I015', 'Sanduni Peiris', 'sanduni.i015@example.com', 'D014'),
('I016', 'Ravindu Amarasinghe', 'ravindu.i016@example.com', 'D002'),
('I017', 'Chathura Ekanayake', 'chathura.i017@example.com', 'D017'),
('I018', 'Ruwani Samarasinghe', 'ruwani.i018@example.com', 'D018'),
('I019', 'Supun Rathnayake', 'supun.i019@example.com', 'D019'),
('I020', 'Thilina Pathirana', 'thilina.i020@example.com', 'D006');

--Instructor_Phone Table
CREATE TABLE IF NOT EXISTS Instructor_Phone (   
    Instructor_ID VARCHAR(100),
    Phone_Number VARCHAR(15) NOT NULL,
    PRIMARY KEY (Instructor_ID, Phone_Number),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

INSERT INTO Instructor_Phone (Instructor_ID, Phone_Number) VALUES
('I001', '0783345678'),
('I002', '0727896789'),
('I003', '0734567890'),
('I004', '0745678901'),
('I005', '0756097012'),
('I006', '0767678123'),
('I007', '0778901234'),
('I008', '0789023345'),
('I009', '0790983456'),
('I010', '0701734567'),
('I011', '0712345679'),
('I012', '0723456790'),
('I013', '0734567901'),
('I014', '0745679012'),
('I015', '0756789123'),
('I016', '0763451234'),
('I017', '0778765345'),
('I018', '0789013456'),
('I019', '0790144567'),
('I020', '0701765678');

--Enrollment Table
CREATE TABLE IF NOT EXISTS Enrollment (
    Enrollment_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Status ENUM('Enrolled', 'Completed', 'Dropped','Pending') NOT NULL,
    Enrollment_Date DATE NOT NULL,
    Student_ID VARCHAR(100),
    Course_ID VARCHAR(100),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Enrollment (Enrollment_ID, Status, Enrollment_Date, Student_ID, Course_ID) VALUES
('E001', 'Enrolled', '2023-01-15', 'S001', 'C001'),
('E002', 'Completed', '2023-02-20', 'S002', 'C002'),
('E003', 'Dropped', '2023-03-10', 'S003', 'C003'),
('E004', 'Pending', '2023-04-12', 'S004', 'C004'),
('E005', 'Completed', '2023-05-18', 'S005', 'C005'),
('E006', 'Dropped', '2023-06-22', 'S006', 'C006'),
('E007', 'Enrolled', '2023-07-05', 'S007', 'C007'),
('E008', 'Completed', '2023-08-14', 'S008', 'C008'),
('E009', 'Pending', '2023-09-09', 'S009', 'C009'),
('E010', 'Pending', '2023-10-21', 'S010', 'C010'),
('E011', 'Completed', '2023-11-11', 'S011', 'C011'),
('E012', 'Dropped', '2023-12-17', 'S012','C012'),
('E013', 'Enrolled', '2023-01-25', 'S013', 'C013'),
('E014', 'Completed', '2023-02-08', 'S014', 'C014'),
('E015', 'Dropped', '2023-03-19', 'S015', 'C015'),
('E016', 'Pending', '2023-04-24', 'S016', 'C016'),
('E017', 'Enrolled', '2023-05-13', 'S017', 'C017'),
('E018', 'Completed', '2023-06-28', 'S018','C018'),
('E019', 'Dropped', '2023-07-16', 'S019','C019'),
('E020', 'Pending', '2023-08-07','S020','C020');

--SKILL_CATEGORY TABLE
CREATE TABLE IF NOT EXISTS Skill_Category (
    Category_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Category_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

INSERT INTO Skill_Category (Category_ID, Category_Name, Description) VALUES
('SC001', 'Programming', 'Programming languages and coding'),
('SC002', 'Web Development', 'Website development skills'),
('SC003', 'Database Management', 'Database design and management'),
('SC004', 'Networking', 'Computer networking skills'),
('SC005', 'Cybersecurity', 'Information security skills'),
('SC006', 'Software Engineering', 'Software development practices'),
('SC007', 'Mobile Development', 'Mobile application development'),
('SC008', 'Cloud Computing', 'Cloud platform skills'),
('SC009', 'Data Science', 'Data analysis and science skills'),
('SC010', 'Artificial Intelligence', 'AI technologies and applications'),
('SC011', 'Machine Learning', 'Machine learning techniques'),
('SC012', 'Data Analytics', 'Data analysis and reporting'),
('SC013', 'UI Design', 'User interface design skills'),
('SC014', 'UX Design', 'User experience design skills'),
('SC015', 'Graphic Design', 'Digital graphic design skills'),
('SC016', 'Project Management', 'Managing projects and tasks'),
('SC017', 'Communication', 'Professional communication skills'),
('SC018', 'Leadership', 'Leadership and team management'),
('SC019', 'Teamwork', 'Collaboration and team skills'),
('SC020', 'Problem Solving', 'Identifying and solving problems');

--SKILL TABLE
CREATE TABLE IF NOT EXISTS Skill (
    Skill_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Skill_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Category_ID VARCHAR(100),
    FOREIGN KEY (Category_ID) REFERENCES Skill_Category(Category_ID)
);

INSERT INTO Skill (Skill_ID, Skill_Name, Description, Category_ID) VALUES
('SK001', 'Python Programming', 'Programming language for data science and web development', 'SC001'),
('SK002', 'Java Programming', 'Object-oriented programming language for enterprise applications', 'SC001'),
('SK003', 'C++ Programming', 'Compiled language for system-level programming', 'SC001'),
('SK004', 'HTML & CSS', 'Markup and styling languages for web development', 'SC002'),
('SK005', 'JavaScript', 'Scripting language for interactive web pages', 'SC002'),
('SK006', 'SQL Database Management', 'Language for managing relational databases', 'SC003'),
('SK007', 'Network Configuration', 'Setting up and managing computer networks', 'SC004'),
('SK008', 'Cybersecurity Fundamentals', 'Basic principles of information security', 'SC005'),
('SK009', 'Software Development Lifecycle', 'Phases and processes of software development', 'SC006'),
('SK010', 'Mobile App Development (Android)', 'Creating applications for Android devices', 'SC007'),
('SK011', 'Mobile App Development (iOS)', 'Creating applications for iOS devices', 'SC007'),
('SK012', 'AWS Cloud Services', 'Cloud computing services provided by Amazon', 'SC008'),
('SK013', 'Azure Cloud Services', 'Cloud computing services provided by Microsoft', 'SC008'),
('SK014', 'Data Analysis with Python', 'Analyzing data using the Python programming language', 'SC009'),
('SK015', 'Machine Learning Algorithms', 'Algorithms for training machine learning models', 'SC010'),
('SK016', 'Deep Learning Techniques', 'Advanced neural network architectures and methods', 'SC010'),
('SK017', 'Data Visualization with Tableau', 'Creating visual representations of data using Tableau', 'SC012'),
('SK018', 'UI Design Principles', 'Fundamental principles of user interface design', 'SC013'),
('SK019', 'UX Research Methods', 'Methods for conducting user experience research', 'SC014'),
('SK020', 'Graphic Design with Adobe Photoshop','Designing digital graphics using Adobe Photoshop','SC015');

--Skill_Level Table
CREATE TABLE IF NOT EXISTS Skill_Level (
    Level_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Level_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

INSERT INTO Skill_Level (Level_ID, Level_Name, Description) VALUES
('L001', 'Beginner', 'Basic understanding of the skill'),
('L002', 'Intermediate', 'Moderate proficiency in the skill'),
('L003', 'Advanced', 'High level of expertise in the skill'),
('L004', 'Expert', 'Exceptional mastery of the skill'),
('L005', 'Novice', 'Limited experience with the skill'),
('L006', 'Proficient', 'Competent and capable in the skill'),
('L007', 'Specialist', 'Focused expertise in a specific area of the skill'),
('L008', 'Master', 'Recognized authority and expert in the skill'),
('L009', 'Apprentice', 'Learning and developing skills under guidance'),
('L010', 'Journeyman', 'Skilled practitioner with practical experience'),
('L011', 'Technician', 'Technical proficiency and practical application of the skill'),
('L012', 'Consultant', 'Provides expert advice and guidance in the skill area'),
('L013', 'Trainer', 'Teaches and trains others in the skill'),
('L014', 'Mentor', 'Guides and supports others in developing their skills'),
('L015', 'Innovator', 'Introduces new ideas and approaches in the skill area'),
('L016', 'Leader', 'Leads and manages teams in applying the skill'),
('L017', 'Strategist', 'Develops strategies and plans for utilizing the skill effectively'),
('L018', 'Evaluator', 'Assesses and evaluates skill proficiency and performance'),
('L019', 'Researcher', 'Conducts research to advance knowledge in the skill area'),
('L020', 'Entrepreneur', 'Applies skills to create and manage business ventures');

--STUDENT_SKILL Table
CREATE TABLE IF NOT EXISTS Student_Skill (
    Student_Skill_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Acquired_Date DATE NOT NULL,
    Student_ID VARCHAR(100),
    Skill_ID VARCHAR(100),
    Level_ID VARCHAR(100),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Skill_ID) REFERENCES Skill(Skill_ID),
    FOREIGN KEY (Level_ID) REFERENCES Skill_Level(Level_ID)
);

INSERT INTO Student_Skill (Student_Skill_ID, Acquired_Date, Student_ID, Skill_ID, Level_ID) VALUES
('SS001', '2023-01-15', 'S001', 'SK001', 'L002'),
('SS002', '2023-02-20', 'S002', 'SK002', 'L003'),
('SS003', '2023-03-10', 'S003', 'SK003', 'L001'),
('SS004', '2023-04-12', 'S004', 'SK004', 'L004'),
('SS005', '2023-05-18', 'S005', 'SK015', 'L002'),
('SS006', '2023-06-22', 'S006', 'SK006', 'L003'),
('SS007', '2023-07-05', 'S007', 'SK019', 'L001'),
('SS008', '2023-08-14', 'S008', 'SK008', 'L004'),
('SS009', '2023-09-09', 'S009', 'SK009', 'L002'),
('SS010', '2023-10-21','S010','SK010','L003'),
('SS011', '2023-11-11','S011','SK011','L001'),
('SS012', '2023-12-17','S012','SK012','L004'),
('SS013', '2023-01-25','S013','SK013','L002'),
('SS014', '2023-02-08','S014','SK014','L003'),
('SS015', '2023-03-19','S015','SK013','L001'),
('SS016', '2023-04-24','S016','SK016','L004'),
('SS017', '2023-05-13','S017','SK017','L002'),
('SS018', '2023-06-28','S018','SK018','L003'),
('SS019', '2023-07-16','S019','SK019','L001'),
('SS020', '2023-08-07','S020','SK010','L004');

--TRAINING PROGRAM TABLE

CREATE TABLE IF NOT EXISTS Training_Program (
    Program_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Program_Name VARCHAR(100) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Instructor_ID VARCHAR(100),
    Skill_ID VARCHAR(100),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
    FOREIGN KEY (Skill_ID) REFERENCES Skill(Skill_ID)
);

INSERT INTO Training_Program (Program_ID, Program_Name, Start_Date, End_Date, Cost, Instructor_ID, Skill_ID) VALUES
('TP001', 'Python Programming', '2025-01-01', '2025-02-01', 45000.00, 'I001', 'SK001'),
('TP002', 'Java Programming', '2025-01-05', '2025-02-05', 46000.00, 'I002', 'SK002'),
('TP003', 'C Programming', '2025-01-10', '2025-02-10', 40000.00, 'I003', 'SK003'),
('TP004', 'C++ Development', '2025-01-15', '2025-02-15', 42000.00, 'I004', 'SK004'),
('TP005', 'JavaScript Development', '2025-01-20', '2025-02-20', 44000.00, 'I014', 'SK005'),
('TP006', 'HTML Fundamentals', '2025-02-01', '2025-02-28', 35000.00, 'I006', 'SK006'),
('TP007', 'CSS Web Design', '2025-02-05', '2025-03-05', 36000.00, 'I017', 'SK007'),
('TP008', 'React Development', '2025-02-10', '2025-03-10', 50000.00, 'I008', 'SK008'),
('TP009', 'Node.js Development', '2025-02-15', '2025-03-15', 48000.00, 'I009', 'SK009'),
('TP010', 'PHP Web Development', '2025-02-20', '2025-03-20', 42000.00, 'I010', 'SK010'),
('TP011', 'MySQL Database Management', '2025-03-01', '2025-04-01', 45000.00, 'I011', 'SK011'),
('TP012', 'PostgreSQL Administration', '2025-03-05', '2025-04-05', 47000.00, 'I005', 'SK012'),
('TP013', 'Advanced SQL Queries', '2025-03-10', '2025-04-10', 43000.00, 'I007', 'SK013'),
('TP014', 'Database Design', '2025-03-15', '2025-04-15', 46000.00, 'I012', 'SK014'),
('TP015', 'Data Modeling', '2025-03-20', '2025-04-20', 44000.00, 'I015', 'SK015'),
('TP016', 'Network Configuration', '2025-04-01', '2025-05-01', 48000.00, 'I016', 'SK016'),
('TP017', 'TCP/IP Networking', '2025-04-05', '2025-05-05', 42000.00, 'I013', 'SK017'),
('TP018', 'Network Security', '2025-04-10', '2025-05-10', 52000.00, 'I018', 'SK018'),
('TP019', 'Ethical Hacking', '2025-04-15', '2025-05-15', 55000.00, 'I019', 'SK019'),
('TP020', 'Security Risk Assessment', '2025-04-20', '2025-05-20', 50000.00, 'I020', 'SK020');

--CETIFICATE TABLE
CREATE TABLE IF NOT EXISTS Certificate (
    Certificate_ID VARCHAR(100) PRIMARY KEY NOT NULL,
    Certificate_Name VARCHAR(100) NOT NULL,
    Issued_Date DATE NOT NULL,
    Issued_Organization VARCHAR(100) NOT NULL,
    Student_ID VARCHAR(100),
    Program_ID VARCHAR(100),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Program_ID) REFERENCES Training_Program(Program_ID)
);

INSERT INTO Certificate (Certificate_ID, Certificate_Name, Issued_Date, Issued_Organization, Student_ID, Program_ID) VALUES
('CET001', 'Python Programming Certificate', '2025-02-01', 'ABC Institute', 'S001', 'TP001'),
('CET002', 'Java Programming Certificate', '2025-02-05', 'XYZ Academy', 'S002', 'TP002'),
('CET003', 'C Programming Certificate', '2025-02-10', 'LMN Institute', 'S003', 'TP003'),
('CET004', 'C++ Development Certificate', '2025-02-15', 'PQR Academy', 'S004', 'TP004'),
('CET005', 'JavaScript Development Certificate', '2025-02-20', 'DEF Institute', 'S005', 'TP005'),
('CET006', 'HTML Fundamentals Certificate', '2025-02-28', 'GHI Academy', 'S006', 'TP006'),
('CET007', 'CSS Web Design Certificate', '2025-03-05', 'JKL Institute', 'S007', 'TP007'),
('CET008', 'React Development Certificate', '2025-03-10', 'MNO Academy','S008','TP008'),
('CET009','Node.js Development Certificate','2025-03-15','STU Institute','S009','TP009'),
('CET010','PHP Web Development Certificate','2025-03-20','VWX Academy','S010','TP010'),
('CET011','MySQL Database Management Certificate','2025-04-01','YZA Institute','S011','TP011'),
('CET012','PostgreSQL Administration Certificate','2025-04-05','BCD Academy','S012','TP012'),
('CET013','Advanced SQL Queries Certificate','2025-04-10','EFG Institute','S013','TP013'),
('CET014','Database Design Certificate','2025-04-15','HIJ Academy','S014','TP014'),
('CET015','Data Modeling Certificate','2025-04-20','KLM Institute','S015','TP015'),
('CET016','Network Configuration Certificate','2025-05-01','NOP Academy','S016','TP016'),
('CET017','TCP/IP Networking Certificate','2025-05-05','QRS Institute','S017','TP017'),
('CET018','Network Security Certificate','2025-05-10','TUV Academy','S018','TP018'),
('CET019','Ethical Hacking Certificate','2025-05-15','WXY Institute','S019','TP019'),
('CET020','Security Risk Assessment Certificate','2025-05-20','ZAB Academy','S020','TP020');




---------------------------------------SQL QUERY AND RESULTS---------------------------------------------

//DISPLAY ALL STUDENTS
SELECT * FROM Student;

//DISPLAY ALL SKILLS
SELECT * FROM Skill;

//DISPLAY ALL CERTIFICATES
SELECT * FROM Certificate;
mysql> SELECT * FROM Certificate;
+----------------+---------------------------------------+-------------+---------------------+------------+------------+
| Certificate_ID | Certificate_Name                      | Issued_Date | Issued_Organization | Student_ID | Program_ID |
+----------------+---------------------------------------+-------------+---------------------+------------+------------+
| CET001         | Python Programming Certificate        | 2025-02-01  | ABC Institute       | S001       | TP001      |
| CET002         | Java Programming Certificate          | 2025-02-05  | XYZ Academy         | S002       | TP002      |
| CET003         | C Programming Certificate             | 2025-02-10  | LMN Institute       | S003       | TP003      |
| CET004         | C++ Development Certificate           | 2025-02-15  | PQR Academy         | S004       | TP004      |
| CET005         | JavaScript Development Certificate    | 2025-02-20  | DEF Institute       | S005       | TP005      |
| CET006         | HTML Fundamentals Certificate         | 2025-02-28  | GHI Academy         | S006       | TP006      |
| CET007         | CSS Web Design Certificate            | 2025-03-05  | JKL Institute       | S007       | TP007      |
| CET008         | React Development Certificate         | 2025-03-10  | MNO Academy         | S008       | TP008      |
| CET009         | Node.js Development Certificate       | 2025-03-15  | STU Institute       | S009       | TP009      |
| CET010         | PHP Web Development Certificate       | 2025-03-20  | VWX Academy         | S010       | TP010      |
| CET011         | MySQL Database Management Certificate | 2025-04-01  | YZA Institute       | S011       | TP011      |
| CET012         | PostgreSQL Administration Certificate | 2025-04-05  | BCD Academy         | S012       | TP012      |
| CET013         | Advanced SQL Queries Certificate      | 2025-04-10  | EFG Institute       | S013       | TP013      |
| CET014         | Database Design Certificate           | 2025-04-15  | HIJ Academy         | S014       | TP014      |
| CET015         | Data Modeling Certificate             | 2025-04-20  | KLM Institute       | S015       | TP015      |
| CET016         | Network Configuration Certificate     | 2025-05-01  | NOP Academy         | S016       | TP016      |
| CET017         | TCP/IP Networking Certificate         | 2025-05-05  | QRS Institute       | S017       | TP017      |
| CET018         | Network Security Certificate          | 2025-05-10  | TUV Academy         | S018       | TP018      |
| CET019         | Ethical Hacking Certificate           | 2025-05-15  | WXY Institute       | S019       | TP019      |
| CET020         | Security Risk Assessment Certificate  | 2025-05-20  | ZAB Academy         | S020       | TP020      |
+----------------+---------------------------------------+-------------+---------------------+------------+------------+
20 rows in set (0.01 sec)
//SELECT SPECIFIC COLUMNS
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, Student_ID FROM Student;

mysql> SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, Student_ID FROM Student;
+---------------------+------------+
| Full_Name           | Student_ID |
+---------------------+------------+
| Amal Perera         | S001       |
| Nimal Silva         | S002       |
| Kamal Fernando      | S003       |
| Tharushi Jayasinghe | S004       |
| Kasun Bandara       | S005       |
| Nethmi Wijesinghe   | S006       |
| Dinuka Herath       | S007       |
| Sachini Perera      | S008       |
| Isuru Silva         | S009       |
| Pavithra Fernando   | S010       |
| Malith Jayasinghe   | S011       |
| Sanduni Bandara     | S012       |
| Dilan Herath        | S013       |
| Chamodi Silva       | S014       |
| Ravindu Perera      | S015       |
| Ishara Fernando     | S016       |
| Gayan Wijesinghe    | S017       |
| Lakshan Bandara     | S018       |
| Anuki Herath        | S019       |
| Mihiri Silva        | S020       |
+---------------------+------------+
20 rows in set (0.01 sec)

//SKILLS IN PROGRAMMING CATEGORY
SELECT Skill_Name, Skill_ID FROM Skill WHERE Category_ID = 'SC001';

mysql> SELECT Skill_Name, Skill_ID FROM Skill WHERE Category_ID = 'SC001';
+--------------------+----------+
| Skill_Name         | Skill_ID |
+--------------------+----------+
| Python Programming | SK001    |
| Java Programming   | SK002    |
| C++ Programming    | SK003    |
+--------------------+----------+
3 rows in set (0.00 sec)


//FIND PROGRAMMES WITH COST GREATER THAN 45000
SELECT Program_Name, Cost FROM Training_Program WHERE Cost > 45000;

mysql> SELECT Program_Name, Cost FROM Training_Program WHERE Cost > 45000;
+---------------------------+----------+
| Program_Name              | Cost     |
+---------------------------+----------+
| Java Programming          | 46000.00 |
| React Development         | 50000.00 |
| Node.js Development       | 48000.00 |
| PostgreSQL Administration | 47000.00 |
| Database Design           | 46000.00 |
| Network Configuration     | 48000.00 |
| Network Security          | 52000.00 |
| Ethical Hacking           | 55000.00 |
| Security Risk Assessment  | 50000.00 |
+---------------------------+----------+
9 rows in set (0.00 sec)

//FIND PROGRAMMES WITH COST LESS THAN 40000
SELECT Program_Name, Cost FROM Training_Program WHERE Cost < 40000;

mysql> SELECT Program_Name, Cost FROM Training_Program WHERE Cost < 40000;
+-------------------+----------+
| Program_Name      | Cost     |
+-------------------+----------+
| HTML Fundamentals | 35000.00 |
| CSS Web Design    | 36000.00 |
+-------------------+----------+
2 rows in set (0.00 sec)

//FIND PROGRAMMES WITH COST GREATER THAN OR EQUAL TO 50000
SELECT Program_Name, Cost FROM Training_Program WHERE Cost >= 50000;


mysql> SELECT Program_Name, Cost FROM Training_Program WHERE Cost >= 50000;
+--------------------------+----------+
| Program_Name             | Cost     |
+--------------------------+----------+
| React Development        | 50000.00 |
| Network Security         | 52000.00 |
| Ethical Hacking          | 55000.00 |
| Security Risk Assessment | 50000.00 |
+--------------------------+----------+
4 rows in set (0.00 sec)

//FIND SPECIFIC STUDENT SKILLS
SELECT Skill_Name, Skill_ID FROM Skill WHERE Skill_Name IN ('Python Programming', 'Java Programming', 'C++ Programming');
mysql> SELECT Skill_Name, Skill_ID FROM Skill WHERE Skill_Name IN ('Python Programming', 'Java Programming', 'C++ Programming');
+--------------------+----------+
| Skill_Name         | Skill_ID |
+--------------------+----------+
| Python Programming | SK001    |
| Java Programming   | SK002    |
| C++ Programming    | SK003    |
+--------------------+----------+
3 rows in set (0.00 sec)


SELECT Skill_Name, Skill_ID FROM Skill WHERE Skill_Name = 'Mobile App Development';

mysql>
mysql> SELECT Skill_Name, Skill_ID FROM Skill WHERE Skill_Name = 'Mobile App Development';
Empty set (0.00 sec)


//EXCLUDE PROGRAMMES WITH COST EQUAL TO 45000
SELECT Program_Name, Cost FROM Training_Program WHERE Cost != 45000;
mysql> SELECT Program_Name, Cost FROM Training_Program WHERE Cost != 45000;
+---------------------------+----------+
| Program_Name              | Cost     |
+---------------------------+----------+
| Java Programming          | 46000.00 |
| C Programming             | 40000.00 |
| C++ Development           | 42000.00 |
| JavaScript Development    | 44000.00 |
| HTML Fundamentals         | 35000.00 |
| CSS Web Design            | 36000.00 |
| React Development         | 50000.00 |
| Node.js Development       | 48000.00 |
| PHP Web Development       | 42000.00 |
| PostgreSQL Administration | 47000.00 |
| Advanced SQL Queries      | 43000.00 |
| Database Design           | 46000.00 |
| Data Modeling             | 44000.00 |
| Network Configuration     | 48000.00 |
| TCP/IP Networking         | 42000.00 |
| Network Security          | 52000.00 |
| Ethical Hacking           | 55000.00 |
| Security Risk Assessment  | 50000.00 |
+---------------------------+----------+
18 rows in set (0.00 sec)