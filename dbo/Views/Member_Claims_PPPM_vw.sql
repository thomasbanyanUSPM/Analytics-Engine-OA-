
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
