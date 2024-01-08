USE FaktyWypozyczenia
GO

If (object_id('vETLDimUzytkownik') is not null) Drop View vETLDimUzytkownik;
go
CREATE VIEW vETLDimUzytkownik
AS
SELECT DISTINCT
	[Nr_prawa_jazdy] as [Nr_Prawa_jazdy],
	CASE
		WHEN [Data_uzyskania_prawa_jazdy] < CAST('2020-12-14' as DATE) THEN 'wiecej niz 3 lata'
		ELSE 'mniej niz 3 lata'
	END AS [Czas_posiadania_prawa_jazdy]
FROM UrbanDriveSnapshot1.dbo.Uzytkownicy;
GO

MERGE INTO DimUzytkownik as TT
	USING vETLDimUzytkownik as ST
		ON TT.Nr_Prawa_jazdy = ST.Nr_Prawa_jazdy
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.Nr_Prawa_jazdy,
					ST.Czas_posiadania_prawa_jazdy,
					1
					)
			WHEN Matched -- when PID number match, 
			-- but "czas posiadania prawa jazdy" doesn't...
				AND ST.Czas_posiadania_prawa_jazdy <> TT.Czas_posiadania_prawa_jazdy
			THEN
				UPDATE
				SET TT.Czy_aktualne = 0
			WHEN Not Matched BY Source
			AND TT.Nr_Prawa_jazdy != 'UNKNOWN' -- do not update the UNKNOWN tuple
			THEN
				UPDATE
				SET TT.Czy_aktualne = 0
			;

INSERT INTO DimUzytkownik(
	Nr_Prawa_jazdy,
	Czas_posiadania_prawa_jazdy,
	Czy_aktualne
	)
	SELECT 
		Nr_Prawa_jazdy,
		Czas_posiadania_prawa_jazdy,
		1
	FROM vETLDimUzytkownik
	EXCEPT
	SELECT
		Nr_Prawa_jazdy,
		Czas_posiadania_prawa_jazdy,
		1
	FROM DimUzytkownik;

Drop View vETLDimUzytkownik;