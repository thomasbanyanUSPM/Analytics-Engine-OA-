


CREATE view [dbo].[Member_Exclusion_PPPM_vw]
as
select distinct MemberID
 , primemberID
    , Excl
    , Onset
    , MstRcnt
    , YrMth
    , MonthYear
    --, Month as Mth
    --, Year as Yr
    , 0 as AmtPaidMth
    , [PaidAmt] as TotAmtPaid
from [dbo].[Member_Exclusion_vw] e
    inner join  [dbo].[DateTable_Month] md
	   on md.Date between e.Onset and e.MstRcnt




