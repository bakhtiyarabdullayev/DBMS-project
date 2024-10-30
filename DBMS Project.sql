CREATE TABLE author(
author_id NUMBER,
author_name VARCHAR(45) NOT NULL,
CONSTRAINT author_const PRIMARY KEY(author_id)
);

CREATE TABLE publisher(
publisher_id NUMBER CONSTRAINT pub_const PRIMARY KEY,
pub_name VARCHAR(45) CONSTRAINT pb_nm_cns NOT NULL,
address VARCHAR(45)
);

CREATE TABLE books(
book_id NUMBER PRIMARY KEY,
title VARCHAR(45) NOT NULL,
pages NUMBER,
author_id NUMBER REFERENCES author(author_id),
price NUMBER NOT NULL,
available VARCHAR(3) NOT NULL,
publisher_id NUMBER REFERENCES publisher(publisher_id)
);

CREATE TABLE staff(
staff_id NUMBER PRIMARY KEY,
s_first_name VARCHAR(45) NOT NULL,
s_last_name VARCHAR(45) NOT NULL
);

CREATE TABLE members(
member_id NUMBER,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
member_date DATE NOT NULL,
expiry_date DATE,
email VARCHAR(45) UNIQUE
);

INSERT INTO author
VALUES(1,'William Shakespeare');
INSERT INTO author
VALUES(2,'Agatha Christie');
INSERT INTO author
VALUES(3,'Leo Tolstoy');
INSERT INTO author
VALUES(4,'Fyodor Dostoevsky');
INSERT INTO author
VALUES(5,'Franz Kafka');

INSERT INTO publisher
VALUES(10,'Aspoligraf Ltd Mmc','Shahriyar st., 6 ');
INSERT INTO publisher
VALUES(20,'Azerneshr','M.Huseyn 61');
INSERT INTO publisher
VALUES(30,'Nafta-Press','H.Cavid pr. 29 A.');
INSERT INTO publisher
VALUES(40,'Chashioglu',null);


CREATE SEQUENCE books_sqnc
    INCREMENT BY 1
    START WITH 1001
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;

INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Othello', 664, 1, 9.99, 'YES', 20);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Men at War', 656, 3, 45, 'NO', 40);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'The Idiot', 215, 4, 25.5, 'NO', 40);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Death on the Nile', 320, 2 ,20, 'YES', 10);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Notes from Underground', 545, 4, 12.6, 'YES', 20);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Romeo and Juliet', 951, 1, 45, 'NO', 30);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Hamlet', 563, 1, 21.85, 'YES', 20);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'War & Peace', 314, 3, 21.1, 'YES', 10);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Crime and Punishment', 654, 4, 65.3, 'YES', 10);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'The ABC Murders', 155, 2, 13, 'YES', 40);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'The Winter Tale', 544, 1, 45.6, 'NO', 20);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'Murder on the Orient Express', 203, 2, 12.08, 'YES', 40);
INSERT INTO books
VALUES(books_sqnc.NEXTVAL, 'The Metamorphosis', 151, 5, 45.5, 'YES', 20);

CREATE SEQUENCE staff_sqnc
    INCREMENT BY 1
    START WITH 10
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
    
INSERT INTO staff
VALUES(staff_sqnc.NEXTVAL, 'Adil', 'Tahmazov');
INSERT INTO staff
VALUES(staff_sqnc.NEXTVAL, 'Riza', 'Alasgarov');
INSERT INTO staff
VALUES(staff_sqnc.NEXTVAL, 'Eldar', 'Aliyev');
INSERT INTO staff
VALUES(staff_sqnc.NEXTVAL, 'Zaur', 'Aghamaliyev');

INSERT INTO members
VALUES(110, 'Ashraf', 'Mammadov', '11-02-2020', null, 'ashrafmammadov@gmail.com');
INSERT INTO members
VALUES(111, 'Konul', 'Zeynalova', '20-08-2021', '31-12-2021', 'konul-z.29@mail.ru');
INSERT INTO members
VALUES(112,'Huseyn', 'Huseynli', '14-09-2020', null, 'hhuseynli20@gmail.com');




CREATE VIEW project_view
AS SELECT book_id, title, price FROM books;
SELECT * FROM project_view;

CREATE VIEW projectview2
AS SELECT b.title, a.author_name, b.price FROM books b
INNER JOIN author a
ON b.author_id = a.author_id;
SELECT * FROM projectview2;

CREATE SYNONYM project_view_copy
FOR  project_view;






SELECT * FROM books
WHERE author_id = (SELECT author_id FROM author WHERE author_name='Agatha Christie');

SELECT * FROM books
WHERE publisher_id = (SELECT publisher_id FROM publisher WHERE pub_name = 'Azerneshr');

SELECT book_id, title, price
FROM books
WHERE price = (SELECT MIN(price) FROM books);


SELECT * FROM books
WHERE author_id = ANY(1,3,4);

SELECT * FROM books
WHERE pages<ALL(800,400,300);

SELECT * FROM books
WHERE author_id = 4 
OR
title = 'M%';





SELECT title, author_name FROM books b
INNER JOIN author a
ON a.author_id = b.author_id;

SELECT * FROM books
NATURAL JOIN publisher;

SELECT * FROM books b, author a
WHERE
a.author_id = b.author_id;

SELECT * FROM books b
RIGHT OUTER JOIN author a
ON a.author_id = b.author_id;

SELECT * FROM books b
LEFT OUTER JOIN author a
ON a.author_id = b.author_id;

SELECT * FROM books b
FULL OUTER JOIN author a
ON a.author_id = b.author_id;

SELECT * FROM books
CROSS JOIN author;

SELECT * FROM books
JOIN publisher
USING (publisher_id);





SELECT MIN(pages)
FROM books;

SELECT MAX(price)
FROM books;

SELECT ROUND(AVG(price))
FROM books;

SELECT SUM(pages)
FROM books;

SELECT COUNT(*)
FROM books
WHERE publisher_id = 20;

SELECT COUNT(DISTINCT publisher_id)
FROM books;

SELECT AVG(price)
FROM books
GROUP BY publisher_id;

SELECT publisher_id, SUM(pages)
FROM books
group by publisher_id
HAVING SUM(pages)>1000;






SELECT (35*553) FROM DUAL;

SELECT UPPER('baku') FROM DUAL;
SELECT LOWER('BAKU') FROM DUAL;
SELECT INITCAP('baku IS CApiTaL') FROM DUAL;

SELECT title, MOD(price, 2)
FROM books;

SELECT first_name, last_name, member_date
FROM members
WHERE member_date>to_date('01-01-2020');

--how many months they are member of library
SELECT first_name, last_name, TRUNC((SYSDATE-member_date)/30)
FROM members;

SELECT publisher_id, pub_name, NVL(address, 'Baku, Azerbaijan')
FROM publisher;






SELECT first_name||' '||last_name AS "Users"
FROM members;

SELECT DISTINCT publisher_id 
FROM books;

--where clause
SELECT * FROM books
WHERE pages>500;

SELECT * FROM books
WHERE price BETWEEN 20 AND 60;

SELECT * FROM staff
WHERE s_first_name LIKE 'A%';

SELECT * FROM books
FETCH FIRST 10 ROWS ONLY;



ALTER TABLE members
ADD CONSTRAINT mm_cns PRIMARY KEY (member_id);

ALTER TABLE publisher
DROP CONSTRAINT pb_nm_cns;







--DML
UPDATE books
SET available = 'NO'
WHERE book_id = 1003;

DELETE FROM books
WHERE book_id = 1012;

--DDL
ALTER TABLE staff
ADD salary VARCHAR(20);

ALTER TABLE staff
MODIFY salary NUMBER;

ALTER TABLE staff
DROP COLUMN salary;

ALTER TABLE staff
RENAME COLUMN s_first_name
TO s_f_name;

ALTER TABLE staff
RENAME TO staff_members;

DROP TABLE staff;