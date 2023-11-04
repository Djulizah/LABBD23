-- NO 1
CREATE DATABASE praktikum3;
praktikum3USE praktikum3;

CREATE TABLE mahasiswa(
	NIM VARCHAR(10) NOT NULL PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	status VARCHAR(50) NOT NULL,
	Nilai INT(11)
	);
	
DESCRIBE mahasiswa;

INSERT INTO mahasiswa
VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
		
		

-- NO 2		
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE status = 'Alfa'; 


-- NO 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;


-- NO 4 
INSERT INTO mahasiswa
VALUE ('H071221007', 'Muhammad iswari', 'A', 'pindahan', NULL);

UPDATE mahasiswa
SET Nilai = 50
WHERE STATUS = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';



SELECT * FROM mahasiswa;




-- Soal Tambahan
CREATE TABLE dosen (
	NIP INT AUTO_INCREMENT PRIMARY KEY,
	nim_mahasiswa VARCHAR(10) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	
	FOREIGN KEY(nim_mahasiswa) REFERENCES mahasiswa(NIM) 
	);
	
	
DESCRIBE dosen;
	
INSERT INTO dosen (nim_mahasiswa, Nama, `status`)
VALUES ('H071241060' ,'Saya Dosen', 'bimbingan'),
		('H071241063' ,'Saya Dosen 2', 'bimbingan'),
		('H071241065' ,'Saya Dosen 3', 'alfa');

SELECT * FROM dosen;

UPDATE dosen 
SET `status` = 'bimbingan'
WHERE `status` = 'alfa';

DROP TABLE  mahasiswa;
		
		
ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;
ALTER TABLE dosen ADD FOREIGN KEY(nim_mahasiswa) REFERENCES mahasiswa(NIM) ON UPDATE CASCADE;

INSERT INTO dosen (nim_mahasiswa, Nama, `status`)
VALUES ('H071241100' ,'Saya Dosen', 'bimbingan');

UPDATE dosen 
SET nim_mahasiswa = '12345678910'
WHERE Nama = 'Saya Dosen 2';