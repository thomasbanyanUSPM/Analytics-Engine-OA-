


CREATE TABLE [dbo].[Member_Pharmacy_PPPM] (
    [ClientID]          INT             NULL,
	[PriMemberID] varchar (100)         NULL,
    [MemberID]          VARCHAR (100)   NULL,
    [YrMth]             CHAR (6)        NULL,
    [Claims]            INT             NULL,
    [Paid]              MONEY           NULL,
    [TotPaid]           MONEY           NULL,
    [AvgDaysPresc]      DECIMAL (38, 6) NULL,
    [ClaimsGen]         INT             NULL,
    [PaidGen]           MONEY           NULL,
    [TotPaidGen]        MONEY           NULL,
    [AvgDaysPrescGen]   DECIMAL (38, 6) NULL,
    [ClaimsBrand]       INT             NULL,
    [PaidBrand]         MONEY           NULL,
    [TotPaidBrand]      MONEY           NULL,
    [AvgDaysPrescBrand] DECIMAL (38, 6) NULL
);


