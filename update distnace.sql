select Row_number()OVER(order by id) RN, sr_no,id,t.value , '' calc into #temp from tbl_tendercleanprocess 
CROSS APPLY string_split(distance, ',')T
where distance is not null

1.8 - 10,6.6 - 8 - 10,8.2 - 4 - 6 - 8 - 10


select *      from #temp  order by 1 


DECLARE @sql  NVARCHAR(mAX), @string varchar(1000),@id varchar(100) = 1,@start int = 1 , @count int ;

SET @count = (select COUNt(1)      from #temp)
WHILE @start < @count
BEGIn
SELECT @string = replace(value,' - ','-'),@id =RN  FROM #temp  Where RN = @start

SET @sql = 'update #temp set calc = (SELECT CONVERT(VARCHAr(100),ABS('+@string+'))) where RN = '+@id+''
EXEC sp_executesql @sql
SET @start = @start +1
END


--update #temp set calc = (SELECT CONVERT(VARCHAr(100),ABS(8.2 - 4 - 6 - 8 - 10))) where RN = 3

--ALTER TABLE #temp  alter column calc varchar(200)

select *      from #temp  where  calc = ''


update  tbl_tendercleanprocess SET tbl_tendercleanprocess.calcdistance = n.calc

FROM (select id, string_agg(calc,',') WITHIN GROUP(ORDER BY RN) calc  from #temp where  calc <> '' group by id  ) as n
WHERE tbl_tendercleanprocess.id = N.id

select * from tbl_tendercleanprocess where distance is not null

3.650.-.5.250
select *,replace(value,' - ','-')
from #temp value

select dbo.ALPHA_3 ('57.00-58.00.59.00')
select 57.00-58.00.59.00-60.00

select *--,dbo.ALPHA_3 ('57.00-58.00.59.00-60.00')
from (

select case when value like '%=%' then substring(substring(value,(CHARINDEX('=',value))+1,datalength(value)),charindex('=',substring(value,(CHARINDEX('=',value))+1,datalength(value)))+1
,datalength(substring(value,(CHARINDEX('=',value))+1,datalength(value))))
else replace(replace(replace(value,' - ','-'),' . ','.'),' ','.')
end as frt
,value,replace(replace(replace(value,' - ','-'),' . ','.'),' ','.')chatr
from #temp value
where  calc like ''
)d

 tbl_tendercleanprocess
where Distance is  NULL

update  tbl_tendercleanprocess
set caldis_2 = case when value like '%=%' then substring(substring(value,(CHARINDEX('=',value))+1,datalength(value)),charindex('=',substring(value,(CHARINDEX('=',value))+1,datalength(value)))+1
       ,datalength(substring(value,(CHARINDEX('=',value))+1,datalength(value))))
else replace(replace(replace(value,' - ','-'),' . ','.'),' ','.')
end 


