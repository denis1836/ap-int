-- 1. tworzenie tabel
CREATE TABLE Dzialy (
    nr_dzialu INTEGER PRIMARY KEY,
    nazwa_dzialu TEXT,
    lokalizacja TEXT
);

CREATE TABLE Pracownicy (
    id_pracownika INTEGER PRIMARY KEY,
    imie TEXT,
    nazwisko TEXT,
    stanowisko TEXT,
    zarobek INTEGER,
    nr_dzialu INTEGER REFERENCES Dzialy(nr_dzialu)
);

-- 2. wstawianie danych do tabel
INSERT INTO Dzialy VALUES
(10, 'Ksiegowość', 'Katowice'),
(20, 'Badania', 'Warszawa'),
(30, 'Sprzedaż', 'Poznań'),
(40, 'Operacje', 'Gdańsk');

INSERT INTO Pracownicy VALUES
(7369, 'Marcin', 'Smitko', 'Urzędnik', 800, 20),
(7499, 'Wojtek', 'Allen', 'Sprzedawca', 1600, 30),
(7521, 'Lukasz', 'Ward', 'Sprzedawca', 1250, 30),
(7566, 'Damian', 'Jonas', 'Kierownik', 2975, 20),
(7654, 'Adam', 'Martin', 'Sprzedawca', 1250, 30),
(7698, 'Jakub', 'Blacki', 'Kierownik', 2850, 10),
(7782, 'Piotr', 'Celarek', 'Kierownik', 2450, 10),
(7788, 'Marcin', 'Skotnik', 'Analityk', 3000, 20),
(7839, 'Tomek', 'King', 'Prezes', 5000, 10),
(7844, 'Michał', 'Turner', 'Sprzedawca', 1500, 30),
(7876, 'Adam', 'Adamczyk', 'Urzędnik', 1100, 20),
(7900, 'Marcin', 'Jamski', 'Urzędnik', 950, 30);

-- 3. liczba osób na stanowiskach oprócz prezesa ze średnią pensją w wymaganej kolejności
SELECT 'średnia pensja=' , ROUND(AVG(zarobek),2), COUNT(*), 'pracownik(ów) na stanowisku', stanowisko
FROM Pracownicy
WHERE stanowisko != 'Prezes'
GROUP BY stanowisko;

-- 4. pracownicy z działu 10 lub 30 na ddwa sposoby
-- sposób z OR
SELECT * FROM Pracownicy WHERE nr_dzialu = 10 OR nr_dzialu = 30;
--sposób z IN
SELECT * FROM Pracownicy WHERE nr_dzialu IN (10, 30);

-- 5. pracownicy których pensja równa się prowizji (brak kolumny prowizja w tabeli)
-- nie da się wykonać bez dodania kolumny

-- 6.pracownicy o imieniu macin, wojtek lub adam, posortowani po imieniu bez nazwy kolumny
-- sposób z IN
SELECT * FROM Pracownicy 
WHERE imie IN ('marcin', 'wojtek', 'adam') 
ORDER BY 2;
-- sposób z OR
SELECT * FROM Pracownicy 
WHERE imie = 'marcin' OR imie = 'wojtek' OR imie = 'adam' 
ORDER BY 2;  

-- 7. Pracownicy z pensją 2000-3000 dwa sposoby
-- sposób z AND
SELECT * FROM Pracownicy WHERE zarobek >= 2000 AND zarobek <= 3000;
-- sposób z BETWEEN
SELECT * FROM Pracownicy WHERE zarobek BETWEEN 2000 AND 3000;

-- 8. Pracownicy z działu 10 lub 30 i nazwisko kończy się na "er" 2 sposoby
-- sposób z IN
SELECT * FROM Pracownicy 
WHERE nr_dzialu IN (10, 30) 
AND UPPER(nazwisko) LIKE '%er';  
-- sposób z OR
SELECT * FROM Pracownicy 
WHERE (nr_dzialu = 10 OR nr_dzialu = 30) 
AND UPPER(nazwisko) LIKE '%er';

-- 9. Pracownicy których id zaczyna się od 77
SELECT * FROM Pracownicy 
WHERE id_pracownika >= 7700 AND id_pracownika < 7800;

-- 10. nazwy działów w których pracują urzędnicy
SELECT DISTINCT d.nazwa_dzialu 
FROM Dzialy d 
JOIN Pracownicy p ON d.nr_dzialu = p.nr_dzialu 
WHERE p.stanowisko = 'urzednik';

-- 11. lista pracowników z danymi działu, posortowana po numerze działu
SELECT p.*, d.nazwa_dzialu, d.lokalizacja 
FROM Pracownicy p 
JOIN Dzialy d ON p.nr_dzialu = d.nr_dzialu 
ORDER BY p.nr_dzialu;

-- 12. wszystkie działy i nazwiska ich kierowników
SELECT d.nazwa_dzialu, p.nazwisko 
FROM Dzialy d 
LEFT JOIN Pracownicy p ON d.nr_dzialu = p.nr_dzialu AND p.stanowisko = 'kierownik';

-- 13. pracwnicy zarabiający poniżej średniej pensji
SELECT * FROM Pracownicy 
WHERE zarobek < (SELECT AVG(zarobek) FROM Pracownicy);

-- 14. pracownicy pracujący w warszawie
SELECT p.* 
FROM Pracownicy p 
JOIN Dzialy d ON p.nr_dzialu = d.nr_dzialu 
WHERE UPPER(d.lokalizacja) = 'WARSZAWA';

-- 15. nazwiska pracowników zarabiających powyżej średniej
SELECT nazwisko 
FROM Pracownicy 
WHERE zarobek > (SELECT AVG(zarobek) FROM Pracownicy);

-- 16. suma pensji pracowników z katowic
SELECT SUM(p.zarobek) 
FROM Pracownicy p 
JOIN Dzialy d ON p.nr_dzialu = d.nr_dzialu 
WHERE UPPER(d.lokalizacja) = 'KATOWICE';