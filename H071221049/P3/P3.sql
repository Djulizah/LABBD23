-- No. 1 --

CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) NOT NULL PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`Status` VARCHAR(50) NOT NULL,
	Nilai INT(11)
);

DESCRIBE mahasiswa;

INSERT INTO mahasiswa (NIM, Nama, Kelas, `Status`, Nilai)
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241063', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby', 'B', 'Alfa', 90);
		 
SELECT * FROM mahasiswa;

-- No. 2 --

UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `Status` = 'Alfa';

-- No. 3 --

DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

-- No. 4 --

INSERT INTO mahasiswa (Nim, Nama, Kelas, `Status`, Nilai)
VALUES ('H071221049', 'Sakinah NuruSyifa', 'B', 'Pindahan', NULL);

UPDATE mahasiswa
SET nilai = 50
WHERE `status` = 'Alfa'

UPDATE mahasiswa
SET Kelas = 'A'

-- Soal Tambahan --

CREATE TABLE dosen (
	NIP INT AUTO_INCREMENT PRIMARY KEY,
	nim_mahasiswa VARCHAR(50),
	nama VARCHAR(50),
	`status` VARCHAR(50),
	
	FOREIGN KEY(nim_mahasiswa) REFERENCES mahasiswa(NIM)
);

DESCRIBE dosen;

SELECT * FROM dosen

INSERT INTO dosen (nim_mahasiswa, nama, `status`)
VALUES ('H071241079', 'Inumaki', 'bimbingan'),
		 ('H071241060', 'Ukyo', 'alfa'),
		 ('H071241065', 'Senku', 'bimbingan');

UPDATE dosen
SET `status` = 'bimbingan'
WHERE `status` = 'alfa'

DESCRIBE dosen;

ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;     
ALTER TABLE dosen ADD FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa (NIM) ON UPDATE CASCADE;

UPDATE dosen 
SET nim_mahasiswa = 12345
WHERE nama = 'senku';

DROP TABLE mahasiswa