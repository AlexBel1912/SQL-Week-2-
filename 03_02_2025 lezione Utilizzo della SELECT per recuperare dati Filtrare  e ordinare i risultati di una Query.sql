CREATE table studenti (
id INT AUTO_INCREMENT,
nome varchar (50),
cognome varchar (50),
anno_nascita int,
email varchar (100) UNIQUE,
telefono varchar (50),
primary key (id)
);

INSERT INTO studenti (nome, cognome, anno_nascita, email, telefono)
VALUES
('Mario','Rossi',2000,'mario.rossi@gmail.com','32856489652'),
('Anna','Bianchi',1998,'anna.bianchi@gmail.com','3265454656'),
('Luca','Verdi',1978,'luca.verdi@gmail.com','3214658513'),
('Francesco','Morabito',2008,'francesco.morabito@gmail.com','38545758745'),
('Carlo','Gialli',2005,'carlo.gialli@gmail.com','3280900111');

SELECT * FROM studenti;

Select * FROM studenti WHERE cognome = 'Rossi';

SELECT * FROM studenti WHERE anno_nascita >= 2000;

SELECT * FROM studenti ORDER BY anno_nascita DESC;

SELECT * FROM studenti WHERE email LIKE '%libero%';	

INSERT INTO studenti (nome, cognome, anno_nascita, email, telefono)
VALUES
('Carlo','Gialli',2005,'carlo.gialli@libero.it','352485625456');

SELECT * FROM studenti WHERE email LIKE '%libero%';	

SELECT * FROM studenti WHERE cognome = 'Morabito' OR cognome = 'Rossi';

SELECT ID, nome, cognome, anno_nascita, email, telefono, 2025-anno_nascita AS ETA FROM studenti; 

SELECT nome, cognome, YEAR(CURDATE())-anno_nascita AS ETA FROM studenti;

SELECT nome, cognome, MONTH(CURDATE()) FROM studenti;

SELECT * FROM studenti WHERE cognome IN ('Morabito','Rossi');

SELECT nome, cognome, YEAR(CURDATE())-anno_nascita AS eta FROM studenti WHERE YEAR(CURDATE())-anno_nascita >= 18 ORDER BY eta;

SELECT nome, cognome, anno_nascita FROM studenti WHERE YEAR(CURDATE())-anno_nascita BETWEEN 20 AND 29 ORDER BY anno_nascita;

ALTER TABLE studenti
ADD sesso char(1) CHECK (sesso IN ('M','F'));

SELECT * FROM studenti;

UPDATE studenti SET sesso = 'M' WHERE id IN (1,3,4,5);