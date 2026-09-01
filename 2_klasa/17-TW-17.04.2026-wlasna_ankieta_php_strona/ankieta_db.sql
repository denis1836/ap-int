CREATE TABLE IF NOT EXISTS Odpowiedzi(
    ID_odpowiedzi BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    imie VARCHAR(64) NOT NULL,
    nazwisko VARCHAR(64) NOT NULL,
    plec VARCHAR(4),
    wiek VARCHAR(8),
    muzyka VARCHAR(32),
    browser VARCHAR(32),
    komentarz TEXT
)