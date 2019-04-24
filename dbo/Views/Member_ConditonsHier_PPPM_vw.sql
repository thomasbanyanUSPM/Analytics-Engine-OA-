CREATE VIEW [dbo].[Member_ConditionsHier_PPPM_vw]
	AS 

select * 
    , case when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse') then 1
		when Condition = 'Congestive Heart Failure' then 2
		when Condition = 'CAD' then 3
		when Condition = 'COPD' then 4
		when Condition = 'Diabetes' then 5
		when Condition = 'Hypertension' then 6
		when Condition = 'Obesity' then 7
		when Condition = 'Back and Neck Pain' then 8
		when Condition = 'Asthma' then 9
		else 99 end as Hierarchy 
    , case  when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse')  then 'MH-6'  
		when Condition = 'Congestive Heart Failure' then 'Congestive Heart Failure'  
		when Condition = 'CAD' then 'CAD'
		when Condition = 'COPD' then 'COPD'
		when Condition = 'Diabetes' then 'Diabetes'
		when Condition = 'Hypertension' then 'Hypertension'
		when Condition = 'Obesity' then 'Obesity'
		when Condition = 'Back and Neck Pain' then 'Back and Neck Pain'
		when Condition = 'Asthma' then 'Asthma'
		  end as CondHier
    , dense_rank() over (partition by MemberID, Yr order by case when Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse') then 1
											   when Condition = 'Congestive Heart Failure' then 2
											   when Condition = 'CAD' then 3
											   when Condition = 'COPD' then 4
											   when Condition = 'Diabetes' then 5
											   when Condition = 'Hypertension' then 6
											   when Condition = 'Obesity' then 7
											   when Condition = 'Back and Neck Pain' then 8
											   when Condition = 'Asthma' then 9
											   end ASC )  as CondRnk

from [dbo].[Member_Conditions_PPPM_vw]
where CondGrpType = 'Standard Condition'
    and Condition in ('Affective Psychosis','Anxiety','Depression','Eating Disorders','PTSD','Substance Abuse', 'Congestive Heart Failure'
	   , 'CAD', 'COPD', 'Diabetes', 'Hypertension', 'Obesity' , 'Back and Neck Pain', 'Asthma' )

