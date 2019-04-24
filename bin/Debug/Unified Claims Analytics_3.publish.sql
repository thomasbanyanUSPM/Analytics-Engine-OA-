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
PRINT N'Altering [dbo].[Member_Pharmacy_PPPM_vw]...';


GO

/***********************************************
*   Name:		 dbo.Member_Pharmacy_PPPM_vw
*
*   Object:	 View
*
*   Created:	 1/18/2019
*
*   Description:	Summarized the MemberProfile_Base by Calander and Analytical Year
*
*   Updated
*
************************************************/
ALTER view [dbo].[Member_Pharmacy_PPPM_vw]
as
select  ClientID
    , MemberID
    , p.[YrMth] 
    , Count(distinct ClaimNumber) as Claims 
    , Sum(PaidAmt) as Paid
    , sum(TotalPaidAll) as TotPaid
    , Sum(DaysSupply)/(datediff(day, max([FirstDayOfMonth]),max([LastDayOfMonth]))+1) as AvgDaysPresc

    , Count(distinct case when [GenericIndic] = 1 then ClaimNumber end) as ClaimsGen
    , sum(case when [GenericIndic] = 1 then PaidAmt end) as PaidGen
    , sum(case when [GenericIndic] = 1 then TotalPaidAll end) as TotPaidGen
    , Sum(case when [GenericIndic] = 1 then DaysSupply end )/(datediff(day, max([FirstDayOfMonth]),max([LastDayOfMonth]))+1) as AvgDaysPrescGen

    , Count(distinct case when [GenericIndic] = 0 then ClaimNumber end) as ClaimsBrand
    , sum(case when [GenericIndic] = 0 then PaidAmt end) as PaidBrand
    , sum(case when [GenericIndic] = 0 then TotalPaidAll end) as TotPaidBrand
    , Sum(case when [GenericIndic] = 0 then DaysSupply end )/(datediff(day, max([FirstDayOfMonth]),max([LastDayOfMonth]))+1) as AvgDaysPrescBrand

from [dbo].[PharmClaims_Base] p
    inner join [dbo].[DateTable_Month] d
	   on p.YrMth = d.YrMth
Group by ClientID 
  -- , PriMemberID
    , MemberID
    , p.[YrMth] 
    , [Year] 
    , [Month]
GO
PRINT N'Creating [dbo].[Member_Claims_PPPM_vw]...';


GO

/***********************************************
*   Name:		 dbo.Member_Claims_PPPM_vw
*
*   Object:	 View
*
*   Created:	 1/18/2019
*
*   Description:	Summarized the MemberClaimsDay_vw by Calander and Analytical Year
*
*   Updated
*
************************************************/

CREATE VIEW [dbo].[Member_Claims_PPPM_vw]
as
	with b
as
(
select ClientID
    , PriMemberID
    , MemberID
    , YrMth
    , max(isnull(ExclFlg,0)) as ExclFlg
    , max(TramaFlag) as InsTramaFlg
  --  , TramaFlag

    , sum(IPAdm) as IPAdm
    , sum(iif(TramaFlag = 0 , IPAdm, 0)) as IPltAdm
    , sum(iif(TramaFlag = 1 , IPAdm, 0)) as IPtAdm

    , sum(IP) as IPDys
    , sum(iif(TramaFlag = 0 , IP, 0)) as IPltDys
    , sum(iif(TramaFlag = 1 , IP, 0)) as IPtDys
    
    , sum(ER) as ERDys
    , sum(iif(TramaFlag = 0 , ER, 0)) as ERltDys
    , sum(iif(TramaFlag = 1 , ER, 0)) as ERtDys

    , sum(OP) as OPDys
    , sum(OV) as OVDys
    , Sum(ClaimDay) as ClaimDys
    , sum(iif(TramaFlag = 1 , ClaimDay, 0)) as ClaimDysTrama
    , Sum(ClaimDay) - sum(iif(TramaFlag = 1 , ClaimDay, 0))ClaimDysLssTrama
    , sum(Paid) as Paid
    , sum([TramaPaid]) as PaidTrama
    --, sum(Paid) - sum(iif(TramaFlag = 1 and (IP = 1 or ER = 1) , Paid, 0)) as PaidLssTrama
    , sum(Paid) - sum([TramaPaid]) as PaidLssTrama
    , sum([IPPaid]) as [IPPaid]
    , sum([IPPaid]) - sum([TramaIPPaid])  as [IPPaidLssTrama]
    , sum([ERPaid]) as [ERPaid]
    , sum([ERPaid]) - sum([TramaERPaid])  as [ERPaidLssTrama]
    , sum(Claims) as Claims
    , sum(iif(TramaFlag = 0 , Claims, 0)) as ClaimsLssTrama
    , sum(iif(TramaFlag = 1 , Claims, 0)) as ClaimsTrama
from Member_ClaimDays_vw
group by ClientID
    , PriMemberID
    , MemberID
    , YrMth
--having sum(IP) > 0
)

select *
, sum(PaidlssTrama) over (partition by ClientID, MemberID, Left(YrMth, 2) 
							 order by YrMth
							 rows between unbounded preceding and 0 preceding) as rtot
	   , iif(sum(PaidlssTrama) over (partition by ClientID, MemberID, Left(YrMth, 2) 
							 order by YrMth
							 rows between unbounded preceding and 0 preceding) > 100000,0,1) as stp
from b
GO
PRINT N'Creating [dbo].[Member_Claims_Util_PPPY_vw]...';


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
CREATE VIEW [dbo].[Member_Claims_Util_PPPY_vw]
	AS 
	select m.clientID 
    , m.PriMemberID
    , m.MemberID
	, max([MemberRelationship])  as Relationship
    , AnalyticYear as Year
	, count(distinct m.YrMthKey) as NbrMths
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
    --, iif(max(ExclFlg) = 1,0,iif(sum(PaidLssTrama) > 100000 , 100000, sum([ERPaidLssTrama]))) as [ERPaidLssTramaStExcl]

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

from [dbo].[Member_PPPM_vw]  m --select * from [dbo].[Member_PPPM_vw]
    left join Member_Claims_PPPM_vw c
	   on m.ClientID = C.ClientID
		  AND m.PriMemberID = c.PriMemberID
		  AND m.MemberID = c.MemberID
		  and m.YrMthKey = c.YrMth
    left join Member_Pharmacy_PPPM_vw p --select * from Member_Pharmacy_PPPM_vw 
	   on m.ClientID = p.ClientID
		--  AND m.PriMemberID = p.PriMemberID
		  AND m.MemberID = P.MemberID
		  and m.YrMthKey = p.YrMth
where YrMthKey >= 1401
group by m.clientID 
    , m.PriMemberID
    , m.MemberID
   , m.AnalyticYear
GO
PRINT N'Update complete.';


GO
