SELECT dbo.Product_log.*
FROM     dbo.Product_log
WHERE  (date = CONVERT(date, GETDATE()))
