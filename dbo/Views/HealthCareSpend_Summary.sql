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
