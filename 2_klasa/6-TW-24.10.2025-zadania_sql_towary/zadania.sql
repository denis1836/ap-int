--Tworzenie tabel
CREATE TABLE Towary(
	nazwa TEXT,
	producent VARCHAR(50),
	kolor VARCHAR(100),
	cena MONEY,
	ilosc INT
);

CREATE TABLE Wzorcowa(
	id BIGINT,
	imie VARCHAR(100),
	nazwisko TEXT,
	miasto VARCHAR(100),
	zarobki MONEY
);

--Wstawianie w Towary
INSERT INTO Towary VALUES("Stół", "Gawin", "Biały", 200, 12);
INSERT INTO Towary VALUES("Krzesło", "Gawin", "Brązowy", 100, 23);

--Wstawianie w Wzorcowa
INSERT INTO Wzorcowa VALUES("Jan", "Kowalski", "Wrocław", 500);
INSERT INTO Wzorcowa VALUES("Adam", "Nowicki", "Gdańsk", 1000);
INSERT INTO Wzorcowa VALUES("Magda", "Pawlak", "Trzebnica", 1200);
INSERT INTO Wzorcowa VALUES("Darek", "Pawlak", "Trzebnica", 1500);

--Sprawdzani zarobków powyżej lub równe 1200 
SELECT zarobki FROM Wzorcowa WHERE zarobki>=1200;

--7 Inne zadania:
DELETE FROM Wzorcowa WHERE zarobki=(SELECT MAX(zarobki) FROM Wzorcowa);

--8.Zmieniamy z Wrocławia na Warszawa w Wzorcowa
UPDATE Wzorcowa SET miasto="Warszawa" WHERE miasto="Wrocław";

--9. Operator "AND", działa tak samo jak bramka logiczna AND, czyli w prypadku kiedy oba są TRUE, zwaraca TRUE, w przeciwnym razie zwraca FALSE
SELECT imie, nazwisko FROM Wzorcowa WHERE imie="Adam" AND naziwsko="Nowicki";

--10.Operator "OR", działa tak samo jak bramka logiczna OR, kiedy oba są FALSA, zwraca FALSE, w przeciwnym razie TRUE(przynajmniej jeden na TRUE)
SELECT miasto FROM Wzorcowa WHERE miasto="Wrocław" OR miasto="Trzebnica";

--11.Operator NOT, negunje wprowadzone dane, jeżeli TRUE to FALSE, jeżeli FALSE to TRUE
SELECT nazwisko FROM Wzorcowa WHERE NOT nazwisko="Pawlak";

--12.  Operator IN działa jak kilka za sobą operatorów OR
SELECT miasto FROM Wzorcowa WHERE IN("Gdańsk", "Wrocław");

--13. Pokazuje wszystkie rekordy z wartościamy pomiędzy jednym a drugim
SELECT zarobki FROM Wzorcowa WHERE zarobki BETWEEN 1200 AND 1700;

--14 Działa jak wyrażenie regularne, czyli szuka wszystkich rekordów z podbną zawartością
SELECT nazwisko FROM Wzorcowa WHERE nazwisko LIKE "Kowal" OR "k%";
    SELECT imie FROM Wzorcowa WHERE imie LIKE "m%a";

