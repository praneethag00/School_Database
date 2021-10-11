CREATE PROCEDURE SelectLocation @LocationID INT
AS
	SELECT * FROM Volunteer.tblLocations
	WHERE LocationID = @LocationID

	IF(@@ROWCOUNT = 0)
		PRINT 'Warning! No Records Selected'
	ELSE
		PRINT 'Filter Successful'
	GO

EXEC SelectLocation @LocationID = 657
GO




CREATE PROCEDURE InsertLocations
@LocationName VARCHAR(100), @LocationDesc VARCHAR(250), @LocationAddress VARCHAR(100), @LocationPhone BIGINT
AS
	DECLARE @LocationID AS INT
	SET @LocationID = (SELECT MAX(LocationID) + 1 FROM Volunteer.tblLocations)

	IF(@LocationName IS NOT NULL AND @LocationDesc IS NOT NULL AND 
	@LocationAddress IS NOT NULL AND @LocationPhone IS NOT NULL)
	BEGIN
		INSERT INTO Volunteer.tblLocations
		 (LocationID, LocationName, LocationDesc, LocationAddress, LocationPhone)
		VALUES
		(@LocationID, @LocationName, @LocationDesc, @LocationAddress, @LocationPhone)
		IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Inserts Made'
		ELSE
			PRINT 'Inserts Successful!'
	END
	ELSE PRINT 'ERROR! Cannot Query Insert with NULL values!'
GO

EXEC InsertLocations
@LocationName = 'WestLake Public Park', @LocationDesc = 'Public Park', @LocationAddress = '2085 Warner St', @LocationPhone = 7771524567
GO




CREATE PROCEDURE DeleteLocations @LocationID INT
AS
	IF(@LocationID IS NOT NULL)
	BEGIN
		DELETE FROM Volunteer.tblLocations
		WHERE LocationID = @LocationID
		
		IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
		ELSE
			PRINT 'Delete Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Delete On'
GO

EXEC DeleteLocations @LocationID = 672
GO




CREATE PROCEDURE UpdateLocationAddress @LocationID INT
AS
	IF(@LocationID IS NOT NULL)
	BEGIN
		UPDATE Volunteer.tblLocations
		SET LocationAddress = '3280 Fairfield Rd'
		WHERE LocationID = @LocationID

		IF(@@ROWCOUNT = 0)
			PRINT 'Warning: No Rows Updated'
		ELSE
			PRINT 'Update Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Update On'
GO

EXEC UpdateLocationAddress @LocationID = 670
GO