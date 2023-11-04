CREATE DATABASE library 
USE library

CREATE TABLE books(
id INT(11) PRIMARY KEY,
isbn VARCHAR(50) UNIQUE,
title VARCHAR(50) NOT NULL,
pages INT(11),
summary TEXT(255),
genre VARCHAR(50) NOT NULL
)

DESCRIBE books

ALTER TABLE books
DROP summary
MODIFY isbn CHAR(13);

DESC books 

CREATE DATABASE db_praktikum 
USE db_praktikum

CREATE TABLE students(
student_id INT(11) PRIMARY KEY,
`name` VARCHAR(50),
email VARCHAR(255) UNIQUE,
gander CHAR(1)
);

CREATE TABLE classes(
class_id INT(11) PRIMARY KEY AUTO_INCREMENT,
class_name VARCHAR(50)
);

CREATE TABLE class_student(
enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
grade CHAR(1) DEFAULT "E",
student_id INT(11),
class_id INT(11),
FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

-- DESC class_student
 
-- DROP DATABASE db_praktikum 

CREATE DATABASE perpustakaan
USE perpustakaan 

CREATE TABLE buku(
id_buku INT(11) PRIMARY KEY AUTO_INCREMENT,
judul VARCHAR(255),
tahun_terbit INT(11), 
pengarang VARCHAR(255)
);

CREATE TABLE pinjam(
id_pinjam INT(11) PRIMARY KEY AUTO_INCREMENT,
tgl_pinjam DATETIME,
id_buku INT(11),
status_pengembalian TINYINT(1) DEFAULT "0",
FOREIGN KEY(id_buku) REFERENCES buku(id_buku)
); 
 

employeesclassicmodels