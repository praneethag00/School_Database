CREATE OR ALTER PROCEDURE VolunteerBookDayFilter @VolBookDaysID INTEGER
AS
	IF(@VolBookDaysID IS NOT NULL)
	BEGIN
		SELECT *
		FROM Ledger.tblVolunteerBookDays
		WHERE VolBookDaysID = @VolBookDaysID
	END
	ELSE
		PRINT 'Values cannot be NULL.'
GO

CREATE OR ALTER PROCEDURE VolunteerBookDayInsert
@VolBookDaysID INTEGER, @FamID INTEGER, @NumParents INTEGER,
@DatePWorked DATE, @DateSWorked DATE, @PrimParPosition INTEGER,
@SecParPosition INTEGER, @PrimTimeWork TIME, @SecTimeWork TIME
AS
	IF(@VolBookDaysID IS NOT NULL AND @FamID IS NOT NULL AND @NumParents IS NOT NULL
	   AND @DatePWorked IS NOT NULL AND @PrimParPosition IS NOT NULL AND
	   @PrimTimeWork IS NOT NULL)
	BEGIN
		INSERT INTO Ledger.tblVolunteerBookDays
		(VolBookDaysID, FamID, NumParents, DatePWorked, DateSWorked,
		 PrimParPosition, SecParPosition, PrimTimeWork, SecTimeWork)
		VALUES
		(@VolBookDaysID, @FamID, @NumParents, @DatePWorked, @DateSWorked,
		 @PrimParPosition, @SecParPosition, @PrimTimeWork, @SecTimeWork)

		 IF(@@ROWCOUNT = 0)
			PRINT 'Table insert failed.'
		ELSE
			PRINT 'Table insert successful.'
	END
	ELSE
		PRINT 'Values cannot be NULL.'
GO

CREATE OR ALTER PROCEDURE VolunteerBookDayDeletion @VolBookDaysID INTEGER
AS
	IF(@VolBookDaysID IS NOT NULL)
	BEGIN
		DELETE FROM Ledger.tblVolunteerBookDays
		WHERE VolBookDaysID = @VolBookDaysID

		IF(@@ROWCOUNT = 0)
			PRINT 'Deletion failed.'
		ELSE
			PRINT 'Deletion successful.'
	END
GO

CREATE OR ALTER PROCEDURE VolunteerBookDayUpdate
@VolBookDaysID INTEGER, @FamID INTEGER, @NumParents INTEGER,
@DatePWorked DATE, @DateSWorked DATE, @PrimParPosition INTEGER,
@SecParPosition INTEGER, @PrimTimeWork TIME, @SecTimeWork TIME
AS
	IF(@VolBookDaysID IS NOT NULL AND @FamID IS NOT NULL AND @NumParents IS NOT NULL
	   AND @DatePWorked IS NOT NULL AND @PrimParPosition IS NOT NULL AND
	   @PrimTimeWork IS NOT NULL)
	BEGIN
		UPDATE Ledger.tblVolunteerBookDays
		SET FamID = @FamID,
			NumParents = @NumParents,
			DatePWorked = @DatePWorked,
			DateSWorked = @DateSWorked,
			PrimParPosition = @PrimParPosition,
			SecParPosition = @SecParPosition,
			PrimTimeWork = @PrimTimeWork,
			SecTimeWork = @SecTimeWork
		WHERE VolBookDaysID = @VolBookDaysID
	
		IF(@@ROWCOUNT = 0)
			PRINT 'Update failed.'
		ELSE
			PRINT 'Update successful.'
	END
GO