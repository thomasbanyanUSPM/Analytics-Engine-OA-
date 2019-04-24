

CREATE TABLE [dbo].[Member_Claims_PPPM] (
    [ClientID]         INT           NULL,
    [PriMemberID]      VARCHAR (100) NULL,
    [MemberID]         VARCHAR (100) NULL,
    [YrMth]            CHAR (6)      NULL,
    [ExclFlg]          INT           NULL,
    [InsTramaFlg]      INT           NULL,
    [IPAdm]            INT           NULL,
    [IPltAdm]          INT           NULL,
    [IPtAdm]           INT           NULL,
    [IPDys]            INT           NULL,
    [IPltDys]          INT           NULL,
    [IPtDys]           INT           NULL,
    [ERDys]            INT           NULL,
    [ERltDys]          INT           NULL,
    [ERtDys]           INT           NULL,
    [OPDys]            INT           NULL,
    [OVDys]            INT           NULL,
    [ClaimDys]         INT           NULL,
    [ClaimDysTrama]    INT           NULL,
    [ClaimDysLssTrama] INT           NULL,
    [Paid]             MONEY         NULL,
    [PaidTrama]        MONEY         NULL,
    [PaidLssTrama]     MONEY         NULL,
    [IPPaid]           MONEY         NULL,
    [IPPaidLssTrama]   MONEY         NULL,
    [ERPaid]           MONEY         NULL,
    [ERPaidLssTrama]   MONEY         NULL,
    [Claims]           INT           NULL,
    [ClaimsLssTrama]   INT           NULL,
    [ClaimsTrama]      INT           NULL,
    [rtot]             MONEY         NULL,
    [stp]              INT           NULL
);



