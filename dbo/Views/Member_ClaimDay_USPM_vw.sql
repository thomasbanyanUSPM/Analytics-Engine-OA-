



CREATE view [dbo].[Member_ClaimDay_USPM_vw]
as
with a
as
(
SELECT [ClientID]
, [PrimemberID]
      ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
      ,[IPAdm]
      ,[IP]
      ,[ER]
      ,[OP]
      ,[OV]
      ,[OTH]
      ,[ClaimDay]
      ,[Paid]
      ,[IPPaid]
      ,[ERPaid]
      ,[OPPaid]
      ,[OVPaid]
      ,[OTHPaid]
      ,[TramaPaid]
      ,[TramaIPPaid]
      ,[TramaERPaid]
      ,[Claims]
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
  FROM [dbo].[Member_ClaimDays_vw]

)


SELECT [ClientID]
	   , [PriMemberID]
      ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
      ,[IPAdm]
      ,'IP' as USPMClass
      ,[IPPaid] as Paid
      ,[TramaIPPaid] as TramaPaid
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
FROM a
where IP > 0
union
SELECT [ClientID]
      , [PriMemberID]
	 ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
	 , 0
      ,'ER'
      ,[ERPaid]
      ,[TramaERPaid]
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
  FROM a
  where [ER] > 0
union
SELECT [ClientID]
    , [PriMemberID]
      ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
      , 0
      ,'OP'
      ,[OPPaid]
      , 0
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
from a
where [OP] > 0
union
SELECT [ClientID]
	   , [PriMemberID]
      ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
      , 0
      ,'OV'
      ,[OVPaid]
      , 0
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
from a
where [OV] > 0
union
SELECT [ClientID]
    , [PriMemberID]
      ,[MemberID]
      ,[ServiceDate]
      ,[YrMth]
      ,[TramaFlag]
	 , 0
      ,'OTH'
	 ,[OTHPaid]
      , 0
      ,[ExclFlg]
      ,[PrimDiagnosis]
      ,[SecDiagnosis1]
      ,[SecDiagnosis2]
      ,[DRG]
from a
where [OTH] > 0




