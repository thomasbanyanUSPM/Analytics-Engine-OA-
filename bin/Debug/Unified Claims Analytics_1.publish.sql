﻿/*
Deployment script for OppAnalysisEngine

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "OppAnalysisEngine"
:setvar DefaultFilePrefix "OppAnalysisEngine"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[MemberProfile_Core].[AltID] is being dropped, data loss could occur.

The column [dbo].[MemberProfile_Core].[PriMemberID] is being dropped, data loss could occur.

The column [dbo].[MemberProfile_Core].[PriSSN] is being dropped, data loss could occur.
*/
GO
PRINT N'Starting rebuilding table [dbo].[MemberProfile_Core]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_MemberProfile_Core] (
    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [ClientId]               INT           NULL,
    [MemProfileType]         VARCHAR (10)  NULL,
    [SubscriberID]           VARCHAR (50)  NULL,
    [SubscriberSSN]          VARCHAR (12)  NULL,
    [PriMemberNbr]           VARCHAR (5)   NULL,
    [SubscriberAltID]        VARCHAR (50)  NULL,
    [MemberID]               VARCHAR (50)  NULL,
    [MemberSSN]              VARCHAR (12)  NULL,
    [MemberAltID]            VARCHAR (50)  NULL,
    [IDSource]               VARCHAR (15)  NULL,
    [MemberRelationship]     VARCHAR (25)  NULL,
    [MemberRelationshipOrig] VARCHAR (25)  NULL,
    [FirstName]              VARCHAR (35)  NULL,
    [LastName]               VARCHAR (35)  NULL,
    [MiddleName]             VARCHAR (35)  NULL,
    [MemberDOB]              DATE          NULL,
    [MemberDOBYr]            TINYINT       NULL,
    [MemberGender]           CHAR (1)      NULL,
    [Address]                VARCHAR (100) NULL,
    [City]                   VARCHAR (35)  NULL,
    [State]                  VARCHAR (2)   NULL,
    [Zip]                    VARCHAR (14)  NULL,
    [Custom1]                VARCHAR (100) NULL,
    [Custom1_lbl]            VARCHAR (25)  NULL,
    [Custom2]                VARCHAR (100) NULL,
    [Custom2_lbl]            VARCHAR (25)  NULL,
    [Custom3]                VARCHAR (100) NULL,
    [Custom3_lbl]            VARCHAR (25)  NULL,
    [StartDte]               DATE          NULL,
    [EndDte]                 DATE          NULL,
    [Current]                BIT           NULL,
    [Order]                  SMALLINT      NULL,
    [originalfiledate]       DATE          NULL,
    [lastfiledate]           DATE          NULL,
    [CreatedOn]              DATE          NULL,
    [LastUpdatedOn]          DATE          NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[MemberProfile_Core])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MemberProfile_Core] ON;
        INSERT INTO [dbo].[tmp_ms_xx_MemberProfile_Core] ([ID], [ClientId], [MemProfileType], [PriMemberNbr], [MemberID], [MemberSSN], [IDSource], [MemberRelationship], [MemberRelationshipOrig], [FirstName], [LastName], [MiddleName], [MemberDOB], [MemberDOBYr], [MemberGender], [Address], [City], [State], [Zip], [Custom1], [Custom1_lbl], [Custom2], [Custom2_lbl], [Custom3], [Custom3_lbl], [StartDte], [EndDte], [Current], [Order], [originalfiledate], [lastfiledate], [CreatedOn], [LastUpdatedOn])
        SELECT   [ID],
                 [ClientId],
                 [MemProfileType],
                 [PriMemberNbr],
                 [MemberID],
                 [MemberSSN],
                 [IDSource],
                 [MemberRelationship],
                 [MemberRelationshipOrig],
                 [FirstName],
                 [LastName],
                 [MiddleName],
                 [MemberDOB],
                 [MemberDOBYr],
                 [MemberGender],
                 [Address],
                 [City],
                 [State],
                 [Zip],
                 [Custom1],
                 [Custom1_lbl],
                 [Custom2],
                 [Custom2_lbl],
                 [Custom3],
                 [Custom3_lbl],
                 [StartDte],
                 [EndDte],
                 [Current],
                 [Order],
                 [originalfiledate],
                 [lastfiledate],
                 [CreatedOn],
                 [LastUpdatedOn]
        FROM     [dbo].[MemberProfile_Core]
        ORDER BY [ID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MemberProfile_Core] OFF;
    END

DROP TABLE [dbo].[MemberProfile_Core];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_MemberProfile_Core]', N'MemberProfile_Core';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[Diagnosis_Core]...';


GO
CREATE TABLE [dbo].[Diagnosis_Core] (
    [Id]             INT           NOT NULL,
    [MemberID]       VARCHAR (50)  NULL,
    [ClaimDate]      DATE          NULL,
    [ClaimNumber]    VARCHAR (100) NULL,
    [ClaimType]      CHAR (1)      NULL,
    [DiagCode]       VARCHAR (50)  NULL,
    [CodeType]       CHAR (1)      NULL,
    [Diagnosis]      VARCHAR (100) NULL,
    [DiagnosisKey]   INT           NULL,
    [Primary]        TINYINT       NULL,
    [USPMClassifier] VARCHAR (5)   NULL,
    [Status]         CHAR (1)      NULL,
    [LastUpdated]    DATE          NULL,
    [NetPaid]        MONEY         NULL,
    [TotalPaid]      MONEY         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Med_Services_Core]...';


GO
CREATE TABLE [dbo].[Med_Services_Core] (
    [Id]                INT            NOT NULL,
    [ClaimID]           VARCHAR (100)  NULL,
    [ClaimLineNbr]      SMALLINT       NULL,
    [Seq]               TINYINT        NULL,
    [ProcCode]          VARCHAR (10)   NULL,
    [CodeType]          VARCHAR (10)   NULL,
    [Modifier1]         VARCHAR (3)    NULL,
    [Modifier2]         VARCHAR (3)    NULL,
    [Status]            CHAR (1)       NULL,
    [Units]             DECIMAL (5, 2) NULL,
    [ProviderID]        VARCHAR (50)   NULL,
    [BillingProviderID] VARCHAR (50)   NULL,
    [ServiceStartDate]  DATE           NULL,
    [SubmittedDate]     DATE           NULL,
    [PaidDate]          DATE           NULL,
    [OrigPaidDate]      DATE           NULL,
    [fAdj]              TINYINT        NULL,
    [BilledAmt]         MONEY          NULL,
    [DedAmt]            MONEY          NULL,
    [CoPayAmt]          MONEY          NULL,
    [CoInsAmt]          MONEY          NULL,
    [NetPaidAmt]        MONEY          NULL,
    [TotPaidAmt]        MONEY          NULL,
    [COBAmt]            MONEY          NULL,
    [OthPaidAmt]        MONEY          NULL,
    [PriDiagnosisCode]  VARCHAR (10)   NULL,
    [LastUpdateDte]     DATE           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[MedicalClaim_Core]...';


GO
CREATE TABLE [dbo].[MedicalClaim_Core] (
    [Id]             INT            NOT NULL,
    [ClaimID]        VARCHAR (50)   NULL,
    [ClaimIDType]    CHAR (1)       NULL,
    [Status]         CHAR (1)       NULL,
    [ClaimType]      CHAR (1)       NULL,
    [ClaimLines]     SMALLINT       NULL,
    [USPMClassifier] CHAR (2)       NULL,
    [NetPaid]        MONEY          NULL,
    [TotPaid]        MONEY          NULL,
    [ServiceDate]    DATE           NULL,
    [ServiceDays]    SMALLINT       NULL,
    [Units]          DECIMAL (5, 2) NULL,
    [PaidDate]       DATE           NULL,
    [OrigPaidDate]   DATE           NULL,
    [AdjType]        CHAR (1)       NULL,
    [SourceFile]     VARCHAR (100)  NULL,
    [CreatedDate]    DATE           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[MedicalClaim_Core]...';


GO
ALTER TABLE [dbo].[MedicalClaim_Core]
    ADD DEFAULT 'O' FOR [ClaimIDType];


GO
PRINT N'Creating unnamed constraint on [dbo].[MedicalClaim_Core]...';


GO
ALTER TABLE [dbo].[MedicalClaim_Core]
    ADD DEFAULT 'P' FOR [Status];


GO
PRINT N'Update complete.';


GO
