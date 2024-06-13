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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER add_emp
   ON  [dbo].[EMPLOYEE]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @employee_ssn nvarchar(10)
	DECLARE @name nvarchar(10)

	SELECT @employee_ssn=i.employee_ssn , @name=i.name
	FROM inserted i

	INSERT INTO Employee_log(employee_ssn, name, operation, date)
	VALUES(@employee_ssn, @name, 'INSERT', GETDATE())
   
END
GO

CREATE TRIGGER updt_emp
	ON [dbo].[EMPLOYEE]
	AFTER UPDATE
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	IF (UPDATE(employee_ssn) OR UPDATE(name))
	BEGIN
	INSERT INTO Employee_log(employee_ssn, name, operation, date)
	SELECT i.employee_ssn, i.name, 'update', GETDATE()
	FROM inserted i
	END

END

GO

CREATE TRIGGER dlt_emp
ON [dbo].[EMPLOYEE]
AFTER DELETE
AS
BEGIN
	INSERT INTO Employee_log(employee_ssn, name ,operation, date)
    SELECT d.employee_ssn ,d.name ,'DELETE',GETDATE()
    FROM deleted d;
END;