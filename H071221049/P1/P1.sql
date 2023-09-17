CREATE DATABASE Library;
USE Library;

CREATE TABLE Books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);

DESCRIBE Books;

ALTER TABLE Books
MODIFY isbn CHAR(13);

ALTER TABLE Books
DROP summary;

SHOW TABLES;

CREATE DATABASE db_praktikum;

CREATE TABLE Students (
	nama VARCHAR(50),
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY 
);

CREATE TABLE Classes (
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT,
);

CREATE TABLE class_student(
	grade CHAR(1) DEFAULT 'E',
	student_id INT(11),
	class_id INT(11), 
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT ,
	
	FOREIGN KEY(student_id) REFERENCES Students(student_id),
	FOREIGN KEY(class_id) REFERENCES Classes(class_id)
);

SHOW TABLES;
DESCRIBE students;
DESCRIBE classes;
DESCRIBE class_student;

DROP DATABASE Library;
DROP DATABASE db_praktikum;
DROP TABLE classes;

-- Soal Tambahan

CREATE DATABASE db_prak;
USE db_prak;

CREATE TABLE buku(
	judul VARCHAR(255),
	tahun_terbit INT,
	pengarang VARCHAR(255),
	id_buku INT PRIMARY KEY AUTO_INCREMENT 
);

CREATE TABLE pinjam(
	tgl_pinjam DATETIME,
	id_buku INT,
	status_pengembalian TINYINT(1) DEFAULT 0,
	id_pinjam INT PRIMARY KEY AUTO_INCREMENT, 
	
	FOREIGN KEY(id_buku) REFERENCES buku(id_buku)
);