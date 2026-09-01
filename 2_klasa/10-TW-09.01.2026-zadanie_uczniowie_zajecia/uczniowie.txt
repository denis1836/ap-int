CREATE DATABASE ucz1;
USE ucz1;

--zad 1
CREATE TABLE Uczniowie(
	uczen_ID BIGINT PRIMARY KEY AUTO_INCREMENT,
	klasa VARCHAR(3),
	nazwisko VARCHAR(100),
	imie VARCHAR(50),
	data_ur DATE,
	adres VARCHAR(150),
	miasto VARCHAR(100) DEFAULT 'WROCLAW'
);

CREATE TABLE Zajecia(
	NR_spotkania BIGINT PRIMARY KEY AUTO_INCREMENT,
	pracownia VARCHAR(4),
	data_spotkania TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	liczba_godz INT,
	tematyka VARCHAR(3)
);

INSERT INTO Uczniowie VALUES
	(1, '3B', 'Kowalski', 'Jan', '1967-03-03', 'Obloka 5', 'WROCLAW'),
	(2, '4A', 'Mikita', 'Adrian', '1988-04-07', 'Mydlana 5', 'WROCLAW')
;

INSERT INTO Zajecia VALUES
	(1, '001', '2008-09-08', 3, 'RP'),
	(2, '200', '2009-03-29', 2, 'AM'),
	(3, '300', '2009-03-30', 1, 'HG'),
	(4, '400', '2009-03-31', 5, 'DF')
;

--zad 2
SELECT * FROM Zajecia WHERE NR_spotkania != 2;

--zad 3
-- już dałem primary key przy deklaracji tabeli

--zad 4
DELETE FROM Zajecia WHERE NR_spotkania IN(1, 3); 

-- zad 5
UPDATE Zajecia SET tematyka='AR' WHERE tematyka='AM';

--zad 6
SELECT * FROM Zajecia WHERE pracownia='001' AND liczba_godz=3;

--zad 7
SELECT * FROM Zajecia WHERE NR_spotkania=2 OR NR_spotkania=5;

--zad 8
SELECT * FROM Zajecia WHERE NOT NR_spotkania=1;

--zad 9
SELECT * FROM Uczniowie WHERE uczen_ID IN(1, 10)
--wypisze uczniów od 1 lub 10

--zad 10
SELECT * FROM Zajecia WHERE data_spotkania BETWEEN('2008-09-08', '2009-03-30');

--zad 11
SELECT * FROM Zajecia WHERE data_spotkania>'2008-09-08' AND data_spotkania<'2009-03-30';

--zad 12
SELECT * FROM Uczniowie WHERE nazwisko LIKE('Kowal%');
--wyświetli ucznia którego nazisko się zaczyna na "kowal"

--zad 13
SELECT COUNT(NR_spotkania) FROM Zajecia WHERE NR_spotkania!=2;

--zad 14
SELECT SUM(liczba_godz) AS laczna_il_godz FROM Zajecia;

--zad 15
--operator distinct w kwerendzie nie będzie wypisywał powtarzających się wartosći w wierszach
SELECT DISTINCT nazwisko FROM Uczniowie;

--zad 16
--	SELECT Studio_ID, SUM(budget) AS suma_budzetu
--	FROM Movies 
--	GROUP BY Studio_ID
--	HAVING SUM(budget)>60
--	ORDER BY Studio_ID;
