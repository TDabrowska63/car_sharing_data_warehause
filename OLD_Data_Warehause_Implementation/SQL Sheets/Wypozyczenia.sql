CREATE DATABASE FaktyWypozyczenia

use FaktyWypozyczenia
-- drop database FaktWypozyczenia

CREATE TABLE Samochod
(
    ID_Samochodu INT IDENTITY(1,1) PRIMARY KEY,
    Marka VARCHAR(20),
    Typ VARCHAR(10) CHECK(Typ='Osobowy' OR Typ='Dostawczy'),
    Nr_rejestracyjny VARCHAR(10),
);

CREATE TABLE Czas
(
    ID_Czasu INT IDENTITY(1,1) PRIMARY KEY,
    Godzina INT CHECK(Godzina >= 0 AND Godzina <=23),
    Pora_Dnia VARCHAR(20) CHECK(Pora_dnia in ('Rano', 'Poludnie', 'Godziny szczytu', 'Wieczor', 'Noc')),
);

CREATE TABLE Daty
(
    ID_Daty INT IDENTITY(1,1) PRIMARY KEY,
    Rok INT CHECK(Rok >= 2016),
    Miesiac VARCHAR(10) CHECK(Miesiac in ('Styczen','Luty','Marzec','Kwiecien','Maj','Czerwiec', 
                                'Lipiec','Sierpien','Wrzesien','Pazdziernik','Listopad','Grudzien')),
    Miesiac_NO INT CHECK(Miesiac_NO >= 1 AND Miesiac_NO <=12),
    Dzien INT CHECK(Dzien >= 1 AND Dzien <= 31),
    Dzien_tygodnia VARCHAR(10) CHECK(Dzien_tygodnia in ('Poniedzialek','Wtorek','Sroda','Czwartek','Piatek','Sobota','Niedziela')),
    Dzien_tygodnia_NO INT CHECK(Dzien_tygodnia_NO >= 1 AND Dzien_tygodnia_NO <= 7),


);

CREATE TABLE Zgloszenie
(
    ID_Zgloszenia INT IDENTITY(1,1) PRIMARY KEY,
    Czy_potwierdzone VARCHAR(3) CHECK(Czy_potwierdzone in ('TAK','NIE')),
    Nr_telefonu_zglaszajacego VARCHAR(11),
);

CREATE TABLE Inne
(
ID_Inne INT IDENTITY(1,1),
Typ_uslugi VARCHAR(20) CHECK(Typ_uslugi in ('calodobowy', 'nieograniczony')),
Poziom_paliwa VARCHAR(20) CHECK(Poziom_paliwa in ('wiecej niz pol', 'mniej niz pol')),

PRIMARY KEY (ID_Inne)
);

CREATE TABLE Miejsce
(
ID_Miejsca INT IDENTITY(1,1),
Miasto VARCHAR(20),
Czy_miejsce_dedykowane VARCHAR(3) CHECK(Czy_miejsce_dedykowane in ('TAK', 'NIE')),
PRIMARY KEY (ID_Miejsca)
);

CREATE TABLE Uzytkownik
(
ID_Uzytkownika INT IDENTITY(1,1),
Nr_Prawa_jazdy CHAR(13),
Czas_posiadania_prawa_jazdy VARCHAR(20) CHECK(Czas_posiadania_prawa_jazdy in('mniej niz 3 lata', 'wiecej niz 3 lata')),
Czy_aktualne INT CHECK(Czy_aktualne in (0, 1))

PRIMARY KEY(ID_Uzytkownika)
);

CREATE TABLE Wypozyczenie
(
ID_Wypozyczenia INT IDENTITY(1,1),
ID_Samochodu INT,
ID_Daty_rozpoczecia INT,
ID_Daty_zakonczenia INT,
ID_Miejsca_rozpoczecia INT,
ID_Miejsca_zakonczenia INT,
ID_Inne INT,
ID_Uzytkownika INT,
ID_Czasu_rozpoczecia INT,
ID_Czasu_zakonczenia INT,
Ocena_predkosci FLOAT CHECK(Ocena_predkosci >= 0 AND Ocena_predkosci <= 5),
Ocena_techniki_jazdy FLOAT CHECK(Ocena_techniki_jazdy >= 0 AND Ocena_techniki_jazdy <= 5),
Ocena_uzytkownika FLOAT CHECK(Ocena_uzytkownika >= 0 AND Ocena_uzytkownika <= 5),
Driver_Score FLOAT CHECK(Driver_Score >= 0 AND Driver_Score <= 5),
Przejechane_kilometry INT CHECK(Przejechane_kilometry >= 0),

PRIMARY KEY(ID_Wypozyczenia),
FOREIGN KEY(ID_Samochodu) REFERENCES Samochod(ID_Samochodu),
FOREIGN KEY(ID_Daty_rozpoczecia) REFERENCES Daty(ID_Daty),
FOREIGN KEY(ID_Daty_zakonczenia) REFERENCES Daty(ID_Daty),
FOREIGN KEY(ID_Miejsca_rozpoczecia) REFERENCES Miejsce(ID_Miejsca),
FOREIGN KEY(ID_Miejsca_zakonczenia) REFERENCES Miejsce(ID_Miejsca),
FOREIGN KEY(ID_Inne) REFERENCES Inne(ID_Inne),
FOREIGN KEY(ID_Uzytkownika) REFERENCES Uzytkownik(ID_Uzytkownika),
FOREIGN KEY(ID_Czasu_rozpoczecia) REFERENCES Czas(ID_Czasu),
FOREIGN KEY(ID_Czasu_zakonczenia) REFERENCES Czas(ID_Czasu),
);

CREATE TABLE Zgloszenie_Wypozyczenia
(
    ID_Daty_Zgloszenia INT,
    ID_Wypozyczenia INT,
    ID_Czasu_Zgloszenia INT,
    ID_Zgloszenia INT,

    PRIMARY KEY(ID_Daty_Zgloszenia, ID_Wypozyczenia, ID_Czasu_Zgloszenia, ID_Zgloszenia),
    FOREIGN KEY(ID_Daty_Zgloszenia) REFERENCES Daty(ID_Daty),
    FOREIGN KEY(ID_Wypozyczenia) REFERENCES Wypozyczenie(ID_Wypozyczenia),
    FOREIGN KEY(ID_Czasu_Zgloszenia) REFERENCES Czas(ID_Czasu),
    FOREIGN KEY(ID_Zgloszenia) REFERENCES Zgloszenie(ID_Zgloszenia),
);

