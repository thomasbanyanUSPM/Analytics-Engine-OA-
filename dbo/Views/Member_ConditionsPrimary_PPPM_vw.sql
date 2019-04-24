CREATE VIEW [dbo].[Member_ConditionsPrimary_PPPM_vw]
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
