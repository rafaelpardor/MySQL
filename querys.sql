like alter drop
mysqldump > ruta


SELECT name 
    FROM clients;

SELECT name 
    FROM clients
    LIMIT 10;

SELECT name FROM clients
    WHERE gender = 'M';
SELECT birthdate 
    FROM clients;

SELECT year(birthdate) 
    FROM clients;

SELECT NOW();

SELECT year(NOW());

SELECT year(NOW())-year(birthdate)
    FROM clients 
    LIMIT 10;

SELECT name, year(NOW())-year(birthdate)
    FROM clients;

SELECT * 
    FROM clients 
    WHERE name 
    LIKE '%Jo%';

SELECT COUNT(*) FROM books;

SELECT COUNT(*) FROM authors;

SELECT * 
    FROM authors 
    WHERE author_id > 0 AND author_id <= 5;

SELECT *
    FROM books
    WHERE author_id
    between 1 AND 5;

SELECT book_id, author_id, title
    FROM books 
    WHERE author_id between 1 AND 5;

SELECT b.book_id, a.name,a.author_id, b.title
    FROM books AS b
    JOIN authors AS a
        ON a.author_id = b.author_id
    WHERE a.author_id between 1 AND 5;

SELECT c.name,b.title, a.name,t.type
    FROM transactions AS t
    JOIN books AS b
        ON t.book_id = b.book_id
    JOIN clients AS c 
        ON t.client_id = c.client_id
    JOIN authors AS a 
        ON b.author_id = a.author_id
    WHERE c.gender = 'F'
        AND t.type = 'sell';

SELECT c.name,b.title, a.name,t.type
    FROM transactions AS t
    JOIN books AS b
        ON t.book_id = b.book_id
    JOIN clients AS c 
        ON t.client_id = c.client_id
    JOIN authors AS a 
        ON b.author_id = a.author_id
    WHERE c.gender = 'M'
        AND t.type IN ('sell','lend')

SELECT b.title, a.name
    FROM authors AS a, books AS b
    WHERE a.author_id = b.author_id
    LIMIT 10;
SELECT b.title, a.name
    FROM books AS b 
    INNER JOIN authors AS a 
        ON a.author_id = b.author_id
    LIMIT 10

SELECT a.author_id, a.name, a.nationality, b.title
    FROM authors AS a 
    LEFT JOIN books AS b 
        ON b.author_id = a.author_id
    WHERE a.author_id between 1 AND 5
    ORDER BY a.author_id

SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS ammount
    FROM authors AS a 
    RIGHT JOIN books AS b 
        ON b.author_id = a.author_id
    WHERE a.author_id between 1 AND 5
    GROUP BY a.author_id
    ORDER BY a.author_id

-- 1) ¿Que nacionalidades hay?
SELECT DISTINCT nationality 
    FROM authors
    ORDER BY nationality;

-- 2) ¿Cuantos escritores hay de cada nacionalidad?
SELECT nationality, COUNT(author_id) AS c_authors
    FROM authors
    WHERE nationality NOT IN('NULL')
    GROUP BY nationality
    ORDER BY c_authors DESC, nationality ASC

-- 3) ¿Cuantos libros hay de cada nacionalidad?
SELECT  COUNT(b.book_id) AS 'cantidad de libros', 
        a.nationality
    FROM books AS b
    LEFT JOIN authors AS a 
        ON b.author_id = a.author_id
    WHERE nationality IS NOT NULL
    GROUP BY a.nationality
    ORDER BY COUNT(b.book_id) DESC

-- 4) ¿Cual es el primedio/desviacion del precio de libros?
SELECT  nationality,
        COUNT(book_id)AS libros,
        AVG(price) AS prom, 
        STDDEV(price) AS std
    FROM books AS b
    JOIN authors AS a 
        ON a.author_id=b.author_id
    GROUP BY nationality
    ORDER BY prom DESC

-- 6) ¿Cual es el precio maximo/minimo de un libro?
SELECT a.nationality, MAX(price), MIN(price)
    FROM books AS b
    JOIN authors AS a 
        ON a.author_id = b.author_id
    GROUP BY nationality

-- 7)
SELECT c.name, t.type, b.title,
    CONCAT(a.name, "(",a.nationality,")") AS author,
    TO_DAYS(NOW()) - TO_DAYS(t.created_at) as ago
    FROM transactions AS t 
    LEFT JOIN clients AS c
        ON c.client_id = t.client_id
    LEFT JOIN books AS b 
        ON b.book_id = t.book_id
    LEFT JOIN authors AS a 
        ON b.author_id = a.author_id

SELECT *
    FROM authors
    ORDER BY RAND()
    LIMIT 1

DELETE 
    FROM authors
    WHERE author_id = 161
    LIMIT 1

SELECT client_id, name
    FROM clients
    WHERE active <> 1;

SELECT client_id, name,active
    FROM clients
    ORDER BY RAND()
    LIMIT 10

SELECT client_id, name,email,active    
    FROM clients 
    WHERE  client_id in (3,33,17,48,23,48);

UPDATE clients
    SET active = 0
    WHERE client_id IN (3,33,48)
    LIMIT 1

UPDATE clients
    SET email = 'maria@gmail.com'
    WHERE client_id = 33
    LIMIT 1;

SELECT DISTINCT nationality 
    FROM authors;

UPDATE authors
    SET nationality = 'JPN'
    WHERE nationality = 'JAP'

SELECT nationality, COUNT(book_id),
        SUM(IF(year < 1950,1,0)) AS '<1950',
        SUM(IF(year >= 1950 AND year < 1990,1,0)) AS '<1990',
        SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
        SUM(IF(year >= 2000, 1,0)) AS '<ACTUALIDAD'
    FROM books as b
    JOIN authors as a
        ON a.author_id = b.author_id
    where a.nationality is not NULL
    GROUP BY nationality
