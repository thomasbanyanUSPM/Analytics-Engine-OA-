

CREATE TABLE [dbo].[Member_PPPM](
	[ClientId] [int] NULL,
	[MemberID] [varchar](50) NULL,
	[MemberRelationship] [varchar](25) NULL,
	[PriMemberID] [varchar](50) NULL,
	[MemberAge] [tinyint] NULL,
	[MemberAgeGrp] [varchar](10) NULL,
	[AnalyticYear] [int] NOT NULL,
	[YrMthKey] [char](6) NULL,
	[MonthYear] [char](7) NOT NULL,
	[CalYear] [int] NOT NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](14) NULL,
	[CostCenter] [varchar](50) NULL,
	[MemberGroup] [varchar](50) NULL,
	[custom1] [varchar](100) NULL,
	[custom1_lbl] [varchar](25) NULL,
	[custom2] [varchar](100) NULL,
	[custom2_lbl] [varchar](25) NULL,
	[custom3] [varchar](100) NULL,
	[custom3_lbl] [varchar](25) NULL,
	[custom4] [varchar](100) NULL,
	[custom4_lbl] [varchar](25) NULL,
	[custom5] [varchar](100) NULL,
	[custom5_lbl] [varchar](25) NULL,
	[MthCntr] [int] NOT NULL
) ON [PRIMARY]






