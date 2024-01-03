USE FaktyWypozyczenia
GO

If (object_id('dbo.ZgloszeniaTmp') is not null) DROP TABLE dbo.ZgloszeniaTmp;
CREATE TABLE dbo.ZgloszeniaTmp(id_pracownika varchar(100), 
                                data_wpisu varchar(10),
                                godzina_wpisu  varchar(8),
                                imie varchar(30),
                                nazwisko varchar(30),
                                nr_telefonu varchar(9),
                                id_zgloszenia varchar(100),
                                zglaszany_numer_rejestracyjny varchar(10),
                                powod varchar(3),
                                potwierdzone varchar(1));
go

BULK INSERT dbo.ZgloszeniaTmp
    FROM 'C:\Users\TH3V1LPL4Y3R\Desktop\DW\car_sharing_data_warehouse\ETL_Process\zgloszenia1.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
go

If (object_id('vETLWypSamDatTmp') is not null) Drop View vETLWypSamDatTmp;
go

CREATE VIEW vETLWypSamDatTmp
AS
SELECT DISTINCT
	ID_Wypozyczenia = FW.ID_Wypozyczenia,
	Nr_rejestracyjny = S.Nr_rejestracyjny,
	Data_rozpoczecia = CAST(CONCAT(DR.Year, '-', DR.Miesiac_NO, '-', DR.Dzien) AS DATE),
	Data_zakonczenia = CAST(CONCAT(DZ.Year, '-', DZ.Miesiac_NO,'-', DZ.Dzien) AS DATE),
	Godzina_rozpoczecia = CR.Godzina,
	Godzina_zakonczenia = CZ.Godzina
FROM dbo.FWypozyczenie AS FW
JOIN dbo.DimSamochod AS S ON
	FW.ID_Samochodu = S.ID_Samochodu
JOIN dbo.DimData AS DR ON
	FW.ID_Daty_rozpoczecia = DR.ID_Daty
JOIN dbo.DimData AS DZ ON
	FW.ID_Daty_zakonczenia = DZ.ID_Daty
JOIN dbo.DimCzas AS CR ON 
	FW.ID_Czasu_rozpoczecia = CR.ID_Czasu
JOIN dbo.DimCzas AS CZ ON 
	FW.ID_Czasu_zakonczenia = CZ.ID_Czasu

GO


If (object_id('vETLFZgloszenieWypozyczenia') is not null) Drop View vETLFZgloszenieWypozyczenia;
go

CREATE VIEW vETLFZgloszenieWypozyczenia
AS
SELECT
	ID_Daty_Zgloszenia,
    ID_Wypozyczenia,
    ID_Czasu_Zgloszenia,
    ID_Zgloszenia
FROM
	(SELECT
		ID_Daty_Zgloszenia = DZ.ID_Daty,
		ID_Wypozyczenia = TMP.ID_Wypozyczenia,
		ID_Czasu_Zgloszenia = CZ.ID_Czasu,
		ID_Zgloszenia = Z.ID_Zgloszenia
	FROM dbo.ZgloszeniaTmp as STZ
	JOIN vETLWypSamDatTmp as TMP ON
		TMP.Nr_rejestracyjny = STZ.zglaszany_numer_rejestracyjny AND 
		STZ.data_wpisu BETWEEN TMP.Data_rozpoczecia AND TMP.Data_zakonczenia AND
		CAST(substring(STZ.godzina_wpisu, 1 , 2) AS INT) BETWEEN TMP.Godzina_rozpoczecia AND TMP.Godzina_zakonczenia	
	JOIN dbo.DimData as DZ ON
		DZ.Year = DATEPART(Year, STZ.data_wpisu) AND
		DZ.Miesiac_NO = DATEPART(Month, STZ.data_wpisu) AND
		DZ.Dzien = DATEPART(Day, STZ.data_wpisu)
	JOIN dbo.DimCzas as CZ ON
		CZ.Godzina = CAST(substring(STZ.godzina_wpisu, 1 , 2) AS INT)
	JOIN dbo.DimZgloszenie as Z ON
		Z.Nr_telefonu_zglaszajacego = STZ.nr_telefonu AND
		Z.Czy_potwierdzone = (SELECT
								CASE 
									WHEN STZ.potwierdzone = 'Y' THEN 'TAK'
									ELSE 'NIE'
								END)
	) AS x
GO

SELECT * FROM vETLFZgloszenieWypozyczenia

MERGE INTO FZgloszenieWypozyczenia as TT
	USING vETLFZgloszenieWypozyczenia as ST
		ON TT.ID_Daty_Zgloszenia = ST.ID_Daty_Zgloszenia AND
		TT.ID_Wypozyczenia = ST.ID_Wypozyczenia AND
		TT.ID_Czasu_Zgloszenia = ST.ID_Czasu_Zgloszenia AND
		TT.ID_Zgloszenia = ST.ID_Zgloszenia
			WHEN Not Matched
			THEN
				INSERT
				Values (
				ST.ID_Daty_Zgloszenia,
				ST.ID_Wypozyczenia,
				ST.ID_Czasu_Zgloszenia,
				ST.ID_Zgloszenia
				) ;


Drop View vETLFZgloszenieWypozyczenia;
Drop View vETLWypSamDatTmp;
Drop Table dbo.ZgloszeniaTmp;