#Nomor 1
CREATE DATABASE praktikum3;
USE praktikum3;
CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL ,
	Kelas CHAR(1) NOT NULL ,
	status VARCHAR(50) NOT NULL ,
	Nilai INT(11)
);

INSERT INTO mahasiswa
VALUES('H071241056','Kotlina','A','Hadir',100),
		('H071241060','Pitonia','A','Alfa',85),
		('H071241063','Javano','A','Hadir',50),
		('H071241065','Ciplus Kuadra','B','Hadir',65),
		('H071241066','Pihap E','B','Hadir',85),
		('H071241079','Ruby','B','Alfa',90);

SELECT * FROM mahasiswa
#Nomor 2
UPDATE mahasiswa
SET Nilai = 0, kelas = 'C'
WHERE status= 'Alfa';

SELECT * FROM mahasiswa
#Nomor 3
DELETE FROM mahasiswa
WHERE Kelas= 'A' AND Nilai > 90;

SELECT * FROM mahasiswa
#	Nomor 4
INSERT INTO mahasiswa
VALUES ('H071221052','AL QADRI','D','Pindahan',null);

UPDATE mahasiswa
SET Nilai = 50
WHERE Nilai = 0;

UPDATE mahasiswa
SET Kelas = 'A';

SELECT * FROM mahasiswa;

#Soal tambahan kakak
CREATE TABLE dosen (
	NIP int PRIMARY KEY AUTO_INCREMENT,
	nim_mahasiswa VARCHAR(10) NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	status VARCHAR(10) NOT NULL,
	FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(NIM) 
);

SELECT * FROM dosen

INSERT INTO dosen
VALUES (012345,'H071241079','Rimuru','Alfa'),
(123456,'H071221052','Veldora','Bimbingan'),
(234567,'H071241065','Diablo','Alfa');

SELECT * FROM mahasiswa;

UPDATE dosen
SET status = 'Bimbingan'
WHERE status = 'Alfa';

DROP TABLE mahasiswa;
ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;
DROP TABLE mahasiswa;

ALTER TABLE dosen ADD FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa (NIM) ON UPDATE CASCADE ;

