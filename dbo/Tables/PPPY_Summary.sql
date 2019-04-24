

CREATE TABLE [dbo].[PPPY_Summary](
		[clientID] [int] NOT NULL,
	[PriMemberID] [varchar](50) NULL,
	[MemberID] [varchar](50) NOT NULL,
	[Relationship] [varchar](25) NULL,
	[Year] [int] NOT NULL,
	[FTE] [int] NULL,
	[Custom1] [varchar](100) NULL,
	[Custom2] [varchar](100) NULL,
	[Custom3] [varchar](100) NULL,
	[Custom4] [varchar](100) NULL,
	[ExclFlg] [int] NOT NULL,
	[InsTramaFlg] [int] NULL,
	[MedClaims] [int] NULL,
	[MedPaid] [money] NULL,
	[PharmClaims] [int] NULL,
	[PharmPaid] [money] NULL,
	[TotalPaid] [money] NULL,
	[ClaimswExcl] [int] NULL,
	[MedwLessTrama] [money] NULL,
	[MedwStopLossExcl] [money] NULL,
	[PharmwStopLossExcl] [money] NULL,
	[TotalwLessTrama] [money] NULL,
	[TotalwStopLossExcl] [money] NULL,
	[IPPaid] [money] NULL,
	[IPPaidLssTrama] [money] NULL,
	[IPPaidLssTramaStExcl] [money] NULL,
	[ERPaid] [money] NULL,
	[ERPaidLssTrama] [money] NULL,
	[ERPaidLssTramaStExcl] [money] NULL,
	[IPAdm] [int] NULL,
	[IPAdmLssExcl] [int] NULL,
	[IPDys] [int] NULL,
	[IPDysLssExcl] [int] NULL,
	[ERDys] [int] NULL,
	[ERDysLssExcl] [int] NULL,
	[OPDys] [int] NULL,
	[OPDysLssExcl] [int] NULL,
	[OVDys] [int] NULL,
	[OVDysLssExcl] [int] NULL,
	[ClaimDys] [int] NULL,
	[ClaimDysLssExcl] [int] NULL

	CONSTRAINT PK_PPPY_PK PRIMARY KEY CLUSTERED (ClientID, MemberID, Year)
) ON [PRIMARY]


