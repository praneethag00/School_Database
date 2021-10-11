CREATE OR ALTER PROCEDURE Event_Filter
       @EventID INT = NULL, @EventTitle VARCHAR(50) = NULL, @EventDate DATE = NULL, @EventStartTime TIME(7) = NULL,
	   @EventEndTime TIME(7)  = NULL, @VolArea INT = NULL, @EventDesc VARCHAR(250) = NULL, @RecurringEvent INT = NULL,
	   @EventAllDay INT = NULL, @EndDateRecurring DATE = NULL

AS

       DECLARE @sql AS NVARCHAR(MAX) = N'SELECT * FROM SchoolEvents.tblEvents '
	   + N' WHERE 1 = 1 '
	   + CASE WHEN @EventID IS NOT NULL THEN N' AND EventID = ' + CAST(@EventID AS VARCHAR(15))  ELSE N'' END
	   + CASE WHEN @EventTitle IS NOT NULL THEN N' AND EventTitle LIKE ' + N'''' + @EventTitle + N''''  ELSE N'' END
	   + CASE WHEN @EventDate IS NOT NULL THEN N' AND EventDate LIKE ' + CAST(@EventDate AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @EventStartTime IS NOT NULL THEN N' AND EventStartTime LIKE ' + CAST(@EventStartTime AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @EventEndTime IS NOT NULL THEN N' AND EventEndTime LIKE ' + CAST(@EventEndTime AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @VolArea IS NOT NULL THEN N' AND VolArea = ' + CAST(@VolArea AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @EventDesc IS NOT NULL THEN N' AND EventDesc LIKE ' + N'''' + @EventDesc + N''''  ELSE N'' END
	   + CASE WHEN @RecurringEvent IS NOT NULL THEN N' AND RecurringEvent = ' + CAST(@RecurringEvent AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @EventAllDay IS NOT NULL THEN N' AND EventAllDay = ' + CAST(@EventAllDay AS VARCHAR(20))  ELSE N'' END
	   + CASE WHEN @EndDateRecurring IS NOT NULL THEN N' AND EndDateRecurring LIKE ' + CAST(@EndDateRecurring AS VARCHAR(20))  ELSE N'' END

	   + N';'

	   PRINT @sql;

	   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@EventID AS INT, @EventTitle AS VARCHAR(50), @EventDate AS DATE, @EventStartTime AS TIME(7),
	   @EventEndTime AS TIME(7), @VolArea AS INT, @EventDesc AS VARCHAR(250), @RecurringEvent AS INT,
	   @EventAllDay AS INT, @EndDateRecurring AS DATE',
	   @EventID = @EventID,
	   @EventTitle = @EventTitle,
	   @EventDate= @EventDate,
	   @EventStartTime = @EventStartTime,
	   @EventEndTime = @EventEndTime,
	   @VolArea = @VolArea,
	   @EventDesc = @EventDesc,
	   @RecurringEvent = @RecurringEvent,
	   @EventAllDay = @EventAllDay,
	   @EndDateRecurring = @EndDateRecurring

	   IF(@@ROWCOUNT = 0)
			PRINT 'Warning! No Records Selected'
	   ELSE
			PRINT 'Filter Successful!'


GO

CREATE OR ALTER PROCEDURE Event_Delete
        @EventID INT = NULL

AS

       IF(@EventID IS NOT NULL)
	   BEGIN
		   DECLARE @sql AS NVARCHAR(MAX) = N'DELETE FROM SchoolEvents.tblEvents '
		   + N' WHERE AreaID = ' + CAST(@EventID AS VARCHAR(15))
		   + N';'

		   PRINT @sql;

		   EXEC sys.sp_executesql
	   @stmt = @sql,
	   @params = N'@EventID AS INT',
	   @EventID = @EventID


		   IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Records Selected'
			ELSE
				PRINT 'Delete Successful!'

	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Delete On'


GO

CREATE OR ALTER PROCEDURE Event_Insert
     @EventTitle VARCHAR(50) = NULL, @EventDate DATE = NULL, @EventStartTime TIME(7) = NULL,
	   @EventEndTime TIME(7)  = NULL, @VolArea INT = NULL, @EventDesc VARCHAR(250) = NULL, @RecurringEvent INT = NULL,
	   @EventAllDay INT = NULL, @EndDateRecurring DATE = NULL

AS
      DECLARE @EventID INT = (SELECT MAX(EventID ) + 1 FROM SchoolEvents.tblEvents)
	  
	   IF @EventTitle IS NOT NULL AND @EventDate IS NOT NULL AND @EventStartTime IS NOT NULL
	   AND @EventEndTime IS NOT NULL AND @VolArea IS NOT NULL AND @EventDesc IS NOT NULL
	   AND @RecurringEvent IS NOT NULL AND @EventAllDay IS NOT NULL
	   
	   BEGIN
		   INSERT INTO SchoolEvents.tblEvents(EventID, EventTitle , EventDate, EventStartTime, 
		               EventEndTime, VolArea, EventDesc, RecurringEvent, EventAllDay, EndDateRecurring )
			  VALUES(@EventID, @EventTitle, @EventDate, @EventStartTime, @EventEndTime, @VolArea, @EventDesc,
			         @RecurringEvent, @EventAllDay, @EndDateRecurring)

			  IF(@@ROWCOUNT = 0)
				PRINT 'Warning! No Inserts Made'
		   ELSE
				PRINT 'Inserts Successful!'

		END
	  ELSE PRINT 'ERROR! Cannot Query Insert Without All Inserts Besides Optional EndDateRecurring!'
	  
	  


GO

CREATE OR ALTER PROCEDURE Area_Update
       @EventID INT = NULL, @EventTitle VARCHAR(50) = NULL, @EventDate DATE = NULL, @EventStartTime TIME(7) = NULL,
	   @EventEndTime TIME(7)  = NULL, @VolArea INT = NULL, @EventDesc VARCHAR(250) = NULL, @RecurringEvent INT = NULL,
	   @EventAllDay INT = NULL, @EndDateRecurring DATE = NULL

AS


       IF(@EventID IS NOT NULL)
	   BEGIN
		   IF @EventTitle IS NULL AND @EventDate IS NULL AND @EventStartTime IS NULL
	   AND @EventStartTime IS NULL AND @EventEndTime IS NULL AND @VolArea IS NULL AND @EventDesc IS NULL
	   AND @RecurringEvent IS NULL AND @EventAllDay IS NULL AND @EndDateRecurring IS NULL
			  PRINT 'ERROR! No Updates For ID Given!'

		   ELSE

		   BEGIN
			   DECLARE @sql AS NVARCHAR(MAX) = N'UPDATE SchoolEvents.tblEvents SET ' 

			   + CASE WHEN @EventTitle IS NOT NULL THEN ' WHERE EventTitle = ' + N'''' + @EventTitle + N'''' ELSE N'' END
			   + CASE WHEN @EventTitle IS NOT NULL AND @EventDate IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EventDate IS NOT NULL THEN N' EventDate = ' + CAST(@EventDate AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @EventDate IS NOT NULL AND @EventStartTime IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EventStartTime IS NOT NULL THEN N' EventStartTime = ' + CAST(@EventStartTime AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @EventStartTime IS NOT NULL AND @EventEndTime IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EventEndTime IS NOT NULL THEN N' EventEndTime = ' + CAST(@EventEndTime AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @EventEndTime IS NOT NULL AND @VolArea IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @VolArea IS NOT NULL THEN N' VolArea = ' + CAST(@VolArea AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @VolArea IS NOT NULL AND @EventDesc IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EventDesc IS NOT NULL THEN ' WHERE EventDesc = ' + N'''' + @EventDesc + N'''' ELSE N'' END
			   + CASE WHEN @EventDesc IS NOT NULL AND @RecurringEvent IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @RecurringEvent  IS NOT NULL THEN N' RecurringEvent  = ' + CAST(@RecurringEvent  AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @RecurringEvent IS NOT NULL AND @EventAllDay IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EventAllDay  IS NOT NULL THEN N' EventAllDay  = ' + CAST(@EventAllDay  AS VARCHAR(20)) ELSE N'' END
			   + CASE WHEN @EventAllDay IS NOT NULL AND @EndDateRecurring IS NOT NULL THEN N' , ' ELSE N'' END 
			   + CASE WHEN @EndDateRecurring  IS NOT NULL THEN N' EndDateRecurring  = ' + CAST(@EndDateRecurring  AS VARCHAR(20)) ELSE N'' END

			   + N' WHERE EventID = ' + CAST(@EventID AS VARCHAR(20))
			   + N';'

			   PRINT @sql;

			   EXEC sys.sp_executesql
			   @stmt = @sql,
			   @params = N'@EventID AS INT, @EventTitle AS VARCHAR(50), @EventDate AS DATE, @EventStartTime AS TIME(7),
			   @EventEndTime AS TIME(7), @VolArea AS INT, @EventDesc AS VARCHAR(250), @RecurringEvent AS INT,
			   @EventAllDay AS INT, @EndDateRecurring AS DATE',
			   @EventID = @EventID,
			   @EventTitle = @EventTitle,
			   @EventDate= @EventDate,
			   @EventStartTime = @EventStartTime,
			   @EventEndTime = @EventEndTime,
			   @VolArea = @VolArea,
			   @EventDesc = @EventDesc,
			   @RecurringEvent = @RecurringEvent,
			   @EventAllDay = @EventAllDay,
			   @EndDateRecurring = @EndDateRecurring

			   IF(@@ROWCOUNT = 0)
				PRINT 'Warning: No Rows Updated'
		   ELSE
				PRINT 'Update Successful!'

			END


	   END

	   ELSE
	   PRINT 'ERROR! NO ID Given to Update On'


	   


GO