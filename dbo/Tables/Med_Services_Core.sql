CREATE TABLE [dbo].[Med_Services_Core]
(
	[Id] INT NOT NULL PRIMARY KEY
	,[ClaimID] varchar(100)
	,[ClaimLineNbr] smallint
	,[Seq] tinyint
	,[ProcCode] varchar(10)
	,[CodeType] varchar(10) -- C:Revenue, R:Revenue, B:Billing, T:TOS
	,[Modifier1] varchar(3)
	,[Modifier2] varchar(3)
	,[Status] char(1)
	,[Units] decimal(5,2)
	,[ProviderID] varchar(50)
	,[BillingProviderID] varchar(50)
	,[ServiceStartDate] date
	,[SubmittedDate] date
	,[PaidDate] date
	,[OrigPaidDate] date
	,[fAdj] tinyint
	,[BilledAmt] money
	,[DedAmt] money
	,[CoPayAmt] money
	,[CoInsAmt] money
	,[NetPaidAmt] money
	,[TotPaidAmt] money
	,[COBAmt] money
	,[OthPaidAmt] money
	,[PriDiagnosisCode] varchar(10)
	,LastUpdateDte date

)
