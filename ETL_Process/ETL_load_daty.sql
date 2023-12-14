USE FaktyWypozyczenia
GO

-- Fill DimDates Lookup Table
-- Step a: Declare variables use in processing
Declare @StartDate date; 
Declare @EndDate date;

-- Step b:  Fill the variable with values for the range of years needed
SELECT @StartDate = '2016-01-01', @EndDate = '2023-12-14';

-- Step c:  Use a while loop to add dates to the table
Declare @DateInProcess datetime = @StartDate;

While @DateInProcess <= @EndDate
	Begin
	--Add a row into the date dimension table for this date
		Insert Into [dbo].[DimData] 
		( [Rok]
		, [Miesiac]
		, [Miesiac_NO]
		, [Dzien]
		, [Dzien_tygodnia]
		, [Dzien_tygodnia_NO]
		)
		Values (
			@DateInProcess -- [Date]
		  , Cast( Year(@DateInProcess) as int) -- [Rok]
		  , Cast( DATENAME(month, @DateInProcess) as varchar(10)) -- [Miesiac]
		  , Cast( Month(@DateInProcess) as int) -- [Miesiac_NO]
		  , Cast( Day(@DateInProcess) as int) -- [Dzien]
		  , Cast( DATENAME(dw,@DateInProcess) as varchar(10)) -- [Dzien_tygodnia]
		  , Cast( DATEPART(dw, @DateInProcess) as int) -- [Dzien_tygodnia_NO]
		);  
		-- Add a day and loop again
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End
go