CREATE DATABASE FaktyWypozyczenia

use FaktyWypozyczenia
--drop database FaktWypozyczenia

CREATE TABLE DimSamochod
(
    ID_Samochodu INT IDENTITY(1,1) PRIMARY KEY,
    Marka VARCHAR(20),
    Typ VARCHAR(10) CHECK(Typ='Osobowy' OR Typ='Dostawczy'),
    Nr_rejestracyjny VARCHAR(9),
);

CREATE TABLE DimCzas
(
    ID_Czasu INT IDENTITY(1,1) PRIMARY KEY,
    Godzina INT CHECK(Godzina >= 0 AND Godzina <=23),
    Pora_Dnia VARCHAR(20) CHECK(Pora_dnia in ('Rano', 'Poludnie', 'Godziny szczytu', 'Wieczor', 'Noc')),
);

CREATE TABLE DimData
(
    ID_Daty INT IDENTITY(1,1) PRIMARY KEY,
    Year VARCHAR(4),
    Month VARCHAR(10),
	Miesiac_NO INT CHECK(Miesiac_NO >= 1 AND Miesiac_NO <=12),
    Dzien INT CHECK(Dzien >= 1 AND Dzien <= 31),
    DayOfWeek VARCHAR(15),
	Dzien_tygodnia_NO INT CHECK(Dzien_tygodnia_NO >= 1 AND Dzien_tygodnia_NO <= 7),
);

CREATE TABLE DimZgloszenie
(
    ID_Zgloszenia INT IDENTITY(1,1) PRIMARY KEY,
    Czy_potwierdzone VARCHAR(3) CHECK(Czy_potwierdzone in ('TAK','NIE')),
    Nr_telefonu_zglaszajacego VARCHAR(11),

);

CREATE TABLE DimInne
(
	ID_Inne INT IDENTITY(1,1) PRIMARY KEY,
	Typ_uslugi VARCHAR(20) CHECK(Typ_uslugi in ('calodobowy', 'nieograniczony')),
	Poziom_paliwa VARCHAR(20) CHECK(Poziom_paliwa in ('wiecej niz pol', 'mniej niz pol')),
);

CREATE TABLE DimMiejsce
(
	ID_Miejsca INT IDENTITY(1,1) PRIMARY KEY,
	Miasto VARCHAR(20),
	Czy_miejsce_dedykowane VARCHAR(3) CHECK(Czy_miejsce_dedykowane in ('TAK', 'NIE')),
);

CREATE TABLE DimUzytkownik
(
	ID_Uzytkownika INT IDENTITY(1,1) PRIMARY KEY,
	Nr_Prawa_jazdy CHAR(13),
	Czas_posiadania_prawa_jazdy VARCHAR(20) CHECK(Czas_posiadania_prawa_jazdy in('mniej niz 3 lata', 'wiecej niz 3 lata')),
	Czy_aktualne INT CHECK(Czy_aktualne in (0, 1))
);

CREATE TABLE FWypozyczenie
(
	ID_Wypozyczenia INT IDENTITY(1,1) PRIMARY KEY,
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

	FOREIGN KEY(ID_Samochodu) REFERENCES DimSamochod(ID_Samochodu),
	FOREIGN KEY(ID_Daty_rozpoczecia) REFERENCES DimData(ID_Daty),
	FOREIGN KEY(ID_Daty_zakonczenia) REFERENCES DimData(ID_Daty),
	FOREIGN KEY(ID_Miejsca_rozpoczecia) REFERENCES DimMiejsce(ID_Miejsca),
	FOREIGN KEY(ID_Miejsca_zakonczenia) REFERENCES DimMiejsce(ID_Miejsca),
	FOREIGN KEY(ID_Inne) REFERENCES DimInne(ID_Inne),
	FOREIGN KEY(ID_Uzytkownika) REFERENCES DimUzytkownik(ID_Uzytkownika),
	FOREIGN KEY(ID_Czasu_rozpoczecia) REFERENCES DimCzas(ID_Czasu),
	FOREIGN KEY(ID_Czasu_zakonczenia) REFERENCES DimCzas(ID_Czasu),
);

CREATE TABLE FZgloszenieWypozyczenia
(
    ID_Daty_Zgloszenia INT,
    ID_Wypozyczenia INT,
    ID_Czasu_Zgloszenia INT,
    ID_Zgloszenia INT,

    PRIMARY KEY(ID_Daty_Zgloszenia, ID_Wypozyczenia, ID_Czasu_Zgloszenia, ID_Zgloszenia),
    FOREIGN KEY(ID_Daty_Zgloszenia) REFERENCES DimData(ID_Daty),
    FOREIGN KEY(ID_Wypozyczenia) REFERENCES FWypozyczenie(ID_Wypozyczenia),
    FOREIGN KEY(ID_Czasu_Zgloszenia) REFERENCES DimCzas(ID_Czasu),
    FOREIGN KEY(ID_Zgloszenia) REFERENCES DimZgloszenie(ID_Zgloszenia),
);

Select * from DimData


									

			
