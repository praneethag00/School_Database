CREATE OR ALTER PROCEDURE UserType_Filter
       @UserTypeID INT = NULL, @UserTypeName VARCHAR(50) = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM Employees.tblUserTypes '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @UserTypeID  IS NOT NULL THEN N' AND UserTypeID = ' + CAST(@UserTypeID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @UserTypeName IS NOT NULL THEN N' AND UserTypeName LIKE ' + N'''' + @UserTypeName + N''''  ELSE N'' END
	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@UserTypeID AS INT, @UserTypeName AS VARCHAR(50)',
	   @UserTypeID = @UserTypeID,
	   @UserTypeName = @UserTypeName

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO

CREATE OR ALTER PROCEDURE UserType_Delete
       @UserTypeID INT = NULL

AS

       IF(@UserTypeID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM Employees.tblUserTypes'
		   + N' WHERE UserTypeID = ' + CAST(@UserTypeID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@UserTypeID AS INT',
	   @UserTypeID = @UserTypeID


		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO

CREATE OR ALTER PROCEDURE UserType_Insert
      @UserTypeName VARCHAR(50) = NULL

AS
      DECLARE @UserTypeID INT = (SELECT MAX(UserTypeID) + 1 FROM Employees.tblUserTypes)
	  
	   IF @UserTypeName IS NOT NULL
	   BEGIN
		   INSERT INTO Employees.tblUserTypes(UserTypeID, UserTypeName)
			  VALUES(@UserTypeID, @UserTypeName)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without Name and Description!'
	  
	  


GO

CREATE OR ALTER PROCEDURE UserType_Update
       @UserTypeID INT = NULL, @UserTypeName VARCHAR(50) = NULL

AS


       IF(@UserTypeID IS NOT NULL)
	   BEGIN
		   IF(@UserTypeName IS NULL)
			  PRINT 'ERROR! No Updates For ID Given!'

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE Employees.tblUserTypes SET ' 

			   + CASE WHEN @UserTypeName IS NOT NULL THEN N' UserTypeName = ' + N'''' + @UserTypeName + N'''' ELSE N'' END
			   + N' WHERE UserTypeID = ' + CAST(@UserTypeID AS VARCHAR(20))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@UserTypeID AS INT, @UserTypeName AS VARCHAR(50)',
			   @UserTypeID = @UserTypeID,
			   @UserTypeName = @UserTypeName

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO