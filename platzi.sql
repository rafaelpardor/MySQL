select database();
CREATE DATABASE IF NOT EXISTS platzi_operation;
CREATE database platzi_operation;

SHOW TABLES;
show warnings;
drop table <name>;
describe <name>;
show full columns from <name>;
select * from <name>;
select * from <name> WHERE <name>\G
ON DUPLICATE KEY ignore all
ON DUPLICATE KEY UPDATE

use platzi_operation;

CREATE TABLE IF NOT EXISTS books (
	book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    author_id INTEGER UNSIGNED ,
    title VARCHAR(100) NOT NULL,
    `year` INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
    cover_url VARCHAR(500),
    price DOUBLE(6,2) NOT NULL DEFAULT 10.0,
    sellable TINYINT(1) DEFAULT 1,
    copies INTEGER NOT NULL DEFAULT 1,
    description TEXT
);
INSERT INTO books(title,author_id)VALUES
('El laberinto de la Soledad',6);
INSERT INTO books(title,author_id,`year`)
VALUES('Vuelta al Laberinto de la Soledad',
    (SELECT author_id from authors
    WHERE name = 'Octavio Paz'
    LIMIT 1
    ), 1960
);


CREATE TABLE IF NOT EXISTS authors (
    author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(3)
);
INSERT INTO authors(name,nationality) VALUES
('Juan Rulfo','MEX'),
('Gabriel Garcia Márquez','COL'),
('Juan Gabriel Márquez','COL'),
('Julio Cortázar','ARG'),
('Isabel Allende','CHI'),
('Octavio Paz','MEX'),
('Juan Carlos Onetti','URG');

CREATE TABLE IF NOT EXISTS clients (
    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)  NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M','F','MD') NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);
INSERT INTO`clients`(client_id, name, email, birthdate, gender, active) VALUES
(1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1);

INSERT INTO`clients`(client_id,name, email, active) VALUES
(5,'Pep Sanchez', 'pepsanchez@random.com',1)
ON DUPLICATE KEY UPDATE 
active=VALUES(active)
