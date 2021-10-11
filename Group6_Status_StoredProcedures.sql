CREATE OR ALTER PROCEDURE StatusNameFilter @StatusName VARCHAR(25)
AS
	SELECT *
	FROM Ledger.tblStatus
	WHERE StatusName = @StatusName
GO

CREATE OR ALTER PROCEDURE StatusInsert
@StatusID INTEGER, @StatusName VARCHAR(25)
AS
	IF(@StatusID IS NOT NULL AND @StatusName IS NOT NULL)
	BEGIN
		INSERT INTO Ledger.tblStatus
		(StatusID, StatusName)
		VALUES
		(@StatusID, @StatusName)

		IF(@@ROWCOUNT = 0)
			PRINT 'Table insert failed'
		ELSE
			PRINT 'Table insert successful'
	END
	ELSE
		PRINT 'Values cannot be NULL'
GO

CREATE OR ALTER PROCEDURE StatusDeletion @StatusID INTEGER
AS
	IF(@StatusID IS NOT NULL)
	BEGIN
		DELETE FROM Ledger.tblStatus
		WHERE StatusID = @StatusID
	
		IF(@@ROWCOUNT = 0)
			PRINT 'Deletion failed.'
		ELSE
			PRINT 'Deletion successful.'
	END
	ELSE
		PRINT 'Value cannot be NULL.'
GO

CREATE OR ALTER PROCEDURE StatusUpdate
@StatusID INTEGER, @StatusName VARCHAR(25)
AS
	IF(@StatusID IS NOT NULL AND @StatusName IS NOT NULL)
	BEGIN
		UPDATE Ledger.tblStatus
		SET StatusName = @StatusName
		WHERE StatusID = @StatusID

		IF(@@ROWCOUNT = 0)
			PRINT 'Update failed.'
		ELSE
			PRINT 'Update successful.'
	END
	ELSE
		PRINT 'Values cannot be NULL.'
GO



