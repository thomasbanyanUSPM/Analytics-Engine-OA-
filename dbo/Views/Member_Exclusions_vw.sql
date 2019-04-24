


CREATE view [dbo].[Member_Exclusion_vw]
as
with a
as
(
select --PriMemberID + '_' +  MemberRelCode + '_' + convert(varchar(4),year(convert(date,FromServiceDate)))+ '_' + convert(varchar(2),month(convert(date,FromServiceDate))) as MemberID_YMK
      MemberID
	, primemberID
    , case when Procedure1 in ('38240','38241','38242', '38243') then 'Transplant-Bone Marrow'
	   when Procedure1 in ('33945','33933','33944')  then 'Transplant-Heart'
	   when Procedure1 in ('33935')  then 'Transplant-HeartLung'
	   when Procedure1 in  ('44135','44136','44132','44133','44137') or Procedure1 between '44715' and '44721' then 'Transplant-Intestines'
	   when Procedure1 in ('47135','47136') or Procedure1 between '47143' and '47147'  then 'Transplant-Liver' 
	   when Procedure1 in ('32855','32856','33933','32850','32854','32853','32852','32851') then 'Transplant-Lung' 
	   when Procedure1 in ('48160','48550','48554','48555','48556','48551','48552')  then 'Transplant-Pancreas' 
	   when Procedure1 in ('60512')  then 'Transplant-Parathyroid' 
	   when Procedure1 in ('50360','50365','50380','50547','50340','50370')
		  or Procedure1 between '50323' and '50329' or Procedure1 between '50300' and '50320'  then 'Transplant-Renal' 
	   when left(billingCode, 1) = '2' then 'SNF'  --POS = '31' or 
	   when PlaceOfService = '34' then 'Hospice'
	--   when left(ICD1,3) = 'V23' or  ICD1 like 'O09%' then 'High Risk OB' 
	   when ICD1 in ('5856', 'N186') or ICD2 in ('5856', 'N186') then 'ESRD'
	   when left(ICD1,3) in ('042', 'B20') or left(ICD2,3) in ('042', 'B20') then 'HIV/AIDS'
	   when left(ICD1,3) ='286' or ICD1 = 'Z140' or ICD1 = 'D683' or left(ICD1,3) ='D66' then 'Hemophilia' 
	  
	   end  as Excl
	   , min(FromServiceDate) as Onset
	   , max(ToServiceDate) as MstRcnt
	   , sum(convert(money,PaidAmt)) as PaidAmt 
from [dbo].[MedicalClaims_Base]
group 
 by [MemberID]
  , primemberID
    , case when Procedure1 in ('38240','38241','38242', '38243') then 'Transplant-Bone Marrow'
	   when Procedure1 in ('33945','33933','33944')  then 'Transplant-Heart'
	   when Procedure1 in ('33935')  then 'Transplant-HeartLung'
	   when Procedure1 in  ('44135','44136','44132','44133','44137') or Procedure1 between '44715' and '44721' then 'Transplant-Intestines'
	   when Procedure1 in ('47135','47136') or Procedure1 between '47143' and '47147'  then 'Transplant-Liver' 
	   when Procedure1 in ('32855','32856','33933','32850','32854','32853','32852','32851') then 'Transplant-Lung' 
	   when Procedure1 in ('48160','48550','48554','48555','48556','48551','48552')  then 'Transplant-Pancreas' 
	   when Procedure1 in ('60512')  then 'Transplant-Parathyroid' 
	   when Procedure1 in ('50360','50365','50380','50547','50340','50370')
		  or Procedure1 between '50323' and '50329' or Procedure1 between '50300' and '50320'  then 'Transplant-Renal' 
	   when left(billingCode, 1) = '2' then 'SNF'  --POS = '31' or 
	   when PlaceOfService = '34' then 'Hospice'
	--   when left(ICD1,3) = 'V23' or  ICD1 like 'O09%' then 'High Risk OB' 
	   when ICD1 in ('5856', 'N186') or ICD2 in ('5856', 'N186') then 'ESRD'
	   when left(ICD1,3) in ('042', 'B20') or left(ICD2,3) in ('042', 'B20') then 'HIV/AIDS'
	   when left(ICD1,3) ='286' or ICD1 = 'Z140' or ICD1 = 'D683' or left(ICD1,3) ='D66' then 'Hemophilia' 
	   
	   end 
having sum(convert(money,PaidAmt)) > 500
)
select *
from a
where Excl is not null
union all
select MemberID
 , primemberID
    , 'Cancer'
    , FrstOcc
    , LstOcc
    , sum([PaidAmt]) as [PaidAmt]
from [dbo].[Member_Conditions_vw]
where Condition = 'Cancer'
group by MemberID
 , primemberID
    , FrstOcc
    , LstOcc
having sum(convert(money,PaidAmt)) > 500

GO


