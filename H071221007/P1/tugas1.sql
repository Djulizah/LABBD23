#CREATE DATABASE dataBaseSaya;
#USE dataBaseSaya;

#CREATE TABLE mytable {
	#nama VARCHAR (100) NOT NULL
#}

#DROP TABLE mytable;
#DESCRIBE mytable;
-- CREATE TABLE prodi (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	nama VARCHAR(100)
-- );
-- CREATE TABLE mahasiswa (
-- 	nim VARCHAR(10) PRIMARY KEY,
-- 	nama VARCHAR(100),
-- 	nilai INT DEFAULT 0,
-- 	id_prodi INT,
-- 	
-- 	FOREIGN KEY(id_prodi) REFERENCES prodi(id)
-- );
-- 
#DESCRIBE mytable;

-- ALTER TABLE mahasiswa
-- ADD angkatan INT(10)

-- ALTER TABLE mahasiswa
-- MODIFY nama VARCHAR(200)

-- ALTER TABLE mahasiswa
-- DROP angkatan;


-- SHOW TABLES

-- mydatabase5CREATE DATABASE mydatabase5;
-- USE mydatabase5
-- 
-- CREATE TABLE buku {
-- 	judul VARCHAR(255),
-- 	tahun terbit INT DEFAULT 2000,
-- 	pengarang VARCHAR(255),
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
-- 	}databasesaya
-- 	
-- CREATE TABLE mahasiswa {
-- 	nama VARCHAR(255),
-- 	nim VARCHAR(10),
-- 	jk CHAR(1),
-- 	id_mahasiswa INT PRIMARY KEY
-- 	}
-- 	
-- CREATE TABLE pinjam {
-- 	id_mahasiswa,
-- 	id_buku,
-- 	status_pengembalian TINYINT(1),
-- 	id_pinjam INT PRIMARY KEY, 
-- 	
-- 	}
-- 	
-- 	
-- 	
-- DESCRIBE books

-- No 1-4 --

CREATE DATABASE library;

USE library;

CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
	);
	
-- SHOW TABLES;
DESCRIBE books;

ALTER TABLE books
MODIFY isbn CHAR(13);

ALTER TABLE books
DROP summary;
	

-- NO 5 --

CREATE DATABASE db_praktikum;
USE db_praktikum;

CREATE TABLE students(
	nama VARCHAR(50),
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY
	);
	
ALTER TABLE students
MODIFY student_id INT(11)

DESCRIBE students;


CREATE TABLE classes (
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT 
	);	
	
DESCRIBE class_student;


CREATE TABLE class_student (
	grade CHAR(1) DEFAULT 'E',
	student_id INT(11),
	class_id INT(11),
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
	); 


DROP DATABASE db_praktikum;

SHOW TABLES;

