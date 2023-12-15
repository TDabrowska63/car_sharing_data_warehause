USE FaktyWypozyczenia
GO

If (object_id('vETLFWypozyczenie') is not null) Drop View vETLFWypozyczenie;
go

CREATE VIEW vETLFWypozyczenie
AS
SELECT
	ID_Samochodu,
	ID_Daty_rozpoczecia,
	ID_Daty_zakonczenia,
	ID_Miejsca_rozpoczecia,
	ID_Miejsca_zakonczenia,
	ID_Inne,
	ID_Uzytkownika,
	ID_Czasu_rozpoczecia,
	ID_Czasu_zakonczenia,
	Ocena_predkosci,
	Ocena_techniki_jazdy,
	Ocena_uzytkownika,
	Driver_Score,
	Przejechane_kilometry
FROM
	(SELECT
		ID_Samochodu = S.ID_Samochodu,
		ID_Daty_rozpoczecia = DR.ID_Daty,
		ID_Daty_zakonczenia = DZ.ID_Daty,
		ID_Miejsca_rozpoczecia = MR.ID_Miejsca,
		ID_Miejsca_zakonczenia = MZ.ID_Miejsca,
		ID_Inne = JUNK.ID_Inne,
		ID_Uzytkownika = U.ID_Uzytkownika,
		ID_Czasu_rozpoczecia = CR.ID_Czasu,
		ID_Czasu_zakonczenia = CZ.ID_Czasu,
		Ocena_predkosci = STO.Ocena_predkosci,
		Ocena_techniki_jazdy = STO.Ocena_techniki_jazdy,
		Ocena_uzytkownika = STO.Ocena_uzytkownika,
		Driver_Score = (STO.Ocena_predkosci + STO.Ocena_techniki_jazdy)/2,
		Przejechane_kilometry = ST1.Przejechane_kilometry
	FROM UrbanDriveSnapshot1.dbo.Wypozyczenia AS ST1
	JOIN dbo.DimData as DR ON 
		DR.Year = DATEPART(Year, ST1.Czas_rozpoczecia) AND
		DR.Miesiac_NO = DATEPART(Month, ST1.Czas_rozpoczecia) AND
		DR.Dzien = DATEPART(Day, ST1.Czas_rozpoczecia)
	JOIN dbo.DimData as DZ ON 
		DZ.Year = DATEPART(Year, ST1.Czas_zakonczenia) AND
		DZ.Miesiac_NO = DATEPART(Month, ST1.Czas_zakonczenia) AND
		DZ.Dzien = DATEPART(Day, ST1.Czas_zakonczenia)
	JOIN dbo.DimCzas as CR ON 
		CR.Godzina = DATEPART(HOUR, ST1.Czas_rozpoczecia)
	JOIN dbo.DimCzas as CZ ON 
		CZ.Godzina = DATEPART(HOUR, ST1.Czas_zakonczenia)
	JOIN dbo.DimInne as JUNK ON 
		JUNK.Typ_uslugi = ST1.Typ AND
		JUNK.Poziom_paliwa = (SELECT 
								CASE
									WHEN ST1.Poziom_paliwa < 50 THEN 'mniej niz pol'
									ELSE 'wiecej niz pol'
								END AS Poziom_paliwa)
	JOIN UrbanDriveSnapshot1.dbo.Uzytkownicy as STU ON
		ST1.ID_Uzytkownika = STU.ID_Uzytkownika
	JOIN dbo.DimUzytkownik as U ON
		U.Nr_Prawa_jazdy = STU.Nr_prawa_jazdy
	JOIN UrbanDriveSnapshot1.dbo.Miejsca as STMR ON 
		ST1.ID_Miejsca_rozpoczecia = STMR.ID_Miejsca
	JOIN UrbanDriveSnapshot1.dbo.Miejsca as STMZ ON 
		ST1.ID_Miejsca_rozpoczecia = STMZ.ID_Miejsca
	JOIN dbo.DimMiejsce as MR ON
		MR.Miasto = STMR.Nazwa_miasta AND
		MR.Czy_miejsce_dedykowane = (SELECT
										CASE 
											WHEN STMR.Czy_miejsce_dedykowane = 'Y' THEN 'TAK'
											ELSE 'NIE'
										END)
	JOIN dbo.DimMiejsce as MZ ON
		MZ.Miasto = STMZ.Nazwa_miasta AND
		MZ.Czy_miejsce_dedykowane = (SELECT
										CASE 
											WHEN STMZ.Czy_miejsce_dedykowane = 'Y' THEN 'TAK'
											ELSE 'NIE'
										END)
	JOIN UrbanDriveSnapshot1.dbo.Samochody as STS ON
		ST1.ID_Samochodu = STS.ID_Samochodu
	JOIN dbo.DimSamochod as S ON
		S.Nr_rejestracyjny = STS.Nr_rejestracyjny 
	JOIN UrbanDriveSnapshot1.dbo.OcenyPrzejazdu as STO ON
		ST1.ID_wypozyczenia = STO.ID_wypozyczenia) AS x
GO

MERGE INTO FWypozyczenie as TT
	USING vETLFWypozyczenie as ST
		ON TT.ID_Samochodu = ST.ID_Samochodu AND
			TT.ID_Daty_rozpoczecia = ST.ID_Daty_rozpoczecia AND
			TT.ID_Daty_zakonczenia = ST.ID_Daty_zakonczenia AND
			TT.ID_Miejsca_rozpoczecia = ST.ID_Miejsca_rozpoczecia AND
			TT.ID_Miejsca_zakonczenia = ST.ID_Miejsca_zakonczenia AND
			TT.ID_Inne = ST.ID_Inne AND
			TT.ID_Uzytkownika = ST.ID_Uzytkownika AND
			TT.ID_Czasu_rozpoczecia = ST.ID_Czasu_rozpoczecia AND
			TT.ID_Czasu_zakonczenia = ST.ID_Czasu_zakonczenia
				WHEN Not Matched
				THEN
					INSERT
					Values (
						ST.ID_Samochodu,
						ST.ID_Daty_rozpoczecia,
						ST.ID_Daty_zakonczenia,
						ST.ID_Miejsca_rozpoczecia,
						ST.ID_Miejsca_zakonczenia,
						ST.ID_Inne,
						ST.ID_Uzytkownika,
						ST.ID_Czasu_rozpoczecia,
						ST.ID_Czasu_zakonczenia,
						ST.Ocena_predkosci,
						ST.Ocena_techniki_jazdy,
						ST.Ocena_uzytkownika,
						ST.Driver_Score,
						ST.Przejechane_kilometry
					)
			;
DROP VIEW vETLFWypozyczenie;
--SELECT * FROM FWypozyczenie