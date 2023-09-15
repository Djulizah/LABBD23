USE library;
CREATE TABLE books (
	isbn VARCHAR(50) UNIQUE NOT NULL,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);

--- modifikasi atribut 'isbn' menjadi char(13)
ALTER TABLE books MODIFY isbn CHAR(13) NOT NULL;
---hapus atribut 'summary'
ALTER TABLE books DROP COLUMN summary;
DESCRIBE books;

