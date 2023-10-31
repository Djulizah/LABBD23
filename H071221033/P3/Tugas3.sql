-- no 1
CREATE DATABASE praktikum3

USE praktikum3

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) NOT NULL PRIMARY KEY, 
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	statuss VARCHAR(50) NOT NULL,
	Nilai INT(11)
)

DESCRIBE mahasiswa
SELECT * FROM mahasiswa

INSERT INTO mahasiswa (NIM, Nama, Kelas, statuss, Nilai)
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100);

INSERT INTO mahasiswa (NIM, Nama, Kelas, statuss, Nilai)
VALUES ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
		
SELECT * FROM mahasiswa

-- no 2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE statuss = 'Alfa'


-- no 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90


-- no 4
INSERT INTO mahasiswa (NIM, Nama, Kelas, statuss)
VALUES ('H071221033', 'Nurfadilah', 'C', 'Pindahan') 

UPDATE mahasiswa
SET Nilai = 50
WHERE statuss = 'Alfa'

UPDATE mahasiswa
SET Kelas = 'A'

DROP TABLE mahasiswa


-- no 5
CREATE TABLE dosen (
	NIP INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nim_mahasiswa VARCHAR(10) NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	
	FOREIGN KEY(nim_mahasiswa) REFERENCES mahasiswa(NIM)
)

DROP TABLE dosen
DESCRIBE dosen
SELECT * FROM dosen

INSERT INTO dosen (nim_mahasiswa, Nama, `status`)
VALUES ('H071241065', 'Patrick', 'bimbingan'),
	('H071241066', 'Ah Tong', 'alfa'),
	('H071241079', 'Mrs. Puff', 'alfa')
	
UPDATE dosen
SET `status` = 'bimbingan'
WHERE `status` = 'alfa'

DROP TABLE mahasiswa

DELETE FROM dosen
WHERE NIP = 5

DELETE FROM mahasiswa
WHERE NIM = 'H071241079'

ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;

ALTER TABLE dosen ADD FOREIGN KEY(nim_mahasiswa) REFERENCES mahasiswa(NIM) ON DELETE CASCADE ON UPDATE CASCADE 
