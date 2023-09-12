-- AL QADRI
-- H071221052
-- Praktikum Basis Data
-- nomor 1
CREATE DATABASE library
USE library
CREATE TABLE books(
	id INT PRIMARY KEY,
	isbn VARCHAR (50) UNIQUE,
	title VARCHAR (50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR (50) NOT NULL
	);

-- nomor 2
ALTER TABLE books
MODIFY isbn CHAR (13)

-- nomor 3
ALTER TABLE books DROP summary

-- nomor 4
DESCRIBE books

-- nomor 5
CREATE DATABASE db_praktikum
USE db_praktikum
CREATE TABLE students(
	`name`VARCHAR (50),
	email VARCHAR (255) UNIQUE,
	gender CHAR (1) DEFAULT "E",
	student_id INT PRIMARY KEY
	);
	
CREATE TABLE classes(
	class_name VARCHAR (50),
	class_id INT AUTO_INCREMENT PRIMARY KEY
	);
	
CREATE TABLE class_student(
	grade CHAR (1) DEFAULT "E",
	student_id INT,
	class_id INT,
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
	
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
	);
	
	
DESCRIBE students
DESCRIBE classes
DESCRIBE class_student