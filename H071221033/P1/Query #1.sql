USE library

CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);

DESCRIBE books;

#no2
ALTER TABLE books
MODIFY isbn CHAR(13)

#no3
ALTER TABLE books
DROP summary

#no4
DESCRIBE books;

DROP DATABASE library;

CREATE DATABASE library;

USE library;

CREATE tab
