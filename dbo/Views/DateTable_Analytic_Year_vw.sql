
CREATE view [dbo].[DateTable_Analytic_Year_vw]
as

select 2014 as yr, '1401' as st, '1412' as en
union
select 2015 as yr, '1501' as st, '1512' as en
union
select 2016 as yr, '1601' as st, '1612' as en
union
select 2017 as yr, '1701' as st, '1712' as en
union
select 2018 as yr, '1801' as st, '1812' as en
