CREATE OR ALTER PROCEDURE Position_Filter
       @PositionID INT = NULL, @PositionName VARCHAR(50) = NULL, @PositionDesc VARCHAR(250) = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM Employees.tblPositions '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @PositionID   IS NOT NULL THEN N' AND PositionID = ' + CAST(@PositionID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @PositionName IS NOT NULL THEN N' AND PositionName LIKE ' + N''''+ @PositionName + N''''  ELSE N'' END
	   + CASE WHEN @PositionDesc IS NOT NULL THEN N' AND PositionDesc LIKE ' +  N'''' + @PositionDesc + N''''  ELSE N'' END
	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@PositionID as INT, @PositionName AS VARCHAR(50), @PositionDesc AS VARCHAR(250)',
	   @PositionID = @PositionID,
	   @PositionName = PositionName,
	   @PositionDesc = @PositionDesc;

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO



CREATE OR ALTER PROCEDURE Position_Insert
      @PositionName VARCHAR(50) = NULL, @PositionDesc VARCHAR(250) = NULL

AS
      
	  DECLARE @PositionID INT = (SELECT (MAX(PositionID) + 1) FROM Employees.tblPositions) 
	  
	   IF @PositionName IS NOT NULL AND @PositionDesc IS NOT NULL 
	   BEGIN
		   INSERT INTO Employees.tblPositions(PositionID, PositionName, PositionDesc)
			  VALUES(@PositionID, @PositionName, @PositionDesc)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without Name and Description!'
	  
	  


GO

CREATE OR ALTER PROCEDURE Position_Delete
       @PositionID INT = NULL

AS

       IF(@PositionID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM Employees.tblPositions '
		   + N' WHERE PositionID = ' + CAST(@PositionID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
		   @stmt = @sql,
		   @params = N'@PositionID as INT',
		   @PositionID = @PositionID;

		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO

CREATE OR ALTER PROCEDURE Position_Update
       @PositionID INT = NULL, @PositionName VARCHAR(50) = NULL, @PositionDesc VARCHAR(250) = NULL

AS


       IF(@PositionID IS NOT NULL)
	   BEGIN
		   IF(@PositionName IS NULL AND  @PositionDesc IS NULL)
			  PRINT 'ERROR! No Updates For ID Given!'

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE Employees.tblPositions SET ' 

			   + CASE WHEN @PositionName IS NOT NULL THEN N' PositionName = ' + N'''' + @PositionName + N'''' ELSE N'' END
			   + CASE WHEN @PositionName IS NOT NULL AND @PositionDesc IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @PositionDesc IS NOT NULL THEN N' PositionDesc = ' + N'''' + @PositionDesc +'''' ELSE N'' END
			   + N' WHERE PositionID = ' + CAST(@PositionID AS VARCHAR(15))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@PositionID AS INT, @PositionName AS VARCHAR(50), @PositionDesc AS VARCHAR(250)',
			   @PositionID = @PositionID,
			   @PositionName = PositionName,
			   @PositionDesc = @PositionDesc;

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO