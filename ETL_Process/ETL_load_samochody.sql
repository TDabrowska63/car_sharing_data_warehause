USE FaktyWypozyczenia
GO

If (object_id('vETLDimSamochod') is not null) Drop View vETLDimSamochod;
go
CREATE VIEW vETLDimSamochod
AS
SELECT DISTINCT
	[Marka],
	[Typ],
	[Nr_rejestracyjny]
FROM UrbanDriveSnapshot1.dbo.Samochody;
GO

MERGE INTO DimSamochod as TT
	USING vETLDimSamochod as ST
		ON TT.Marka = ST.Marka
		AND TT.Typ = ST.Typ
		AND TT.Nr_rejestracyjny = ST.Nr_rejestracyjny
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.Marka,
					ST.Typ,
					ST.Nr_rejestracyjny
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;
Drop View vETLDimSamochod;