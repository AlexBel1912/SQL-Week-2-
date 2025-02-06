USE scuola;

CREATE TABLE corsi (
id INT auto_increment PRIMARY KEY,
nome_corso VARCHAR(100)
);

CREATE TABLE citta (
id INT auto_increment PRIMARY KEY,
nome_citta VARCHAR(100)
);


CREATE TABLE iscrizioni (
studenteID INT,
corsoID INT,
anno_accademico INT,
PRIMARY KEY(studenteID, corsoID, anno_accademico),
FOREIGN KEY (studenteID) REFERENCES studenti(id),
FOREIGN KEY (corsoID) REFERENCES corsi(id)
);

DESCRIBE studenti;

CREATE TABLE iscrizioni (
  studenteID INT,
  corsoID INT,
  anno_accademico INT,
  PRIMARY KEY(studenteID, corsoID, anno_accademico),
  FOREIGN KEY (studenteID) REFERENCES studenti(IDStudente),  
  FOREIGN KEY (corsoID) REFERENCES corsi(id)
);

ALTER TABLE studenti
ADD cittaID INT,
ADD CONSTRAINT FK_citta FOREIGN KEY(cittaID) REFERENCES citta(id);

SHOW TABLES;

DESCRIBE citta;

INSERT INTO citta(nome_citta) VALUES ('Roma'),('Milano'),('Torino'),('Napoli');

SELECT * FROM citta;

UPDATE studenti set cittaID = 1 WHERE IDStudente IN (1,4,5);
UPDATE studenti set cittaID = 4 WHERE IDStudente = 2;

SELECT nome, cognome, nome_citta
	FROM studenti
		LEFT JOIN citta
			ON studenti.cittaID = cittaID;
            
SELECT s.nome as nomeStudente, s.cognome, c.nome_citta
	FROM studenti as s
    INNER JOIN citta as c
    ON s.cittaID = c.id;
    
SELECT s.nome as nomeStudente, s.cognome, c.nome_citta
	FROM studenti as s
    LEFT JOIN citta as c
    ON s.cittaID = c.id
    WHERE s.cognome LIKE '%Mor%'
    ORDER BY s.cognome;
    
INSERT INTO corsi(nome_corso)
	VALUES ('SQL'),('Python'),('Excel');
    
    SELECT * FROM studenti;
    
    SELECT * FROM corsi;


SELECT IDStudente FROM studenti WHERE IDStudente IN (1, 2, 3, 4, 5);
SELECT id FROM corsi WHERE id IN (1, 2, 3);

INSERT INTO studenti (IDStudente, nome, cognome) VALUES
(1, 'Mario', 'Rossi'),
(2, 'Luigi', 'Bianchi'),
(3, 'Giovanni', 'Verdi'),
(4, 'Anna', 'Gialli'),
(5, 'Marco', 'Blu');

INSERT INTO iscrizioni(studenteID, corsoID, anno_accademico)
	VALUES
    (1,1,2025),
    (2,1,2025),
    (3,2,2025),
    (4,1,2023),
    (4,1,2024),
    (5,3,2024);
    
    SELECT * FROM iscrizioni;
    
    SELECT s.nome, s.cognome, c.nome_corso, i.anno_accademico
    FROM studenti as s
    INNER JOIN iscrizioni as i ON s.id = i.studenteID
    INNER JOIN corsi as c ON i.corsoID = c.id
    WHERE i.anno_accademico > 2024;