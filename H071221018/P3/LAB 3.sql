CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL ,
	Kelas CHAR(1) NOT NULL ,
	`status` VARCHAR(50) NOT NULL ,
	Nilai INT(11)
);

SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056','Kotlina','A','Hadir',100),
('H071241060','Pitonia','A','Alfa',85),
('H071241063','Javano','A','Hadir',50),
('H071241065','Ciplus Kuadra','B','Hadir',65),
('H071241066','Pihap E','B','Hadir',85),
('H071241079','Ruby','B','Alfa',90);

UPDATE mahasiswa
SET Nilai = 0, kelas = 'C'
WHERE `status`= 'Alfa';

DELETE FROM mahasiswa
WHERE Kelas= 'A' AND Nilai > 90;

INSERT INTO mahasiswa
VALUES ('H071221018','Waliuddin','C','Pindahan',null);

UPDATE mahasiswa
SET Nilai = 50
WHERE Nilai = 0;

UPDATE mahasiswa
SET Kelas = 'A';