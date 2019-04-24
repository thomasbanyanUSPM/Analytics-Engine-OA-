
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
