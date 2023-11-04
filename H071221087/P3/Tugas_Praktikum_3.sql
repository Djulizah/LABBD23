-- nomor 1
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR (10) PRIMARY KEY,
	Nama VARCHAR (50) NOT NULL,
	Kelas CHAR (1) NOT NULL,
	`status` VARCHAR (50) NOT NULL,
	Nilai INT (11)
);

DESC mahasiswa;

INSERT INTO mahasiswa (NIM, Nama, Kelas, `status`, Nilai) 
VALUES ("H071241056", "Kotlina", "A", "Hadir", 100),
		 ("H071241060", "Pitonia", "A", "Alfa", 85),
		 ("H071241063", "Javano", "A", "Hadir", 50),
		 ("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
		 ("H071241066", "Pihab E", "B", "Hadir", 85),
		 ("H071241079", "Ruby", "B", "Alfa", 90);
SELECT * FROM mahasiswa;



-- nomor 2
UPDATE mahasiswa
SET Nilai = 0 , Kelas = "C"
WHERE `status` = "Alfa"



-- nomor 3
DELETE FROM mahasiswa
WHERE nilai > 90 AND kelas = "A"



-- nomor 4
INSERT INTO mahasiswa (NIM, Nama, Kelas, `status`) 
VALUE ("H071221087", "Muhammad Iqbal", "D", "Pindahan");

UPDATE mahasiswa
SET nilai = 50
WHERE status = "Alfa"

UPDATE mahasiswa 
SET Kelas = "A"




-- Tugas Tambahan
CREATE TABLE dosen (
	NIP INT (11) PRIMARY KEY AUTO_INCREMENT,
	nim_mahasiswa VARCHAR(10) NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(nim)  
);
DESC dosen;


INSERT INTO dosen(Nama, `status`, nim_mahasiswa)
VALUE ("senkuu", "bimbingan", "H071241066"),
		("makima", "alfa", "H071241079"),
		("gojo", "bimbingan", "H071241065");
SELECT * FROM dosen;

UPDATE dosen
SET `status` = "bimbingan"
WHERE Nama = "makima"

DELETE FROM mahasiswa
WHERE Nim = "H071241066"


DROP TABLE dosen

-- cascade\
ALTER TABLE dosen DROP FOREIGN KEY dosen_ibfk_1;  
ALTER TABLE dosen ADD FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa (NIM) ON DELETE CASCADE;   
