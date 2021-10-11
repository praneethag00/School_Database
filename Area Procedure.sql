CREATE OR ALTER PROCEDURE Areas_Filter
       @AreaID INT = NULL, @AreaName VARCHAR(100) = NULL, @AreaDesc VARCHAR(250) = NULL, @AreaAddress VARCHAR(250) = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM SchoolEvents.tblAreas '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @AreaID IS NOT NULL THEN N' AND AreaID = ' + CAST(@AreaID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @AreaName IS NOT NULL THEN N' AND AreaName LIKE ' + N'''' + @AreaName + N''''  ELSE N'' END
	   + CASE WHEN @AreaDesc IS NOT NULL THEN N' AND AreaDesc LIKE ' + N'''' + @AreaDesc + N''''  ELSE N'' END
	   + CASE WHEN @AreaAddress IS NOT NULL THEN N' AND AreaAddress LIKE ' + N'''' + @AreaAddress + N''''  ELSE N'' END
	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@AreaID AS INT, @AreaName AS VARCHAR(100), @AreaDesc AS VARCHAR(250), @AreaAddress AS VARCHAR(250) ',
	   @AreaID = @AreaID,
	   @AreaName = @AreaName,
	   @AreaDesc = @AreaDesc,
	   @AreaAddress = @AreaAddress

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO

CREATE OR ALTER PROCEDURE Area_Delete
        @AreaID INT = NULL

AS

       IF(@AreaID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM SchoolEvents.tblAreas '
		   + N' WHERE AreaID = ' + CAST(@AreaID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@AreaID AS INT',
	   @AreaID = @AreaID


		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO

CREATE OR ALTER PROCEDURE Area_Insert
     @AreaName VARCHAR(100) = NULL, @AreaDesc VARCHAR(250) = NULL, @AreaAddress VARCHAR(250) = NULL

AS
      DECLARE @AreaID  INT = (SELECT MAX(AreaID ) + 1 FROM SchoolEvents.tblAreas)
	  
	   IF @AreaDesc IS NOT NULL AND @AreaAddress IS NOT NULL AND @AreaAddress IS NOT NULL
	   BEGIN
		   INSERT INTO SchoolEvents.tblAreas(AreaID , AreaName, AreaDesc, AreaAddress )
			  VALUES(@AreaID, @AreaName, @AreaDesc, @AreaAddress)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without All Variables!'
	  
	  


GO

CREATE OR ALTER PROCEDURE Area_Update
       @AreaID INT = NULL, @AreaName VARCHAR(100) = NULL, @AreaDesc VARCHAR(250) = NULL, @AreaAddress VARCHAR(250) = NULL

AS


       IF(@AreaID IS NOT NULL)
	   BEGIN
		   IF(@AreaName IS NULL AND @AreaDesc IS NULL AND @AreaAddress IS NULL)
			  PRINT 'ERROR! No Updates For ID Given!'

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE SchoolEvents.tblAreas SET ' 

			   + CASE WHEN @AreaName IS NOT NULL THEN ' WHERE AreaName = ' + N'''' + @AreaName + N'''' ELSE N'' END
			   + CASE WHEN @AreaName IS NOT NULL AND @AreaDesc IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @AreaDesc IS NOT NULL THEN N' AreaDesc = ' + N'''' + @AreaDesc + N'''' ELSE N'' END
			   + CASE WHEN @AreaDesc IS NOT NULL AND @AreaAddress IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @AreaAddress IS NOT NULL THEN N' AreaAddress = ' + N'''' + @AreaAddress + N'''' ELSE N'' END

			   + N' WHERE AreaID = ' + CAST(@AreaID AS VARCHAR(20))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@AreaID AS INT, @AreaName AS VARCHAR(100), @AreaDesc AS VARCHAR(250), @AreaAddress AS VARCHAR(250) ',
			   @AreaID = @AreaID,
			   @AreaName = @AreaName,
			   @AreaDesc = @AreaDesc,
			   @AreaAddress = @AreaAddress

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO