CREATE FUNCTION [dbo].[fnCheckCustomFlag]
(
	@value1 varchar(25)
)
Returns varchar(25)
as
BEGIN
Return 
case when (select [Custom2_disabled] from [dbo].Reporting_Parms where sts = 'a') = 1 then 'x' else @value1  end
END 
