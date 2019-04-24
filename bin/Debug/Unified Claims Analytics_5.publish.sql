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
The column [dbo].[PPPY_Summary].[NbrMths] is being dropped, data loss could occur.

The column clientID on table [dbo].[PPPY_Summary] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column MemberID on table [dbo].[PPPY_Summary] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/
GO
PRINT N'Starting rebuilding table [dbo].[PPPY_Summary]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_PPPY_Summary] (
    [clientID]             INT           NOT NULL,
    [PriMemberID]          VARCHAR (50)  NULL,
    [MemberID]             VARCHAR (50)  NOT NULL,
    [Relationship]         VARCHAR (25)  NULL,
    [Year]                 INT           NOT NULL,
    [FTE]                  INT           NULL,
    [Custom1]              VARCHAR (100) NULL,
    [Custom2]              VARCHAR (100) NULL,
    [Custom3]              VARCHAR (100) NULL,
    [Custom4]              VARCHAR (100) NULL,
    [ExclFlg]              INT           NOT NULL,
    [InsTramaFlg]          INT           NULL,
    [MedClaims]            INT           NULL,
    [MedPaid]              MONEY         NULL,
    [PharmClaims]          INT           NULL,
    [PharmPaid]            MONEY         NULL,
    [TotalPaid]            MONEY         NULL,
    [ClaimswExcl]          INT           NULL,
    [MedwLessTrama]        MONEY         NULL,
    [MedwStopLossExcl]     MONEY         NULL,
    [PharmwStopLossExcl]   MONEY         NULL,
    [TotalwLessTrama]      MONEY         NULL,
    [TotalwStopLossExcl]   MONEY         NULL,
    [IPPaid]               MONEY         NULL,
    [IPPaidLssTrama]       MONEY         NULL,
    [IPPaidLssTramaStExcl] MONEY         NULL,
    [ERPaid]               MONEY         NULL,
    [ERPaidLssTrama]       MONEY         NULL,
    [ERPaidLssTramaStExcl] MONEY         NULL,
    [IPAdm]                INT           NULL,
    [IPAdmLssExcl]         INT           NULL,
    [IPDys]                INT           NULL,
    [IPDysLssExcl]         INT           NULL,
    [ERDys]                INT           NULL,
    [ERDysLssExcl]         INT           NULL,
    [OPDys]                INT           NULL,
    [OPDysLssExcl]         INT           NULL,
    [OVDys]                INT           NULL,
    [OVDysLssExcl]         INT           NULL,
    [ClaimDys]             INT           NULL,
    [ClaimDysLssExcl]      INT           NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_PPPY_PK1] PRIMARY KEY CLUSTERED ([clientID] ASC, [MemberID] ASC, [Year] ASC)
) ON [PRIMARY];

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[PPPY_Summary])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_PPPY_Summary] ([clientID], [MemberID], [Year], [PriMemberID], [Relationship], [Custom1], [Custom2], [Custom3], [Custom4], [ExclFlg], [InsTramaFlg], [MedClaims], [MedPaid], [PharmClaims], [PharmPaid], [TotalPaid], [ClaimswExcl], [MedwLessTrama], [MedwStopLossExcl], [PharmwStopLossExcl], [TotalwLessTrama], [TotalwStopLossExcl], [IPPaid], [IPPaidLssTrama], [IPPaidLssTramaStExcl], [ERPaid], [ERPaidLssTrama], [ERPaidLssTramaStExcl], [IPAdm], [IPAdmLssExcl], [IPDys], [IPDysLssExcl], [ERDys], [ERDysLssExcl], [OPDys], [OPDysLssExcl], [OVDys], [OVDysLssExcl], [ClaimDys], [ClaimDysLssExcl])
        SELECT   [clientID],
                 [MemberID],
                 [Year],
                 [PriMemberID],
                 [Relationship],
                 [Custom1],
                 [Custom2],
                 [Custom3],
                 [Custom4],
                 [ExclFlg],
                 [InsTramaFlg],
                 [MedClaims],
                 [MedPaid],
                 [PharmClaims],
                 [PharmPaid],
                 [TotalPaid],
                 [ClaimswExcl],
                 [MedwLessTrama],
                 [MedwStopLossExcl],
                 [PharmwStopLossExcl],
                 [TotalwLessTrama],
                 [TotalwStopLossExcl],
                 [IPPaid],
                 [IPPaidLssTrama],
                 [IPPaidLssTramaStExcl],
                 [ERPaid],
                 [ERPaidLssTrama],
                 [ERPaidLssTramaStExcl],
                 [IPAdm],
                 [IPAdmLssExcl],
                 [IPDys],
                 [IPDysLssExcl],
                 [ERDys],
                 [ERDysLssExcl],
                 [OPDys],
                 [OPDysLssExcl],
                 [OVDys],
                 [OVDysLssExcl],
                 [ClaimDys],
                 [ClaimDysLssExcl]
        FROM     [dbo].[PPPY_Summary]
        ORDER BY [clientID] ASC, [MemberID] ASC, [Year] ASC;
    END

DROP TABLE [dbo].[PPPY_Summary];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_PPPY_Summary]', N'PPPY_Summary';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_PPPY_PK1]', N'PK_PPPY_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[Reporting_Parms]...';


GO
CREATE TABLE [dbo].[Reporting_Parms] (
    [JobId]                 INT          NOT NULL,
    [JobDate]               DATETIME     NOT NULL,
    [Yr1_AnalysisStartDate] DATE         NOT NULL,
    [YrsOfAnalysis]         TINYINT      NOT NULL,
    [RunoutMths]            TINYINT      NOT NULL,
    [Employees]             BIT          NOT NULL,
    [Spouses]               BIT          NOT NULL,
    [Dependents]            BIT          NOT NULL,
    [Retirees]              BIT          NOT NULL,
    [OutputFormat]          CHAR (1)     NOT NULL,
    [OutputType]            CHAR (1)     NOT NULL,
    [Custom1_field]         VARCHAR (50) NULL,
    [Custom1_disabled]      BIT          NOT NULL,
    [Custom2_field]         VARCHAR (50) NULL,
    [Custom2_disabled]      BIT          NOT NULL,
    [Sts]                   CHAR (1)     NOT NULL,
    PRIMARY KEY CLUSTERED ([JobId] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Employees];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Spouses];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Dependents];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Retirees];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 'b' FOR [OutputFormat];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 'f' FOR [OutputType];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Custom1_disabled];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 0 FOR [Custom2_disabled];


GO
PRINT N'Creating unnamed constraint on [dbo].[Reporting_Parms]...';


GO
ALTER TABLE [dbo].[Reporting_Parms]
    ADD DEFAULT 'x' FOR [Sts];


GO
PRINT N'Altering [dbo].[Member_Claims_Util_PPPY_vw]...';


GO

/***********************************************
*   Name:		 Member_Claims_Util_PPPY_vw
*
*   Object:	 View
*
*   Created:	 1/18/2019
*
*   Description:	Summarized Member, Medical and Pharamcy data by Analytic Year
*					Includes cost and utilization - total, less exclusion and less exclusions
					and stop loss
*   Updated
*
************************************************/
ALTER VIEW [dbo].[Member_Claims_Util_PPPY_vw]
	AS 
	select m.clientID 
    , m.PriMemberID
    , m.MemberID
	, max([MemberRelationship])  as Relationship
    , AnalyticYear as Year
	, count(distinct m.YrMthKey)/12.0 as NbrMths
    , max(Custom1) as Custom1
    , max(Custom2) as Custom2
    , max(Custom3) as Custom3
    , max(Custom4) as Custom4
    , isnull(max(ExclFlg),0) as ExclFlg
    , max([InsTramaFlg]) as InsTramaFlg
    , sum(c.claims) as MedClaims
    , sum(c.Paid) as MedPaid
    , sum(p.claims) as PharmClaims
    , sum(p.paid) as PharmPaid
    , isnull(sum(c.Paid),0) + isnull(sum(p.paid),0) as TotalPaid


    , iif(max(ExclFlg) = 1,0, sum(c.ClaimsLssTrama)) as ClaimswExcl 
    , sum(PaidLssTrama) as MedwLessTrama
    , iif(max(ExclFlg) = 1,0, iif(sum(PaidLssTrama) > 100000 , 100000, sum(PaidLssTrama))) MedwStopLossExcl

    , (iif(max(ExclFlg) = 1,0, iif(isnull(sum(PaidLssTrama),0) + isnull(sum(p.paid),0) > 100000 
		  , 100000, isnull(sum(PaidLssTrama),0) + isnull(sum(p.paid),0) )) )
			 - (iif(max(ExclFlg) = 1,0, iif(sum(PaidLssTrama) > 100000 , 100000, sum(PaidLssTrama)))) PharmwStopLossExcl

    , isnull(sum(PaidLssTrama),0) + isnull(sum(p.paid),0)  as TotalwLessTrama
    , iif(max(ExclFlg) = 1,0, iif(isnull(sum(PaidLssTrama),0) + isnull(sum(p.paid),0) > 100000 
		  , 100000, isnull(sum(PaidLssTrama),0) + isnull(sum(p.paid),0) )) TotalwStopLossExcl

    , sum([IPPaid]) as [IPPaid]
    , sum([IPPaidLssTrama]) as [IPPaidLssTrama]
    , iif(max(ExclFlg) = 1,0,sum([IPPaidLssTrama]* stp)) as [IPPaidLssTramaStExcl]
    --, iif(max(ExclFlg) = 1,0,iif(sum(PaidLssTrama) > 100000 , 100000,sum([IPPaidLssTrama]))) as [IPPaidLssTramaStExcl]

    , sum([ERPaid]) as [ERPaid]
    , sum([ERPaidLssTrama]) as [ERPaidLssTrama]
    , iif(max(ExclFlg) = 1,0, sum([ERPaidLssTrama] * stp)) as [ERPaidLssTramaStExcl]

    , sum([IPAdm]) as IPAdm
    , iif(max(ExclFlg) = 0, sum([IPltAdm]),0) as [IPAdmLssExcl]

    , sum([IPDys]) as [IPDys]
    , iif(max(ExclFlg) = 0, sum([IPltDys]),0) as [IPDysLssExcl]

    , sum([ERDys]) as [ERDys]
    , iif(max(ExclFlg) = 0, sum([ERltDys]), 0) as [ERDysLssExcl]

    , sum([OPDys]) as [OPDys]
    , iif(max(ExclFlg) = 0 , sum([OPDys]), 0) as [OPDysLssExcl]

    , sum([OVDys]) as [OVDys]
    , iif(max(ExclFlg) = 0 , sum([OVDys]), 0) as [OVDysLssExcl]

    , sum([ClaimDys]) as [ClaimDys]
    , iif(max(ExclFlg) = 0 , sum([ClaimDysLssTrama]),0) as [ClaimDysLssExcl]

from [dbo].[Member_PPPM]  m 
    left join Member_Claims_PPPM c
	   on m.ClientID = C.ClientID
		  AND m.PriMemberID = c.PriMemberID
		  AND m.MemberID = c.MemberID
		  and m.YrMthKey = c.YrMth
    left join Member_Pharmacy_PPPM p 
	   on m.ClientID = p.ClientID
		  AND m.PriMemberID = p.PriMemberID
		  AND m.MemberID = P.MemberID
		  and m.YrMthKey = p.YrMth
where YrMthKey >= 1401
group by m.clientID 
    , m.PriMemberID
    , m.MemberID
   , m.AnalyticYear
GO
PRINT N'Creating [dbo].[Member_CondHier_PPPM_vw]...';


GO
CREATE VIEW [dbo].[Member_CondHier_PPPM_vw]
	AS 

select * 
    , case when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse') then 1
		when Condition = 'Congestive Heart Failure' then 2
		when Condition = 'CAD' then 3
		when Condition = 'COPD' then 4
		when Condition = 'Diabetes' then 5
		when Condition = 'Hypertension' then 6
		when Condition = 'Obesity' then 7
		when Condition = 'Back and Neck Pain' then 8
		when Condition = 'Asthma' then 9
		else 99 end as Hierarchy 
    , case  when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse')  then 'MH-6'  
		when Condition = 'Congestive Heart Failure' then 'Congestive Heart Failure'  
		when Condition = 'CAD' then 'CAD'
		when Condition = 'COPD' then 'COPD'
		when Condition = 'Diabetes' then 'Diabetes'
		when Condition = 'Hypertension' then 'Hypertension'
		when Condition = 'Obesity' then 'Obesity'
		when Condition = 'Back and Neck Pain' then 'Back and Neck Pain'
		when Condition = 'Asthma' then 'Asthma'
		  end as CondHier
    , dense_rank() over (partition by MemberID, Yr order by case when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse') then 1
											   when Condition = 'Congestive Heart Failure' then 2
											   when Condition = 'CAD' then 3
											   when Condition = 'COPD' then 4
											   when Condition = 'Diabetes' then 5
											   when Condition = 'Hypertension' then 6
											   when Condition = 'Obesity' then 7
											   when Condition = 'Back and Neck Pain' then 8
											   when Condition = 'Asthma' then 9
											   end ASC )  as CondRnk

from [dbo].[Member_Conditions_PPPM_vw]
where CondGrpType = 'Standard Condition'
    and Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse', 'Congestive Heart Failure'
	   , 'CAD', 'COPD', 'Diabetes', 'Hypertension', 'Obesity' , 'Back and Neck Pain', 'Asthma' )
GO
PRINT N'Creating [dbo].[Member_PrimaryConditions_PPPM_vw]...';


GO
CREATE VIEW [dbo].[Member_PrimaryConditions_PPPM_vw]
	AS 
select ClientID
	,PrimemberID
    , MemberID
    , CondGrpType
    , coalesce([ConditionID], '0') as [ConditionID]
    , coalesce([Condition], 'Other Cond/Ill/Inj') as [Condition]
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
	, sum(case when [ClassifierUSPM] = 'IP' then PaidAmt else 0 END) as 'IPPaid'
    , sum(case when [ClassifierUSPM] = 'ER' then PaidAmt else 0 end) as 'ERPaid'
    , sum(case when [ClassifierUSPM] = 'OP' then PaidAmt else 0 END) as 'OPPaid'
    , sum(case when [ClassifierUSPM] = 'OV' then PaidAmt else 0 end) as 'OVPaid'
    , sum(case when [ClassifierUSPM] = 'OTH' then PaidAmt else 0 end) as 'OTHPaid'
	

    , sum(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ('8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015'))
		then PaidAmt else 0 end)
		as TramaPaid

    , sum(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ('8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
		  and   ([ClassifierUSPM] = 'IP') )
		  Then PaidAmt else 0 end) as TramaIPPaid

	, sum(case when (((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	or (left(icd2,1) in ('8','9')  and convert(date,FromServiceDate) < '10/1/2015')
	or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015'))
		  and   ([ClassifierUSPM] = 'ER'))
			 Then PaidAmt else 0 end) as TramaERPaid
    , 1 as IsPrim
    , max([YrMth]) as YrMth
from [dbo].[MedicalClaims_Base] m
    left join [dbo].[ref_ICDtoCond] ic
	   on m.ICD1 = ic.ICDCode

group by 
     PrimemberID
    , ClientID
    , MemberID
    , CondGrpType
    , coalesce([ConditionID], '0') 
    , coalesce([Condition], 'Other Cond/Ill/Inj') 
    , [YrMth]
GO
PRINT N'Creating [dbo].[fnCheckCustomFlag]...';


GO
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
GO
PRINT N'Creating [dbo].[HealthCareSpend_Excl_Summary]...';


GO
CREATE VIEW [dbo].[HealthCareSpend_Excl_Summary]
as
	select [Year]
	, [Relationship] 
	, [dbo].[fnCheckCustomFlag](Custom1) as Custom1
	, [dbo].[fnCheckCustomFlag](Custom2) as Custom2

    , count(distinct concat(PriMemberID, MemberID)) as TotPop
    , sum(FTE)/12 as AvgPop
    , sum(case when FTE = 12 then 1 else 0 end) as StablePop
    , sum(case when FTE <> 12 then 1 else 0 end) as ChngPop
    , sum(case when FTE <> 12 then FTE else 0 end)/12 as ChngPopFTE
    , sum(FTE)/count(distinct concat(PriMemberID, MemberID)) as AvgMthsPPPY
    , (Sum(MedwStopLossExcl) + Sum(PharmwStopLossExcl))/(sum(FTE)/12) as PPPY
    , (Sum(MedwStopLossExcl) + Sum(PharmwStopLossExcl))/(sum(FTE)) as PPPM
    , Sum(MedwStopLossExcl) + Sum(PharmwStopLossExcl) as TotPaid
    , Sum(MedwStopLossExcl) as TotMed
    , Sum(PharmwStopLossExcl) as TotPharm
    , Sum(MedwStopLossExcl)/(sum(FTE)/12) as AvgMedPPPY
    , Sum(MedwStopLossExcl)/(sum(FTE)) as AvgMedPPPM
    , Sum(MedClaims) as TotMedClaims
    , Sum(MedwStopLossExcl)/Sum(MedClaims) as AvgMedPClaim
    , count(distinct case when isnull(medclaims, 0) > 0 then Concat(PriMemberID, MemberID)  end) as TotMedClaimants
    , sum(case when isnull(medclaims, 0) > 0 then FTE else 0 end)/12 as AvgMedClaimants
    , Sum(MedwStopLossExcl)/(sum(case when isnull(medclaims, 0) > 0 then FTE else 1 end)/12) as AvgMedPCPY
    , Sum(MedwStopLossExcl)/(sum(case when isnull(medclaims, 0) > 0 then FTE else 1 end)) as AvgMedPCPM
   
    , Sum(PharmwStopLossExcl)/(sum(FTE)/12) as AvgPharmPPPY
    , Sum(PharmwStopLossExcl)/(sum(FTE)) as AvgPharmPPPM
    , Sum(PharmClaims) as TotPharmClaims
    , Sum(PharmwStopLossExcl)/Sum(PharmClaims) as AvgPharmPClaim
    , count(case when isnull(Pharmclaims, 0) > 0 then  Concat(PriMemberID, MemberID)  end) as TotPharmClaimants
    , sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)/12 as AvgPharmClaimants
    , Sum(PharmwStopLossExcl)/(sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)/12) as AvgPharmPCPY
    , Sum(PharmwStopLossExcl)/(sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)) as AvgPharmPCPM
    , (case when Relationship = 'E' then 1 when Relationship = 'S' then 2 when Relationship = 'D' then 3 else 4 end) as  ord
  
from  [dbo].[PPPY_Summary] with (nolock)
group by [Year]
    , [Relationship] 
    , [dbo].[fnCheckCustomFlag](Custom1)
	, [dbo].[fnCheckCustomFlag](Custom2)
GO
PRINT N'Creating [dbo].[HealthCareSpend_Summary]...';


GO
CREATE VIEW [dbo].[HealthCareSpend_Summary]
as
	select [Year]
	, [Relationship] 
	, [dbo].[fnCheckCustomFlag](Custom1) as Custom1
	, [dbo].[fnCheckCustomFlag](Custom2) as Custom2
    , count(distinct concat(PriMemberID, MemberID)) as TotPop
    , sum(FTE)/12 as AvgPop
    , sum(case when FTE = 12 then 1 else 0 end) as StablePop
    , sum(case when FTE <> 12 then 1 else 0 end) as ChngPop
    , sum(case when FTE <> 12 then FTE else 0 end)/12 as ChngPopFTE
    , sum(FTE)/count(distinct concat(PriMemberID, MemberID)) as AvgMthsPPPY
    , (Sum(MedPaid) + Sum(PharmPaid))/(sum(FTE)/12) as PPPY
    , (Sum(MedPaid) + Sum(PharmPaid))/(sum(FTE)) as PPPM
    , Sum(MedPaid) + Sum(PharmPaid) as TotPaid
    , Sum(MedPaid) as TotMed
    , Sum(PharmPaid) as TotPharm
    , Sum(MedPaid)/(sum(FTE)/12) as AvgMedPPPY
    , Sum(MedPaid)/(sum(FTE)) as AvgMedPPPM
    , Sum(MedClaims) as TotMedClaims
    , Sum(MedPaid)/Sum(MedClaims) as AvgMedPClaim
    , count(distinct case when isnull(medclaims, 0) > 0 then Concat(PriMemberID, MemberID)  end) as TotMedClaimants
    , sum(case when isnull(medclaims, 0) > 0 then FTE else 0 end)/12 as AvgMedClaimants
    , Sum(MedPaid)/(sum(case when isnull(medclaims, 0) > 0 then FTE else 1 end)/12) as AvgMedPCPY
    , Sum(MedPaid)/(sum(case when isnull(medclaims, 0) > 0 then FTE else 1 end)) as AvgMedPCPM
   
    , Sum(PharmPaid)/(sum(FTE)/12) as AvgPharmPPPY
    , Sum(PharmPaid)/(sum(FTE)) as AvgPharmPPPM
    , Sum(PharmClaims) as TotPharmClaims
    , Sum(PharmPaid)/Sum(PharmClaims) as AvgPharmPClaim
    , count(case when isnull(Pharmclaims, 0) > 0 then  Concat(PriMemberID, MemberID)  end) as TotPharmClaimants
    , sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)/12 as AvgPharmClaimants
    , Sum(PharmPaid)/(sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)/12) as AvgPharmPCPY
    , Sum(PharmPaid)/(sum(case when isnull(Pharmclaims, 0) > 0 then FTE else 1 end)) as AvgPharmPCPM
    , (case when Relationship = 'E' then 1 when Relationship = 'S' then 2 when Relationship = 'D' then 3 else 4 end) as  ord
  
from  [dbo].[PPPY_Summary] with (nolock)
group by [Year]
    , [Relationship] 
    , [dbo].[fnCheckCustomFlag](Custom1) 
	, [dbo].[fnCheckCustomFlag](Custom2)
GO
PRINT N'Update complete.';


GO