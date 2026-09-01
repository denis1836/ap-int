create database ksiegarnia1;
use ksiegarnia1;


create table Klienci
(
  klientID int unsigned not null auto_increment primary key,
  nazwisko char(50) not null,
  adres char(100) not null,
  miejscowosc char(30) not null
);
insert into Klienci values
  (3, 'Julia Kowalska', 'Wierzbowa 25', 'Warszawa'),
  (4, 'Adam Pawlak', 'Szeroka 1/47', 'Szczecin'),
  (5, 'Anna Pawlak', 'Legnicka 5/8', 'Wroclaw'),
  (7, 'adam Nowak', 'Braniborska 23/47', 'Szczecin'),
  (6, 'Michalina Nowak', 'Zachodnia 357', 'Gliwice'),
  (8, 'Jan Testowy', 'Testowa 257', 'Gliwice')
;


create table Zamowienia
(
  zamowienieID int unsigned not null auto_increment primary key,
  klientID int unsigned not null,
  wartosc float(6,2),
  data date not null
);
insert into Zamowienia values
  (NULL, 5, 69.98, '2000-04-02'),
  (NULL, 3, 12.99, '2001-04-15'),
  (NULL, 4, 74.00, '2002-04-19'),
  (NULL, 6, 74.00, '2003-04-19'),
  (NULL, 7, 74.00, '2001-04-19'),
  (NULL, 5, 6.99, '2002-05-01')
;


create table Ksiazki
(
  isbn char(13) not null primary key,
  autor char(50),
  tytul char(100),
  cena float(4,2)
);
insert into Ksiazki values
  ('0-672-31697-8', 'Michael Morgan', 'Java 2 dla Profesjonalistow', 34.99),
  ('0-672-31745-1', 'Thomas Down', 'Instalacja Debian GNU/Linux', 15.99),
  ('0-672-31509-2', 'Lucas Pruitt', 'Poznaj GIMP w 24 godziny', '24.99'),
  ('0-672-31769-9', 'Thomas Schenk', 'Caldera OpenLinux ujarzmiony', 49.99),
  ('0-672-31769-8', 'Thomas Schenk', 'Tytul', 49.99),
  ('0-672-31769-7', 'Thomas Schenk', 'testowa', 49.99)
;


create table Pozycje_Zamowione
(
  zamowienieID int unsigned not null,
  isbn char(13) not null,
  ilosc tinyint unsigned,
  primary key (zamowienieID, isbn)
);
insert into Pozycje_Zamowione values
  (1, '0-672-31697-8', 2),
  (2, '0-672-31769-9', 1),
  (3, '0-672-31769-9', 1),
  (3, '0-672-31509-2', 1),
  (4, '0-672-31745-1', 3)
;


create table Recenzja_Ksiazek
(
  isbn char(13) primary key, 
  recenzja text
);




--↓ ZADANIA ↓

-- zad 3
SELECT nazwisko, miejscowosc FROM Klienci 
WHERE nazwisko LIKE 'Adam Pawlak';

-- zad 4
SELECT miejscowosc FROM Klienci 
WHERE miejscowosc IN ('Gliwice', 'Wroclaw');

-- zad 5
SELECT DISTINCT autor FROM Ksiazki 
WHERE autor LIKE '%a';

-- zad 6
SELECT tytul FROM Ksiazki 
WHERE cena BETWEEN 24.00 AND 35.00;

-- zad 7
SELECT COUNT(*) AS ilosc_ksiazek FROM Ksiazki;

-- zad 8
SELECT tytul FROM Ksiazki 
ORDER BY cena DESC 
LIMIT 1;

-- zad 9
-- RRRR-MM-DD
SELECT * FROM Zamowienia 
WHERE data BETWEEN '2001-01-01' AND '2002-01-01';

-- zad 10
UPDATE Ksiazki 
SET tytul = 'Linux', autor = 'Jan Kowalski' 
WHERE isbn = '0-672-31769-8';

-- zad 11
DELETE FROM Ksiazki 
WHERE tytul = 'testowa';

-- zad 12
ALTER TABLE Ksiazki 
ADD COLUMN format VARCHAR(10);

-- zad 13
UPDATE Ksiazki 
SET format = 'A4' 
WHERE isbn = '0-672-31509-2';

-- zad 14 
ALTER TABLE Ksiazki 
CHANGE COLUMN format rozmiar VARCHAR(8);

-- zad 15 
ALTER TABLE Ksiazki 
DROP COLUMN rozmiar;

-- zad 16
SELECT * FROM Zamowienia 
WHERE wartosc >= 69.98
ORDER BY wartosc DESC;

-- zad 17
SELECT tytul FROM Ksiazki
WHERE BINARY tytul = 'Java 2 dla Profesjonalistow';

-- zad 18
SELECT * FROM Zamowienia 
WHERE data > '2001-01-01'
ORDER BY data DESC
LIMIT 3 OFFSET 1;

-- zad 19
SELECT * AS dane, adres, miejscowosc FROM Klienci 
WHERE miejscowosc = 'Szczecin';

-- zad 20
SELECT DISTINCT miejscowosc FROM Klienci;

-- zad 21
SELECT AVG(cena) AS srednia_cena FROM Ksiazki;

-- zad 22
SELECT *, COALESCE(SUM(z.wartosc), 0) AS suma_zamowien FROM Klienci K
LEFT JOIN Zamowienia Z ON K.klientID = Z.klientID
GROUP BY K.klientID;

-- zad 23
SELECT *, COALESCE(SUM(z.wartosc), 0) AS suma_zamowien FROM Klienci K
LEFT JOIN Zamowienia Z ON K.klientID = Z.klientID
GROUP BY K.klientID
HAVING suma_zamowien > 74.00
ORDER BY suma_zamowien ASC;

-- zad 24
SELECT Klienci, Zamowienia
FROM Klienci
CROSS JOIN Zamowienia;

-- zad 25
-- wady: ekslozja danych, bezsensowe kombinacje, wolne, trudne do analizy
-- jak naprawić: inner join lub left join 

-- zad 26
SELECT K.nazwisko, K.adres, Z.data, PZ.isbn FROM Klienci K
CROSS JOIN Zamowienia Z ON K.klientID = Z.klientID
CROSS JOIN Pozycje_Zamowione PZ ON z.zamowienieID = PZ.zamowienieID;

-- zad 27
-- kiedy kolumna ma tą samą nazwę w więcej niż jeden tabeli

-- zad 28
SELECT K.nazwisko, K.adres, Z.data, PZ.isbn FROM Klienci K
INNER JOIN Zamowienia Z ON K.klientID = Z.klientID
INNER JOIN Pozycje_Zamowione PZ ON z.zamowienieID = PZ.zamowienieID;

-- zad 29
SELECT K.*, Z.* FROM Klienci K
LEFT JOIN Zamowienia Z ON K.klientID = Z.klientID;
-- wyświetli : wszyscy klienci, ich zamowienia, albo null jeżeli nie ma zamówien

-- zad 30
SELECT K.*, Z.* FROM Klienci K
RIGHT JOIN Zamowienia Z ON K.klientID = Z.klientID;
-- wyswietli: wszysktkie zamówienia, ich klientów, albo null jeżeli brak klienta

-- zad 31
SELECT CONCAT(miejscowosc, ', ', adres) AS pelny_adres FROM Klienci;

-- zad 32
SELECT SUBSTRING(tytul, 3) AS skrocony_tytul FROM Ksiazki;

-- zad 33
SELECT SUBSTRING(tytul, 3, 1) AS trzecia_literafrom FROM Ksiazki;

-- zad 34
SELECT nazwisko, INSTR(LOWER(nazwisko), 'a') AS miejsce_a FROM Klienci;

-- zad 35
DROP TABLE Recenzja_Ksiazek;

-- zad 36
SELECT * FROM Ksiazki 
WHERE autor != 'thomas schenk';