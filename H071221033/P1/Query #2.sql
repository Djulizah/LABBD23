#no5
CREATE DATABASE db_praktikum

USE db_praktikum;

CREATE TABLE classes(
	class_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	class_name VARCHAR(50)
);
DESCRIBE classes;

CREATE TABLE students(
	student_id INT(11) PRIMARY KEY,
	nama VARCHAR(50),
	email VARCHAR(255) UNIQUE,
	gender CHAR(1)
);
DESCRIBE students;

CREATE TABLE class_student (
	enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	grade CHAR(1) DEFAULT 'E',
	student_id INT(11),
	class_id INT(11),
	
	FOREIGN KEY(student_id) REFERENCES students(student_id),
	FOREIGN KEY(class_id) REFERENCES classes(class_id)
);
DESCRIBE class_student;

-- char = utk data yg dinamis/berbeda-beda
-- char ga include spasi
-- karakter yg tersimpan sesuai parameter yg telah ditentukan
-- 
-- varchar = utk data yg jmlh karakternya tetap
-- varchar include spasi
-- karakter yg tersimpan sesuai inputan

#kpn pake ; kpn engga = pake klo mau di run skaligus, klo r.selection gosah gpp
#cara pisah database per tgs praktikum
#cara upload github

DROP DATABASE db_praktikum;

CREATE DATABASE db_praktikum;

USE db_prakti