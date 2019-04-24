

CREATE view [dbo].[Member_Conditions_vw]
as
with a
as
(
select m.ID,  m.ClaimNumber
    , ClientID
    , PrimemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 1 as IsPrim
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on left(m.ICD1,4) = left(ic.ICDCode,4)
--where PaidAmt > 0
  --  and CondGrpType = 'Standard Condition'
group by  m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
union all
select m.ID,  m.ClaimNUmber
    , ClientID
    ,  primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on left(m.ICD2,4) = left(ic.ICDCode,4)
--where PaidAmt > 0
  --  and CondGrpType = 'Standard Condition'
group by 
    m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
union all
select m.ID,  m.ClaimNUmber 
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on left(m.ICD3,4) = left(ic.ICDCode,4)
--where PaidAmt > 0
 --   and CondGrpType = 'Standard Condition'
group by m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
union all
select m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on left(m.ICD4,4) = left(ic.ICDCode,4)
--where PaidAmt > 0
 --   and CondGrpType = 'Standard Condition'
group by m.ID,  m.ClaimNUmber

    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
)
select a.ClientID
, max([Custom4]) as EmplGrp 
    ,  a.primemberID
    , a.MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Min(FrstOcc) as FrstOcc
    , Max(LstOcc)  as LstOcc
    , count(distinct ClaimNumber) as Claims
    , sum([PaidAmt]) as PaidAmt
    , max(IsPrim) as IsPrim
from a
inner join [dbo].[MemberProfile_Base] m
	   on a.[ClientId] = m.clientID
		  and a.MemberID = m.MemberID
group by a.ClientID
 , a.primemberID
    , a.MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]