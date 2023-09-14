CREATE DATABASE library;
USE library;
#nomor 1
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn CHAR(13) UNIQUE NOT NULL,
    title VARCHAR(50) NOT NULL,
    pages INT,
    genre VARCHAR(50) NOT NULL
);

#no 2
ALTER TABLE books
MODIFY isbn CHAR(13);

#no 3
ALTER TABLE books
DROP COLUMN summary;

#no. 4
DESCRIBE books;

#no 5
CREATE DATABASE db_praktikum;
USE db_praktikum;

CREATE TABLE students (
	name VARCHAR(50),
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY
);

CREATE TABLE classes (
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE class_student (
	grade CHAR(1) DEFAULT 'E',
	student_id INT(11),
	class_id INT(11),
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (student_id) REFERENCES students (student_id),
	FOREIGN KEY (class_id) REFERENCES classes (class_id)
);

DESCRIBE students;
DESCRIBE classes;
DESCRIBE class_student;
