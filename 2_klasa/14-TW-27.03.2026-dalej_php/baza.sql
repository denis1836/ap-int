CREATE TABLE Zamowienia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    tel VARCHAR(20),
    adres VARCHAR(255),
    nip VARCHAR(20),
    cart TEXT,
    deliv_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);