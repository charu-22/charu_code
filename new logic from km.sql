WITH CTE AS (
SELECT TOP 2000 t.id,sr_no,dba.[dbo].[RegExReplace](
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'/','.'),'\','.'),'(',' /*('),')',')\?* '),'RD.','RD'),'kmp','km'),'km to','to'),'to km','to'),'km.','km '),'km',' km '),'ch.','ch '),'ch to','to'),'to ch','to'),'RD to','RD'),'to RD','to'),'pt','.'),'+','.')
,'\s+',' ') km,txt,value clean 
from tbl_tendercleanprocess T
  INNER JOIN [dbo].[uom] U ON  U.unit =  dba.dbo.regexmatch('\b(?:'+U.unit+'(?:\W+\w+){0,0}?)', T.value,1)
   Where   t.typ ='Location'
 )

select ROW_NUMBER()OVER(ORDER by id) Rn ,*  into #temp
from (
SELECT *, dba.dbo.regexmatch(
'\b(?:\d+(?:\D+\d+){0,100000}?\W+to(?:\D+\d+){0,100000})|(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:\d+(?:\W+\w+){0,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:km(?:\W+\w+){0,100000}?\d+)|(?:RD(?:\W+\w+){0,100000}?\d+)|(?:ch(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:ch(?:\W+\w+){0,100000}?\d+)'
,value,1)  t FROM CTE C
CROSS APPLY string_split(km, '/')
WHERE value not like '%*%' 
) as n
WHERE t <> ''
DROP TABLE #temp
--(?:km(?:\D+\d+){0,100000}?\W+to(?:\D+\d+){0,100000})


ALTER table #temp ADD distance varchar(10)
select *,
CASE WHEN DBA.dbo.regexmatch('km|ch|rd|mr|kilometer|to',t,1) In('km','ch','rd','mr','kilometer','to')  THEN
--DBA.dbo.RegExReplace(
DBA.dbo.regexmatch('\b(?:\d+(?:\D+\d+){0,100000}?-(?:\D+\d+){0,100000})|(?:\d+(?:\D+\d+){0,100000}?\d+)',REPLACE(REPLACE(REPLACE(t,'to.','-'),'to','-'),'_','.'),1)  --,'(\W+\w+[A-Z])',' ')
ELSE '' END Distance
--dba.dbo.regexmatch(REPLACE(t,'to','-'),valeu
--into Km
from #temp order by 1
 WHERE 
--|(?:\d+(?:\W+\w+){0,100000}?\d+) 


select ROW_NUMBER()OVER(order by RN) ids,RN,id,sr_no, T,  trim(match) calc  -- into #temps
from Km
cross apply  dba.dbo.RegExSplit('km|&|and|,',distance,1)
WHERE match <> '' and match not like  '@'and match not like  '%[A-Z]%'
ORDER BY RN

ALTER table #temps ADD calcdistance varchar(1000)

DROP TABLE #temps
select * from #temps





DECLARE @sql  NVARCHAR(mAX), @string varchar(1000),@id varchar(100) = 1,@start int = 1 , @count int ;

SET @count = (select COUNt(1)      from #temps)
WHILE @start < @count
BEGIn
SELECT @string = replace(calc,' - ','-'),@id =ids  FROM #temps  Where ids = @start

SET @sql = 'update #temps set calcdistance = (SELECT CONVERT(VARCHAr(1000),ABS('+@string+'))) where ids = '+@id+''
EXEC sp_executesql @sql
SET @start = @start +1
END




update  tbl_tendercleanprocess SET tbl_tendercleanprocess.calcdistance = n.calc, distance =  n.t

FROM (select id, t,  string_agg(calcdistance,',') WITHIN GROUP(ORDER BY rn asc) calc  
from #temps where  calcdistance <> '' 
group by id, t
  ) as n
WHERE tbl_tendercleanprocess.id = N.id

--select * from tbl_tendercleanprocess where distance is not null
string_agg(calcdistance,',') WITHIN GROUP(ORDER BY ids , rn, id) calc  


select id, t ,string_agg(calcdistance,',')  WITHIN GROUP(ORDER BY id ASC)  from (
select  ROW_NUMBER()OVER(ORDER BY ids,rn,id) ids ,id, t,  calcdistance
from #temps where  calcdistance <> '' 
) as n
group by id, t
ORDER BY 1


--select * from #temps ORDER BY ids , rn, id

