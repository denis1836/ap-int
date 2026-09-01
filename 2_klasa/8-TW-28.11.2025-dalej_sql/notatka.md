# NOTATKA Z PREZENTACJI WINIARKSIEGO

## Sortowanie:
```mySQL
SELECT * FROM Produkt
ORDER BY nazwa_produktu ASC , stan_magazynowy DESC;
```
## Grupowanie:
```mySQL
SELECT nazwa
FROM Produkt
GROUP BY nazwa;
```
## Połączenie wewnętrzne:
INNER JOIN - wybiera rekordy, które mają pasujące wartości w obu tabelach

```mySQL
SELECT stoły.nazwa, krzesła.nazwa
FROM stoły INNER JOIN krzesła
ON stoły.kolor = krzesła.kolor;
```
FULL OUTER JOIN - zwraca wszystkie rekordy, jeśli pasują do nich rekordy z lewwej lub prawej tabeli

```mySQL
SELECT nazwa_kolumny
FROM tabeka1
FULL OUTER JOIN tabela2
ON tabela1.column_name = tabela2.column_name
WHERE warunek;
```

UNION - służy do łączenia zestawu wyników dwóch lub więcej SELECT'ów, automatycznie usuwa zduplikowane wiersze z zestawu wyników

Wymagania UNION:
* Każde SELECT polecenie UNION musi mieć taką samą liczbę kolumn
* Kolumny muszą mieć również podobne typy danych
* Kolumny w każdym SELECT polecniu muszą być również w tej samej kolejności

```mySQL
SELECT nazwa_kolumny FROM tabela1
UNION
SELECT nazwa_kolumny FROM tabela2
```

UNION ALL - służy do łączenia zestawu wyników dwóch lub więcej SELECT'ów, uwzględnia wszystkie wiersze z każdgo polecnie łącznie z duplikatami

Wymagania dla UNION ALL:
* Każde SELECT polecenie UNION ALL musi mieć taką samą liczbę kolumn
* Kolumny muszą mieć również podbne typy danych
* Kolumny w kadym SELECT polecneiu muszą być również w tej samej kolejnośći

```mySQL
SELECT nazwa_kolumny FROM tabela1
UNION ALL
SELECT nazwa_kolumny FROM tabela2
```

GROUP BY - grupuje wiersze o tych samych wartościach w wiersze podsumuwujące

```mySQL
SELECT nazwa_kolumny
FROM nazwa_tabeli
WHERE warunek
GROUP BY nazwa_kolumny
ORDER BY nazwa_kolumny;
```

HAVING - dodano do języka SQL, ponieważ WHERE słowa kluczowego nie można używać z funkcjami agregującymi

```mySQL
SELECT nazwa_tabeli
FROM nazwa_tabeli
GROUP BY nazwa_kolumny
HAVING warunek
ORDER BY nazwa_kolumny;
```

EXISTS - służy do sprawdzenia czy w podzapytaniu istnieje jakiś rekord

```mySQL
SELECT nazwa_kolumny
FROM nazwa_tabeli
WHERE EXISTS
(
 SELECT nazwa_kolumny 
 FROM nazwa_tabeli
 WHERE warunek
);
```

ANY - zwraca wartość logiczną jako wynik, zwaraca TRUE jeśli jakakolwiek z wartości podzapytania spełnia warunek
**Musi** być standardowy operator porównania (=, <>, !=, >, >=, <, <=, ==)

```mySQL
SELECT nazwa_kolumny
FROM nazwa_tabeli
WHERE warunek ANY
(SELECT nazwa_kolumny
FROM nazwa_tabeli
WHERE warunek);
```

ALL - zwara wartośc logiczną jako wynik, zwara TRUE jeśli wszystkie wartości podzapytania spełniają warunek, jest używaay z __SELECT__, __WHERE__ i __HAVING__

```mySQL
SELECT nazwa_kolumny
FROM nazwa_tabeli
WHERE warunek ALL
(
 SELECT nazwa_kolumny
 FROM nazwa_tabeli
 WHERE warunek
);
```

SELECT INTO - kopiuje dane z jednej tabeli do nowej tabeli

```mySQL
SELECT *
INTO nowa_tabela [IN ...]
FROM stara_tabela
WHERE warunek;
```

INSERT INTO SELECT - pelecnie kopiuje dane z jednej tabeli i wstawia je do innej tabeli, wymaga aby typy danych w tabeli źródłowej i docelowej były zgodne

```mySQL

```

CASE - wyrażenie przechodzi przez warunki i zwara wartość gdy pierwszy warunek zostanie spełniony. Gdy to się stanie, zwaraca wynik, jeśli żaden, to użyje klausli ELSE, jeśli jej nie ma to NULL

```mySQL
CASE
    WHEH warunek1 THEN wynik1
    WHEN warunek2 THEN wynik2
    WHEN warunek3 THEN wynik3
    ELSE wynikElse
END;
```

## Procedury:

* Procedura składowana to składowanie gotowego kodu SQL, który można zapisać i dzięki czemu go można wielokrotnie korzystać 
* Jeżeli masz zapytanie SQL, które piszesz wielorotnie, zapisz je jako procedure składowaną
* Możesz również przekazywać parametry do procedury tak aby działa na ich podstawie

```mySQL
CREATE PROCEDURE nazwa_procedury
AS
sql_zapytanie_poleceie
GO;

EXEC nazwa_procedury;
```

## Komentarze:

* Komentarze jednowierszowe zaczynają się od "--"
* Każdy tekst pomiędzy znakiem "--' a końcek wiersza zostanie zigorowany

## Backup:

BACKUP DATABASE - polecenie jest używane w SQL Server dla utowrzenia pełnej kopii istnięjącej bazy SQL

```mySQL
BACKUP DATABASE nazwa_bazy_danych
TO DISK = "/path/to/dir";
```

Kopia zapasowa rożnicowa obejmuje tylko to co uległo zmianie od ostatniej pełnej kopii.

```mySQL
BACKUP DATABASE nazwa_bazy_danych
TO DISK = "/path/to/dir";
WITH DIFFRENTIAL;
```

## Widok:

* W SQL wido jest wirutalną tabelą opartą na zestawie wyników polecenia SQL
* Widok zawiera wiersze i kolumny, tak jak prawdziwa tabela. ola w widoku pochodzą z jedej lub kilku rzeczywistych tabel w bazie danych
* Do widoku można dodawać polecnie i funkcje SQL, a także prezentować dane tak, jakby pochodziły z jednej tabeli
* Widok jest tworzony za pomocą polecenia CREATE VIEW

```mySQL
CREATE VIEW nazwa_widoku AS
SELECT kolumna1, kolumna2, …
FROM nazwa_tabeli
WHERE warunek;
```

## Join'y:
 
INNER JOIN  - zwraca tylko rekordy, które mają pasujące wartości w obu tabelach czyli część wspólną

```mySQL
SELECT klienci.imie, zamowienia.id_zamowienia
FROM klienci
INNER JOIN zamowienia
ON klienci.id_klienta = zamowienia.id_klienta;
```

LEFT JOIN (LEFT OUTER JOIN) - zwraca wszystkie rekordy z lewej tabeli + pasujące z prawej, jeśli nie ma dopasowania to kolumny z prawej tabeli będą NULL

```mySQL
SELECT klienci.imie, zamowienia.id_zamowienia
FROM klienci
LEFT JOIN zamowienia
ON klienci.id_klienta = zamowienia.id_klienta;
```

RIGHT JOIN (RIGHT OUTER JOIN) – zwraca wszystkie rekordy z prawej tabeli + pasujące z lewej, jeśli nie ma dopasowania to kolumny z lewej tabeli będą NULL

```mySQL
SELECT klienci.imie, zamowienia.id_zamowienia
FROM klienci
RIGHT JOIN zamowienia
ON klienci.id_klienta = zamowienia.id_klienta;
```

FULL OUTER JOIN - zwraca wszystkie rekordy z obu tabel, MySQL **nie** obsługuje natywnie FULL OUTER JOIN, robimy to przez UNION LEFT i RIGHT JOIN

```mySQL
SELECT klienci.imie, zamowienia.id_zamowienia
FROM klienci
LEFT JOIN zamowienia ON klienci.id_klienta = zamowienia.id_klienta

UNION

SELECT klienci.imie, zamowienia.id_zamowienia
FROM klienci
RIGHT JOIN zamowienia ON klienci.id_klienta = zamowienia.id_klienta
WHERE klienci.id_klienta IS NULL;
```

CROSS JOIN - iloczyn kartezjański, każda kombinacja wierszy z obu tabel (bez warunku ON)

```mySQL
SELECT klienci.imie, produkty.nazwa
FROM klienci
CROSS JOIN produkty;
```

SELF JOIN - łączenie tabeli samej ze sobą (przydatne np. przy hierarchii pracowników)

```mySQL
SELECT a.imie AS Pracownik, b.imie AS Szef
FROM pracownicy a
LEFT JOIN pracownicy b ON a.id_szefa = b.id_pracownika;
```

Wersja z aliasami

```mySQL
SELECT k.imie, z.id_zamowienia, p.nazwa
FROM klienci AS k
INNER JOIN zamowienia AS z ON k.id_klienta = z.id_klienta
INNER JOIN produkty AS p ON z.id_produktu = p.id_produktu;
```

Wiele tabel naraz:

```mySQL
SELECT k.imie, z.data_zamowienia, p.nazwa, s.stan
FROM klienci k
JOIN zamowienia z ON k.id_klienta = z.id_klienta
JOIN szczegoly_zamowienia sz ON z.id_zamowienia = sz.id_zamowienia
JOIN produkty p ON sz.id_produktu = p.id_produktu
JOIN statusy s ON z.id_statusu = s.id_statusu
WHERE z.data_zamowienia >= '2025-01-01';
```

