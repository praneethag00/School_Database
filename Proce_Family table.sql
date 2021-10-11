CREATE PROCEDURE SelectFirParentLName @FirParentLName VARCHAR(50)
AS
	SELECT * FROM Volunteer.tblFamilies
	WHERE FirParentLName = @FirParentLName

	IF(@@ROWCOUNT = 0)
	PRINT 'Warning! No Records Selected'
	ELSE
	PRINT 'Filter Successful'
GO

EXEC SelectFirParentLName @FirParentLName = 'Russo'
GO




CREATE PROCEDURE InsertFamilies 
@FirParentFName VARCHAR(50), @FirParentLName VARCHAR(50), @FamAddress VARCHAR(100), @FamCity VARCHAR(100), @FamStateID INT,
@FamZipCode INT, @PrimPhone BIGINT
AS
	DECLARE @FamID AS INT
	SET @FamID = (SELECT MAX(FamID) + 1 FROM Volunteer.tblFamilies)

	IF (@FirParentFName IS NOT NULL AND @FirParentLName IS NOT NULL AND @FamAddress
		 IS NOT NULL AND @FamCity IS NOT NULL AND @FamStateID IS NOT NULL AND @FamZipCode IS NOT NULL AND
		 @PrimPhone IS NOT NULL)
		 BEGIN
			INSERT INTO Volunteer.tblFamilies
			(FamID, FirParentFName, FirParentLName, FamAddress, FamCity, FamStateID, FamZipCode, PrimPhone)
			VALUES
			(@FamID, @FirParentFName, @FirParentLName, @FamAddress, @FamCity, @FamStateID, @FamZipCode, @PrimPhone)

			IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'
		END
	ELSE PRINT 'ERROR! Cannot Query Insert with NULL values!'
GO

EXEC InsertFamilies
@FirParentFName = 'Dame', @FirParentLName = 'Forest', @FamAddress = '123 Lake Street', @FamCity = 'Lake Charles',
@FamStateID = 25, @FamZipCode = 70415, @PrimPhone = 9884222857
GO




CREATE PROCEDURE DeleteFamRecordOnID @FamID INT
AS
	IF(@FamID IS NOT NULL)
	BEGIN
		DELETE FROM Volunteer.tblFamilies
		WHERE FamID = @FamId

		IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Delete On'
GO

EXEC DeleteFamRecordOnID @FamID = 40208
GO




CREATE PROCEDURE UpdateFamSecPhoneToNUll @FamID INT
AS
	IF(@FamID IS NOT NULL)
	BEGIN
		UPDATE Volunteer.tblFamilies
		SET SecPhone = NULL
		WHERE FamID = @FamID

		IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Update On'
GO

EXEC UpdateFamSecPhoneToNUll @FamID = 40207
GO