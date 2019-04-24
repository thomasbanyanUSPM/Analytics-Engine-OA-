CREATE TABLE [dbo].[Reporting_Parms]
(
	[JobId] INT NOT NULL PRIMARY KEY, 
    [JobDate] datetime NOT NULL,
	[Yr1_AnalysisStartDate] date NOT NULL,
	[YrsOfAnalysis] tinyint not null,
	[RunoutMths] tinyint not null,
	[Employees] bit DEFAULT 0 not null,
	[Spouses] bit Default 0 not null,
	[Dependents] bit Default 0 not null,
	[Retirees] bit Default 0 not null,
	[OutputFormat] char(1) DEFAULT 'b' not null , --[b] basic, [s] seperate
	[OutputType] char(1) Default 'f' not null, --[f] full, [s] only, [p] prevelance only
	[Custom1_field] varchar(50) null, 
	[Custom1_disabled] bit default 0 not null,
	[Custom2_field] varchar(50) null, 
	[Custom2_disabled] bit default 0 not null,
	[Sts] char(1) default 'x' not null 

	

	
)
