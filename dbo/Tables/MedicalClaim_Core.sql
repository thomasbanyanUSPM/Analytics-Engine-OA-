CREATE TABLE [dbo].[MedicalClaim_Core]
(
	[Id] INT NOT NULL PRIMARY KEY
	,[ClaimID] varchar(50) 
	,[ClaimIDType] char(1) DEFAULT 'O' -- O: Original C: Computed
	,[Status] char(1) DEFAULT 'P' -- P: Paid, R: Reversed, A: Adjusted
	,[ClaimType] char(1) -- 'F' Facility 'P' Provider
	,[ClaimLines] smallint
	,[USPMClassifier] char(2) -- ER, IP, OV, OP, OTH
	,[NetPaid] money
	,[TotPaid] money
	,[ServiceDate] date
	,[ServiceDays] smallint
	,[Units] decimal(5,2)
	,[PaidDate] date
	,[OrigPaidDate] date
	,[AdjType] char(1)
	,[SourceFile] varchar(100)
	,[CreatedDate] date

)
