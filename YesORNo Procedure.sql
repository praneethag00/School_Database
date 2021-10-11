CREATE OR ALTER PROCEDURE YesOrNo_Filter
       @BinaryID INT = NULL, @CheckBoxVal INT = NULL, @BinaryName VARCHAR(3) = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM SchoolEvents.tblYesOrNo '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @BinaryID IS NOT NULL THEN N' AND BinaryID = ' + CAST(@BinaryID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @CheckBoxVal IS NOT NULL THEN N' AND CheckBoxVal = ' + CAST(@CheckBoxVal AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @BinaryName IS NOT NULL THEN N' AND BinaryName LIKE ' + N'''' + @BinaryName + N''''  ELSE N'' END
	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@BinaryID AS INT, @CheckBoxVal AS INT, @BinaryName AS VARCHAR(3)',
	   @BinaryID = @BinaryID,
	   @CheckBoxVal = @CheckBoxVal,
	   @BinaryName = @BinaryName

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO

CREATE OR ALTER PROCEDURE YesOrNo_Delete
       @BinaryID INT = NULL

AS

       IF(@BinaryID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM SchoolEvents.tblYesOrNo '
		   + N' WHERE BinaryID = ' + CAST(@BinaryID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@BinaryID AS INT',
	   @BinaryID = @BinaryID


		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO

CREATE OR ALTER PROCEDURE YesOrNo_Insert
      @CheckBoxVal INT = NULL, @BinaryName VARCHAR(3) = NULL

AS
      DECLARE @BinaryID  INT = (SELECT MAX(BinaryID ) + 1 FROM SchoolEvents.tblYesOrNo)
	  
	   IF @CheckBoxVal IS NOT NULL AND @BinaryName IS NOT NULL
	   BEGIN
		   INSERT INTO SchoolEvents.tblYesOrNo(BinaryID , CheckBoxVal, BinaryName )
			  VALUES(@BinaryID, @CheckBoxVal, @BinaryName)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without All Insert Variables!'
	  
	  


GO

CREATE OR ALTER PROCEDURE YesOrNo_Update
       @BinaryID INT = NULL, @CheckBoxVal INT = NULL, @BinaryName VARCHAR(3) = NULL

AS


       IF(@BinaryID IS NOT NULL)
	   BEGIN
		   IF(@CheckBoxVal IS NULL AND @BinaryName IS NULL)
			  PRINT 'ERROR! No Updates For ID Given!'

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE SchoolEvents.tblYesOrNo SET ' 

			   + CASE WHEN @CheckBoxVal IS NOT NULL THEN ' WHERE CheckBoxVal = ' + CAST(@CheckBoxVal AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @CheckBoxVal IS NOT NULL AND @BinaryName  IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @BinaryName IS NOT NULL THEN N' BinaryName = ' + N'''' + @BinaryName + N'''' ELSE N'' END
			   + N' WHERE BinaryID = ' + CAST(@BinaryID AS VARCHAR(20))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@BinaryID AS INT, @CheckBoxVal AS INT, @BinaryName AS VARCHAR(3)',
			   @BinaryID = @BinaryID,
			   @CheckBoxVal = @CheckBoxVal,
			   @BinaryName = @BinaryName

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO