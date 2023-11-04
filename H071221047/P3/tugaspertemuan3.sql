CREATE DATABASE praktikum3;

USE praktikum3;

#1
CREATE TABLE mahasiswa (
NIM VARCHAR (10) PRIMARY KEY,
Nama VARCHAR (50) NOT NULL,
Kelas CHAR (1) NOT NULL,
status VARCHAR (50) NOT NULL,
Nilai INT (11)
);

DESCRIBE mahasiswa;

SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
('H071241060', 'Pitonia', 'A', 'Alfa', 85),
('H071241063', 'Javano', 'A', 'Hadir', 50),
('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
('H071241066', 'Pihap E', 'B', 'Hadir', 85),
('H071241079', 'Ruby', 'B', 'Alfa', 90);


#2

UPDATE mahasiswa
SET Nilai = 0, Kelas = "C"
WHERE status = 'alfa';

#3

DELETE FROM mahasiswa
WHERE Kelas = 'A' AND nilai > 90;
 
 #4
 
INSERT INTO mahasiswa
VALUES ('H071221047', 'Wina', 'B', 'pindahan', NULL);
UPDATE mahasiswa
SET Nilai = 50
WHERE status = 'alfa';
UPDATE mahasiswa
SET Kelas = 'A';
SELECT * FROM mahasiswa;

DROP TABLE mahasiswa; 

#5. soal tambahan 
CREATE TABLE dosen (
NIP INT PRIMARY KEY AUTO_INCREMENT,
nim_mahasiswa VARCHAR(10),
Nama VARCHAR(50) ,
`status` VARCHAR(50),

FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(NIM)
); 

INSERT INTO dosen ( nim_mahasiswa, Nama, `status`)
VALUES ( 'H071221047', 'pak hendra', 'bimbingan'), 
( 'H071241060','pak sadno', 'alfa'), 
('H071241063', 'pak jeriko', 'alfa');

DESCRIBE dosen;
SELECT * FROM dosen;

#6. soal tambahan
ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;
ALTER TABLE dosen ADD FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(NIM) ON DELETE CASCADE on UPDATE CASCADE;

DELETE FROM mahasiswa 
WHERE NIM = 'H071221047' ;

UPDATE dosen 
SET `status` = 'bimbingan'
WHERE status = 'alfa';