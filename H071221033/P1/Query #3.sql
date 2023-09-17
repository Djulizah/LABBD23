CREATE DATABASE db_perpustakaan

USE db_perpustakaan

CREATE TABLE buku(
	id_buku INT PRIMARY KEY AUTO_INCREMENT,
	judul VARCHAR(255),
	tahun_terbit INT,
	pengarang VARCHAR(255)
);

CREATE TABLE pinjam(
	id_pinjam INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	tgl_pinjam DATETIME,
	status_pengembalian TINYINT(1) DEFAULT '0',
	id_buku INT,
	
	FOREIGN KEY(id_buku) REFERENCES buku(id_buku)
);