CREATE PROCEDURE SelectState @StateID INT
AS
	SELECT * FROM Volunteer.tblStates
	WHERE StateID = @StateID

	IF(@@ROWCOUNT = 0)
	PRINT 'Warning! No Records Selected'
	ELSE
	PRINT 'Filter Successful'
GO

EXEC SelectState @StateID = 42
GO




CREATE PROCEDURE InsertStates
@StateAbv CHAR(2), @StateName VARCHAR(50)
AS
	SET @StateAbv = UPPER(@StateAbv);
	DECLARE @StateID AS INT
	SET @StateID = (SELECT MAX(StateID) + 1 FROM Volunteer.tblStates)

	IF(@StateAbv IS NOT NULL AND @StateName IS NOT NULL)
	BEGIN
		INSERT INTO Volunteer.tblStates
		(StateID, StateAbv, StateName)
		VALUES
		(@StateID, @StateAbv, @StateName)

		IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Inserts Made'
		ELSE
			PRINT 'Inserts Successful!'
	END
	ELSE PRINT 'ERROR! Cannot Query Insert with NULL values!'
GO

EXEC InsertStates
@StateAbv = 'AR', @StateName = 'Argentina'
GO




CREATE PROCEDURE DeleteStates @StateID INT
AS
	IF(@StateID IS NOT NULL)
	BEGIN
		DELETE FROM Volunteer.tblStates
		WHERE StateID = @StateID
		IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Delete On'
GO

EXEC DeleteStates @StateID = 58136
GO




CREATE PROCEDURE UpdateMarylandStateID @StateID INT
AS
	IF(@StateID IS NOT NULL)
	BEGIN
		UPDATE Volunteer.tblStates
		SET StateID = 50
		WHERE StateID = @StateID

		IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'
	END
	ELSE PRINT 'ERROR! NO ID Given to Update On'
GO

EXEC UpdateMarylandStateID @StateID = 58135
GO