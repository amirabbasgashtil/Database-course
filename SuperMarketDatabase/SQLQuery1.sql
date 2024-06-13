-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
USE [SuperMarket]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER updt_product
   ON  [dbo].[PRODUCT] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	IF (UPDATE(product_ID) OR UPDATE(product_name))
	BEGIN
	INSERT INTO Product_log (product_id, product_name, operation, date)
	SELECT i.product_ID, i.product_Name, 'update', GETDATE()
	FROM inserted i
	END

END
GO

USE [SuperMarket]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER add_product
	ON [dbo].[PRODUCT]
	AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @product_id nvarchar(10)
	DECLARE @product_name nvarchar(10)

	SELECT @product_id=i.product_ID , @product_name=i.product_Name
	FROM inserted i

	INSERT INTO Product_log(product_id, product_name, operation, date)
	VALUES(@product_id, @product_name, 'INSERT', GETDATE())
END
GO

USE [SuperMarket]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dlt_product
ON [dbo].[PRODUCT]
AFTER DELETE
AS
BEGIN
	INSERT INTO Product_log (product_id, product_name ,operation, date)
    SELECT d.product_ID,d.product_Name ,'DELETE',GETDATE()
    FROM deleted d;
END;