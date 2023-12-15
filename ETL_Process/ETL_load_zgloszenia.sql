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
    FROM 'C:\Users\TH3V1LPL4Y3R\Desktop\etl task\car_sharing_data_warehouse\ETL_Process\zgloszenia1.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
go

If (object_id('vETLDimZgloszenie') is not null) Drop View vETLDimZgloszenie;
go
CREATE VIEW vETLDimZgloszenie
AS
SELECT DISTINCT
	CASE
		WHEN [potwierdzone] = 'Y' THEN 'TAK'
		ELSE 'NIE'
	END AS [Czy_potwierdzone],
	[nr_telefonu] as [Nr_telefonu_zglaszajacego]
FROM dbo.ZgloszeniaTmp
;
go

MERGE INTO DimZgloszenie as TT
	USING vETLDimZgloszenie as ST
		ON TT.Czy_potwierdzone = ST.Czy_potwierdzone
		AND TT.Nr_telefonu_zglaszajacego = ST.Nr_telefonu_zglaszajacego
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.Czy_potwierdzone,
					ST.Nr_telefonu_zglaszajacego
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Drop View vETLDimZgloszenie;