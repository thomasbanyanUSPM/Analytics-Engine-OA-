CREATE TABLE [dbo].[Diagnosis_Core]
(
	[Id] INT NOT NULL PRIMARY KEY
	,[MemberID] varchar(50)
	,[ClaimDate] date
	,[ClaimNumber] varchar(100)
	,[ClaimType] char(1) --M: Medical, P:Pharmacy
	,[DiagCode] varchar(50)
	,[CodeType] char(1) --I: ICD, P:Procedure, N: NDC, D: MS DRG , A: A DRG
	,[Diagnosis] varchar(100)
	,[DiagnosisKey] int
	,[Primary]  tinyint --1:true, 0:false
	,[USPMClassifier] varchar(5)
	,[Status] char(1)
	,[LastUpdated] date
	,[NetPaid] money
	,[TotalPaid] money
)
