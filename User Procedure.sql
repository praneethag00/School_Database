CREATE OR ALTER PROCEDURE User_Filter
       @UserID INT = NULL, @UserTypeID VARCHAR(50) = NULL, @UserFName VARCHAR(50) = NULL, @UserLName VARCHAR(50) = NULL,
	   @ContactPhone BIGINT = NULL, @ContactEmail VARCHAR(100) = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM Employees.tblUsers '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @UserID   IS NOT NULL THEN N' AND UserID = ' + CAST(@UserID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @UserTypeID   IS NOT NULL THEN N' AND UserTypeID = ' + CAST(@UserTypeID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @UserFName   IS NOT NULL THEN N' AND UserFName LIKE ' + N'''' + @UserFName + N''''  ELSE N'' END
	   + CASE WHEN @UserLName   IS NOT NULL THEN N' AND UserLName LIKE ' + N'''' + @UserLName + N''''  ELSE N'' END
	   + CASE WHEN @ContactPhone   IS NOT NULL THEN N' AND ContactPhone = ' + CAST(@ContactPhone AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @ContactEmail   IS NOT NULL THEN N' AND ContactEmail LIKE ' + N'''' + @ContactEmail + N''''  ELSE N'' END

	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@UserID AS INT, @UserTypeID AS VARCHAR(50), @UserFName AS VARCHAR(50), @UserLName AS VARCHAR(50),
	   @ContactPhone AS BIGINT, @ContactEmail AS VARCHAR(100)',
	   @UserID = @UserID, 
	   @UserTypeID = @UserTypeID,
	   @UserFName = @UserFName, 
	   @UserLName = @UserLName,
	   @ContactPhone = @ContactPhone, 
	   @ContactEmail = @ContactEmail;

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO


CREATE OR ALTER PROCEDURE User_Insert
      @UserTypeID INT  = NULL, @UserFName VARCHAR(50) = NULL, @UserLName VARCHAR(50) = NULL,
	   @ContactPhone BIGINT = NULL, @ContactEmail VARCHAR(100) = NULL

AS
      
	  DECLARE @UserID INT = (SELECT (MAX(UserID) + 1) FROM Employees.tblUsers) 
	  
	   IF @UserTypeID IS NOT NULL AND @UserFName IS NOT NULL AND @UserLName IS NOT NULL AND @ContactPhone IS NOT NULL AND @ContactEmail IS NOT NULL
	   BEGIN
		   INSERT INTO Employees.tblUsers(UserID, UserTypeID, UserFName, UserLName, ContactPhone, ContactEmail)
			  VALUES(@UserID, @UserTypeID, @UserFName, @UserLName, @ContactPhone, @ContactEmail)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without UserType, User First Name, User Last Name, Contact Phone, And Contact Email'
	  
	  


GO

CREATE OR ALTER PROCEDURE User_Delete
       @UserID INT = NULL

AS

       IF(@UserID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM Employees.tblUsers '
		   + N' WHERE UserID = ' + CAST(@UserID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
		   @stmt = @sql,
		   @params = N'@UserID as INT',
		   @UserID = @UserID;

		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO


CREATE OR ALTER PROCEDURE User_Update
        @UserID INT = NULL, @UserTypeID INT = NULL, @UserFName VARCHAR(50) = NULL, @UserLName VARCHAR(50) = NULL,
	   @ContactPhone BIGINT = NULL, @ContactEmail VARCHAR(100) = NULL

AS

	

       IF(@UserID IS NOT NULL)
	   BEGIN

		   IF @UserTypeID IS NULL AND @UserFName IS NULL AND @UserLName IS NULL AND @ContactPhone IS NULL AND @ContactEmail IS NULL
			  BEGIN
					 PRINT 'ERROR! No Updates For ID Given!'
			  END

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE Employees.tblUsers SET ' 

			   + CASE WHEN @UserTypeID IS NOT NULL THEN N' UserTypeID = ' + CAST(@UserTypeID AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @UserTypeID IS NOT NULL AND @UserFName IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @UserFName IS NOT NULL THEN N' UserFName = ' + N'''' + @UserFName +'''' ELSE N'' END
			   + CASE WHEN @UserFName IS NOT NULL AND @UserLName IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @UserLName IS NOT NULL THEN N' UserLName = ' + N'''' + @UserLName +'''' ELSE N'' END
			   + CASE WHEN @UserLName IS NOT NULL AND @ContactPhone IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @ContactPhone IS NOT NULL THEN N' ContactPhone = ' + CAST(@ContactPhone AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @ContactPhone IS NOT NULL AND @ContactEmail IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @ContactEmail IS NOT NULL THEN N' ContactEmail = ' + N'''' + @ContactEmail +'''' ELSE N'' END

			   + N' WHERE UserID = ' + CAST(@UserID AS VARCHAR(15))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@UserID AS INT, @UserTypeID AS VARCHAR(50), @UserFName AS VARCHAR(50), @UserLName AS VARCHAR(50),
			   @ContactPhone AS BIGINT, @ContactEmail AS VARCHAR(100)',
			   @UserID = @UserID, 
			   @UserTypeID = @UserTypeID,
			   @UserFName = @UserFName, 
			   @UserLName = @UserLName,
			   @ContactPhone = @ContactPhone, 
			   @ContactEmail = @ContactEmail;

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO
