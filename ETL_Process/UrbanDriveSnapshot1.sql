CREATE DATABASE UrbanDriveSnapshot1

use UrbanDriveSnapshot1

CREATE TABLE Miejsca
(
ID_Miejsca INT PRIMARY KEY,
Wspolrzedne VARCHAR(100) NOT NULL,
Nazwa_miasta VARCHAR(50) NOT NULL,
Czy_miejsce_dedykowane CHAR(1) NOT NULL CHECK(Czy_miejsce_dedykowane in ('Y', 'N'))
)

CREATE TABLE Samochody
(
ID_Samochodu INT PRIMARY KEY,
Nr_rejestracyjny CHAR(9),
Marka VARCHAR(20) NOT NULL,
Typ CHAR(20) NOT NULL CHECK (Typ in ('Osobowy', 'Dostawczy'))
)

CREATE TABLE Uzytkownicy
(
ID_Uzytkownika INT PRIMARY KEY,
Nr_prawa_jazdy CHAR(13),
Imie VARCHAR(20) NOT NULL,
Nazwisko VARCHAR(20) NOT NULL,
Miasto_zamieszkania VARCHAR(20) NOT NULL,
Czas_posiadania_prawa_jazdy INT
)

CREATE TABLE Wypozyczenia
(
ID_wypozyczenia INT PRIMARY KEY,
Typ VARCHAR(15) NOT NULL CHECK(Typ in ('calodobowy', 'nieograniczony')),
Czas_rozpoczecia DATE NOT NULL,
Czas_zakonczenia DATE DEFAULT NULL,
Przebieg INT,
Poziom_paliwa INT CHECK(Poziom_paliwa >=0 AND Poziom_paliwa<=100),
Przejechane_kilometry INT,
ID_Samochodu INT,
ID_Uzytkownika INT,
ID_Miejsca_rozpoczecia INT,
ID_Miejsca_zakonczenia INT,

FOREIGN KEY (ID_Samochodu) REFERENCES Samochody(ID_Samochodu),
FOREIGN KEY (ID_Uzytkownika) REFERENCES Uzytkownicy(ID_Uzytkownika),
FOREIGN KEY (ID_Miejsca_rozpoczecia) REFERENCES Miejsca(ID_Miejsca),
FOREIGN KEY (ID_Miejsca_zakonczenia) REFERENCES Miejsca(ID_Miejsca)
)

CREATE TABLE OcenyPrzejazdu
(
ID_wypozyczenia INT PRIMARY KEY,
Ocena_predkosci FLOAT CHECK(Ocena_predkosci >= 0 AND Ocena_predkosci <= 5),
Ocena_techniki_jazdy FLOAT CHECK(Ocena_techniki_jazdy >= 0 AND Ocena_techniki_jazdy <= 5),
Ocena_uzytkownika FLOAT CHECK(Ocena_uzytkownika >= 0 AND Ocena_uzytkownika <= 5),
Powod INT CHECK(Powod >= 0 AND Powod <= 27),

FOREIGN KEY (ID_wypozyczenia) REFERENCES Wypozyczenia(ID_wypozyczenia)
)

BULK INSERT dbo.Samochody FROM "C:\Users\Flamaster333\Projects\car_sharing_data_warehouse\ETL_Process\Bulks\cars.bulk" WITH (FIELDTERMINATOR='|') --manually set
BULK INSERT dbo.Uzytkownicy FROM "C:\Users\Flamaster333\Projects\car_sharing_data_warehouse\ETL_Process\Bulks\users.bulk" WITH (FIELDTERMINATOR='|') --manually set
BULK INSERT dbo.Miejsca FROM "C:\Users\Flamaster333\Projects\car_sharing_data_warehouse\ETL_Process\Bulks\places.bulk" WITH (FIELDTERMINATOR='|') --manually set
BULK INSERT dbo.Wypozyczenia FROM "C:\Users\Flamaster333\Projects\car_sharing_data_warehouse\ETL_Process\Bulks\rents.bulk" WITH (FIELDTERMINATOR='|') --manually set
BULK INSERT dbo.OcenyPrzejazdu FROM "C:\Users\Flamaster333\Projects\car_sharing_data_warehouse\ETL_Process\Bulks\opinions.bulk" WITH (FIELDTERMINATOR='|') --manually set

select * from Miejsca
select * from Wypozyczenia
select * from Uzytkownicy
select * from OcenyPrzejazdu
select * from Samochody

/*
drop TABLE Miejsca
drop TABLE Wypozyczenia
drop TABLE Uzytkownicy
drop TABLE OcenyPrzejazdu
drop TABLE Samochody


drop database UrbanDrive

*/