
/***********************************************
*   Name:		 dbo.Member_PPPM_vw
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

CREATE view [dbo].[Member_PPPM_vw]
as

select ClientId
    , MemberID
    , MemberRelationship
    , PriMemberID
    , max([MemberAge]) as MemberAge
    , max(MemberAgeGrp) as MemberAgeGrp
    , y.yr  as AnalyticYear 
    , me.YrMth AS YrMthKey
    , [MonthYear]
    , [Year] as CalYear
    , max(me.[State]) as State
    , max(me.[Zip]) as Zip
    , max(CostCenter) as CostCenter
    , max(MemberGroup) as MemberGroup
    , max(Custom1) as custom1
    , max(Custom1_lbl) as custom1_lbl
    , max(Custom2) as custom2
    , max(Custom1_lbl) as custom2_lbl
    , max(Custom3) as custom3
    , max(Custom1_lbl) as custom3_lbl
    , max(Custom4) as custom4
    , max(Custom1_lbl) as custom4_lbl
    , max(Custom4) as custom5
    , max(Custom1_lbl) as custom5_lbl
    , 1 as MthCntr
from [dbo].[MemberProfile_Base] me --select * from [dbo].[MemberProfile_Base] 
    inner join dbo.DateTable_Month dt
	   on me.YrMth = dt.YrMth
    inner join [dbo].[DateTable_Analytic_Year_vw] y
	   on me.YrMth between y.st and y.en
    where AltID is null
--where dt.[Date] between '2016-10-01' and '2017-09-30'
  --  and Custom2 <> 'PHAR1'
group by ClientId
    , MemberID
    , MemberRelationship
    , PriMemberID
    , me.YrMth
    , [MonthYear]
    , [year]
    , yr
