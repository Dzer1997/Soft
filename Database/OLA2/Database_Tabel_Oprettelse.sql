CREATE TABLE Medlemskab (
    Medlemskab_id INT PRIMARY KEY AUTO_INCREMENT,
    Medlemskabstype ENUM('Basis', 'Premium', 'Elite') NOT NULL,
    Pris INT NOT NULL,
    Fordele VARCHAR(100)
);

CREATE TABLE Medlem (
    Medlem_id INT PRIMARY KEY AUTO_INCREMENT,
    Navn VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefon INT,
    Medlemskab_id INT,
    FOREIGN KEY (Medlemskab_id) REFERENCES Medlemskab(Medlemskab_id)
);

CREATE TABLE Instruktør (
    Instruktør_id INT PRIMARY KEY AUTO_INCREMENT,
    Navn VARCHAR(100) NOT NULL,
    Specialitet VARCHAR(100)
);

CREATE TABLE Træningshold (
    Hold_id INT PRIMARY KEY AUTO_INCREMENT,
    Navn VARCHAR(100) NOT NULL,
    Kalender VARCHAR(100),
    MaxDeltagere INT,
    Instruktør_id INT,
    Lokale VARCHAR(100),
    FOREIGN KEY (Instruktør_id) REFERENCES Instruktør(Instruktør_id)
);

CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY AUTO_INCREMENT,
    Medlem_id INT,
    Hold_id INT,
    Booking_date DATETIME NOT NULL,
    Status ENUM('Bekræftet', 'Venteliste') NOT NULL,
    FOREIGN KEY (Medlem_id) REFERENCES Medlem(Medlem_id),
    FOREIGN KEY (Hold_id) REFERENCES Træningshold(Hold_id)
);

CREATE TABLE Betaling (
    Betalings_id INT PRIMARY KEY AUTO_INCREMENT,
    Medlem_id INT,
    Beløb DOUBLE NOT NULL,
    Betalingsdato DATETIME NOT NULL,
    Betalingstype VARCHAR(100),
    Medlemsrabat INT,
    FOREIGN KEY (Medlem_id) REFERENCES Medlem(Medlem_id)
);
