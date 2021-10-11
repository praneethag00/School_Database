CREATE OR ALTER PROCEDURE VolunteerBookFilter @VolBookID INTEGER
AS
	SELECT *
	FROM Ledger.tblVolunteerBook
	WHERE VolBookDayID = @VolBookID
GO

CREATE OR ALTER PROCEDURE VolunteerBookInsert
@VolBookID INTEGER, @VolBookDayID INTEGER, @StatusID INTEGER,
@EventID INTEGER, @LocationID INTEGER, @BookComment VARCHAR(250)
AS
	IF(@VolBookID IS NOT NULL AND @VolBookDayID IS NOT NULL AND @StatusID IS NOT NULL
	   AND @EventID IS NOT NULL)
	BEGIN
		INSERT INTO Ledger.tblVolunteerBook
		(VolBookID, VolBookDayID, StatusID, EventID, LocationID, BookComment)
		VALUES
		(@VolBookID, @VolBookDayID, @StatusID, @EventID, @LocationID, @BookComment)

		IF(@@ROWCOUNT = 0)
			PRINT 'Table insert failed.'
		ELSE
			PRINT 'Table insert succeeded.'
	END
GO

CREATE OR ALTER PROCEDURE VolunteerBookUpdate
@VolBookID INTEGER, @VolBookDayID INTEGER, @StatusID INTEGER,
@EventID INTEGER, @LocationID INTEGER, @BookComment VARCHAR(250)
AS
	IF(@VolBookID IS NOT NULL AND @VolBookDayID IS NOT NULL AND
	   @StatusID IS NOT NULL AND @EventID IS NOT NULL)
	BEGIN
		UPDATE Ledger.tblVolunteerBook
		SET VolBookDayID = @VolBookDayID,
			StatusID = @StatusID,
			EventID = @EventID,
			LocationID = @LocationID,
			BookComment = @BookComment
		WHERE VolBookID = @VolBookDayID
	END
GO

CREATE OR ALTER PROCEDURE VolunteerBookDeletion @VolBookID INTEGER
AS
	IF(@VolBookID IS NOT NULL)
	BEGIN
		DELETE FROM Ledger.tblVolunteerBook
		WHERE VolBookID = @VolBookID

		IF(@@ROWCOUNT = 0)
			PRINT 'Deletion failed.'
		ELSE
			PRINT 'Deletion successful.'
	END
GO

