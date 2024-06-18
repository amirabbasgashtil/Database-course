SELECT dbo.Employee_log.*
FROM     dbo.Employee_log
WHERE  (date = CONVERT(date, GETDATE()))
