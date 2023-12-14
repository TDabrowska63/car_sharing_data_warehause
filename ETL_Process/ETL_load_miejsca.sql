USE FaktyWypozyczenia
GO

If (object_id('vETLDimMiejsce') is not null) Drop View vETLDimMiejsce;
go
CREATE VIEW vETLDimMiejsce
AS
SELECT DISTINCT
	[Nazwa_miasta] as [Miasto],
	[Czy_miejsce_dedykowane]
FROM UrbanDriveSnapshot1.dbo.Miejsca;
GO

MERGE INTO DimMiejsce as TT
	USING vETLDimMiejsce as ST
		ON TT.Miasto = ST.Miasto
		AND TT.Czy_miejsce_dedykowane = ST.Czy_miejsce_dedykowane
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.Miasto,
					ST.Czy_miejsce_dedykowane
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;
Drop View vETLDimMiejsce;