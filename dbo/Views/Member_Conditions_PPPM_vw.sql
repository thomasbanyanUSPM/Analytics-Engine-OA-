create view [dbo].[Member_Conditions_PPPM_vw]
as
with a
as
(
select m.ID,  m.ClaimNumber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) as Yr
    , month(FromServiceDate) as Mth
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 1 as IsPrim
    , max([YrMth]) as YrMth
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on m.ICD1 = ic.ICDCode

group by  m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
union all
select m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
    , max([YrMth]) as YrMth
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on m.ICD2 = ic.ICDCode
group by 
    m.ID,  m.ClaimNUmber
     , primemberID
    , ClientID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
union all
select m.ID,  m.ClaimNUmber 
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
    , max([YrMth]) as YrMth
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on m.ICD3 = ic.ICDCode
group by m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
union all
select m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
    , Min(FromServiceDate) as FrstOcc
    , Max(FromServiceDate)  as LstOcc
    , sum([PaidAmt]) as PaidAmt
    , 0 as IsPrim
    , max([YrMth]) as YrMth
from [dbo].[MedicalClaims_Base] m
    inner join [dbo].[ref_ICDtoCond] ic
	   on m.ICD4 = ic.ICDCode
group by m.ID,  m.ClaimNUmber
    , ClientID
     , primemberID
    , MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Year(FromServiceDate) 
    , month(FromServiceDate) 
  )  

select a.ClientID
    , a.primemberID
    , a.MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Yr
    , Mth
    , Min(FrstOcc) as FrstOcc
    , Max(LstOcc)  as LstOcc
    , count(distinct ClaimNumber) as Claims
    , sum([PaidAmt]) as PaidAmt
    , max(IsPrim) as IsPrim
    , max([YrMth]) as YrMth
from a
group by a.ClientID
     , a.primemberID
    , a.MemberID
    , CondGrpType
    , [ConditionID]
    , [Condition]
    , Yr
    , Mth