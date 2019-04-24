
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
CREATE view [dbo].[Member_Pharmacy_PPPM_vw]
as
select  ClientID
	, PriMemberID
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
   , PriMemberID
    , MemberID
    , p.[YrMth] 
    , [Year] 
    , [Month]