
create view [dbo].[Member_ClaimDays_vw]
as
with e
as
(
select distinct  MemberID m,  YrMth k
froM [dbo].[Member_Exclusion_PPPM_vw]


) 


, a
as
(
select  [ClientId] 
, PriMemberID
    , [MemberID]
    , FromServiceDate as ServiceDate
    , [YrMth]
    --, PlanGroupID
    --, [ClaimNumber]
     , max(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd3,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd3,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')) Then 1 else 0 end) 
		  as TramaFlag

     , sum(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd3,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd3,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')) Then PaidAmt else 0 end) 
		  as TramaPaid

      , sum(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd3,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd3,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015'))
		  and   ([ClassifierUSPM] = 'IP') 
		  Then PaidAmt else 0 end)
		  as TramaIPPaid

	  , sum(case when ((left(icd1,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd1,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd2,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd2,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')
	   or (left(icd3,1) in ( '8','9')  and convert(date,FromServiceDate) < '10/1/2015') 
	   or (left(icd3,1) in ('S','T')  and convert(date,FromServiceDate) >= '10/1/2015')) 
		  and   ([ClassifierUSPM] = 'ER')
			 Then PaidAmt else 0 end) 
		  as TramaERPaid

    , max(isnull(serviceDays,0)) as IPAdm
    --, max(case when  isnull( Procedure1,'') in  ('99238','99239') then '1' else '0' end) as IPDisch
    , max(case when [ClassifierUSPM] = 'IP' then 1 else 0 END) as 'IP'
    , max(case when [ClassifierUSPM] = 'ER' then 1 else 0 END) as 'ER'
    , max(case when [ClassifierUSPM] = 'OP' then 1 else 0 END) as 'OP'
    , max(case when [ClassifierUSPM] = 'OV' then 1 else 0 END) as 'OV'
    , max(case when [ClassifierUSPM] = 'OTH' then 1 else 0 END) as 'OTH'

    , sum(PaidAmt) as Paid
    , sum(case when [ClassifierUSPM] = 'IP' then PaidAmt else 0 END) as 'IPPaid'
    , sum(case when [ClassifierUSPM] = 'ER' then PaidAmt else 0 end) as 'ERPaid'

    , sum(case when [ClassifierUSPM] = 'OP' then PaidAmt else 0 END) as 'OPPaid'
    , sum(case when [ClassifierUSPM] = 'OV' then PaidAmt else 0 end) as 'OVPaid'
    , sum(case when [ClassifierUSPM] = 'OTH' then PaidAmt else 0 end) as 'OTHPaid'

    , count(distinct ClaimNumber) as Claims
    , max(iif(e.m is null, 0,1)) as ExclFlg
    , max(ICD1) as PrimDiagnosis
    , max(ICD2) as SecDiagnosis1
    , max(ICD3) as SecDiagnosis2
    , max(DRG_Cde) as DRG
from [dbo].[MedicalClaims_Base] mc
    left join e
	   on mc.MemberID = e.m
	   and [YrMth] = k
group by [ClientId]
    , PriMemberID
    , [MemberID]
    , FromServiceDate
    , [YrMth]

) --select * from a where memberID = 'QhieaE4qTXUhlQ' order by 3
 , a2
as
(
select * 

    , rank() over (partition by memberID order by  ServiceDate) as rnk
    , lag(IP,1,null) over (partition by [MemberID] order by ServiceDate) as priorIP
from a


)

, ip
as
(
select distinct dateadd(day, (n.n-1), ServiceDate) ipDay
, ClientID as c
, PriMemberID as pm
, MemberID as m
, ServiceDate as sd
, DRG as dd
, 1 as ipf
, n
--select * 
from a
    inner join dbo.number n
	   on a.IP >= n
where IP > 0
   -- and n = 1
 --   AND dateadd(day, n.n, FromServiceDate) 


) --select * from ip order by 3, 4, 1



select distinct ClientID
    , PriMemberID
    , MemberID
    , ServiceDate
    , YrMth
    , TramaFlag
    , isnull(IPAdm , 0) as IPAdm
  --  , ipf
    , iif((coalesce(ipf ,0) + coalesce(IPAdm ,0))> 0,1,0) as IP
    , iif(isnull(ipf,0) > 0,0,ER) as ER
    , iif(isnull(ipf,0) > 0,0,OP) as OP
    , iif(isnull(ipf,0) > 0,0,OV) as OV
    , iif(isnull(ipf,0) > 0,0,OTH) as OTH
    , 1 as ClaimDay
    , Paid
    , iif(isnull(ipf,0) > 0,Paid,0) as IPPaid
    , iif(isnull(ipf,0) > 0,0,ERPaid) as ERPaid
    , iif(isnull(ipf,0) > 0,0,OPPaid) as OPPaid
    , iif(isnull(ipf,0) > 0,0,OVPaid) as OVPaid
    , iif(isnull(ipf,0) > 0,0,OTHPaid) as OTHPaid
    , TramaPaid
    , iif(isnull(ipf,0) > 0,TramaPaid,0) as TramaIPPaid
    , iif(isnull(ipf,0) > 0,0,TramaERPaid) as TramaERPaid
    , Claims
    , ExclFlg
    , PrimDiagnosis
    , SecDiagnosis1
    , SecDiagnosis2
    , ip.dd as DRG
from a2
    left join ip
	   on a2.memberID = ip.m
		  and a2.primemberid = ip.pm
		  and a2.ServiceDate = ip.ipDay
