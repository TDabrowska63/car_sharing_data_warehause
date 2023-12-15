USE FaktyWypozyczenia

INSERT INTO [dbo].[DimInne] 
SELECT s, p 
FROM 
	  (
		VALUES 
			  ('nieograniczony')
			, ('calodobowy')

	  ) 
	AS Typ_uslugi(s)
	
	, (
		VALUES 
			  ('wiecej niz pol')
			, ('mniej niz pol')
	  ) 
	AS Poziom_paliwa(p);