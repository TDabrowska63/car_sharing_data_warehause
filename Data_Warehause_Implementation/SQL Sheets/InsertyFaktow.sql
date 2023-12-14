use FaktyWypozyczenia

INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Rumia', 'TAK');
INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Rumia', 'NIE');
INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Gdynia', 'NIE');
INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Gdañsk', 'TAK');
INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Gdañsk', 'NIE');
INSERT INTO Miejsce(Miasto, Czy_miejsce_dedykowane) VALUES ('Sopot', 'NIE');

INSERT INTO Inne(Typ_uslugi, Poziom_paliwa) VALUES ('calodobowy', 'wiecej niz pol');
INSERT INTO Inne(Typ_uslugi, Poziom_paliwa) VALUES ('calodobowy', 'mniej niz pol');
INSERT INTO Inne(Typ_uslugi, Poziom_paliwa) VALUES ('nieograniczony', 'wiecej niz pol');
INSERT INTO Inne(Typ_uslugi, Poziom_paliwa) VALUES ('nieograniczony', 'mniej niz pol');

INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('ABC1234567890', 'mniej niz 3 lata', 0);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('ABC1234567890', 'wiecej niz 3 lata', 1);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('DEF9876543210', 'mniej niz 3 lata', 1);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('GHI2468135790', 'wiecej niz 3 lata', 1);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('JKL1357924680', 'mniej niz 3 lata', 0);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('JKL1357924680', 'wiecej niz 3 lata', 1);
INSERT INTO Uzytkownik (Nr_Prawa_jazdy, Czas_posiadania_prawa_jazdy, Czy_aktualne) VALUES ('MNO5678901234', 'mniej niz 3 lata', 1);


INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('TAK', '12345678901');
INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('NIE', '98765432109');
INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('TAK', '56789012345');
INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('NIE', '10987654321');
INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('TAK', '23456789012');
INSERT INTO Zgloszenie (Czy_potwierdzone, Nr_telefonu_zglaszajacego) VALUES ('NIE', '54321098765');


INSERT INTO Samochod
VALUES	('Reno', 'Osobowy', 'GBY J0JZW'),
        ('Audi', 'Osobowy', 'GS KCY23'),
        ('Tesla', 'Osobowy', 'GDA H48RP'),
        ('Reno', 'Dostawczy', 'GDA 463WL');

INSERT INTO Czas
VALUES	(14,'Godziny szczytu'),
        (8,'Rano'),
        (23,'Wieczor'),
        (19,'Wieczor'),
        (4, 'Noc'),
        (16, 'Godziny szczytu');

INSERT INTO Daty
VALUES	(2023, 'Czerwiec', 6, 15, 'Czwartek', 4),
        (2023, 'Lipiec', 7, 26, 'Sroda', 3),
        (2023, 'Listopad', 11, 5, 'Niedziela', 7),
        (2023, 'Grudzien', 12, 3, 'Niedziela', 7),
        (2023, 'Grudzien', 12, 5, 'Wtorek', 2);

INSERT INTO Wypozyczenie
VALUES	(1, 1, 1, 1, 2, 1, 1, 1, 6, 4.5, 4.0, 5.0, 4.25, 15),
		(2, 2, 2, 3, 4, 2, 2, 4, 3, 4.0, 3.0, 4.0, 3.5, 31),
		(1, 3, 3, 4, 5, 3, 3, 3, 5, 5.0, 4.0, 5.0, 4.5, 6);

INSERT INTO Zgloszenie_Wypozyczenia
VALUES	(1, 1, 1, 1),
		(1, 1, 6, 2),
		(3, 3, 3, 3);


SELECT * FROM Miejsce;
SELECT * FROM Inne;
SELECT * FROM Uzytkownik;
SELECT * FROM Zgloszenie;
SELECT * FROM Samochod;
SELECT * FROM Czas;
SELECT * FROM Daty;
SELECT * FROM Wypozyczenie;
SELECT * FROM Zgloszenie_Wypozyczenia;