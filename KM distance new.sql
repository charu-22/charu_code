DECLARE @SQL NVARCHAR(MAX), @Replace VARCHAR(MAX), @value  VARCHAR(MAX),  @UOM NVARCHAR(MAX), @P0UOM NVARCHAR(MAX),@P1UOM NVARCHAR(MAX) ,
@Replace1 VARCHAR(MAX), @value1  VARCHAR(MAX);

--DROP TABLE tempdist
--DROP TABLE tempkmdis
--DROP TABLE tempKm

--select  distinct T.id  into tempdist  from tbl_tendercleanprocess T
--  INNER JOIN [dbo].[uom] U ON  U.unit =  dba.dbo.regexmatch('\b(?:'+U.unit+'(?:\W+\w+){0,0}?)', T.value,1)
--   Where T.id in (   select id from #temps) 
--   GROUP BY t.id
--   ORDER BY t.id

--   DROP TABLE #temps

--   select distinct  tdp.id into #temps  from tbl_tendercleanprocess tdp  
--        INNER JOIN tbl_tendercleanprocessword tdpw ON tdp.Sr_no=tdpw.sr_no  
------   select * from #temps Where id  = 279

--select * from tbl_tendercleanprocess where sr_no = 5530334
--   select * from  #temps where id  = 86199
---  select * from tempdist Where id  = 279

SELECT  @Replace = STRING_AGG( 'REPLACE(' ,' ') 
, @value = STRING_AGG( CONCAT(',',CHAR(39)+Cunit+CHAR(39),',',CHAR(39)+' '+Punit+' '+CHAR(39),')') 
,' ') 
FROM (
SELECT ROW_NUMBER()OVER(ORDER BY P.id)RN,P.unit Punit,C.unit Cunit FROM uom P
INNER JOIN uom C ON C.patternlevel = P.id
WHERE p.ispattern = 1
) AS N 
--SELECT @Replace = @Replace+ STRING_AGG('REPLACE(REPLACE(',' ') 
--,@value= @value+ STRING_AGG( ','+CHAR(39)+'to '+P.unit+CHAR(39)+','+CHAR(39)+' '+P.unit+' '+CHAR(39)+'),'+CHAR(39)+P.unit+' to'+CHAR(39)+','+CHAR(39)+' '+P.unit+' '+CHAR(39)+')'  ,' ') 
--FROM uom P
--WHERE p.ispattern = 1


SELECT @Replace = @Replace+string_agg('REPLACE(REPLACE(',''),@value = @value+string_agg(','+CHAR(39)+R.replacevalue+' '+P.unit+CHAR(39)+','+CHAR(39)+' to '+CHAR(39)+'),'+CHAR(39)+P.unit+' '+R.replacevalue+CHAR(39)+','+CHAR(39)+' to '+CHAR(39)+')' ,'')
FROM uom P
CROSS JOIN [dbo].[tbl_replacevalue] R
WHERE ispattern = 1 and isuom = 1

SELECT @Replace = @Replace+string_agg('REPLACE(',''),@value = @value+string_agg(','+CHAR(39)+R.replacevalue+CHAR(39)+','+CHAR(39)+''+CHAR(39)+')','')
FROM  [dbo].[tbl_replacevalue] R
WHERE   R.isreplace = 1

select  @UOM = STRING_AGG(REPLACE(REPLACE(pattern,'@p1',unit),'@p2','to'),'|') WITHIN GROUP(ORDER BY uom.id ASC) from uom 
  CROSS APPLY [dbo].[tbl_regexpattern]
  where ispattern = 1


 SELECT @Replace1 = string_agg('REPLACE(REPLACE(',''),@value1  = string_agg(','+CHAR(39)+R.replacevalue+' '+P.unit+CHAR(39)+','+CHAR(39)+'to'+CHAR(39)+'),'+CHAR(39)+P.unit+' '+R.replacevalue+CHAR(39)+','+CHAR(39)+'to'+CHAR(39)+')' ,'')
FROM uom P
CROSS JOIN [dbo].[tbl_replacevalue] R
WHERE ispattern = 1 and isuom = 1
  


SELECT   @P0UOM = STRING_AGG(unit,'|') WITHIN GROUP(ORDER BY uom.id ASC) ,@P1UOM = STRING_AGG(CHAR(39)+unit+CHAR(39),',') FROM uom WHERE ispattern = 1 

SET  @SQL = '
WITH CTE AS (
SELECT t.id,sr_no,dba.[dbo].[RegExReplace](
 '+@Replace+'REPLACE(REPLACE( REPLACE( REPLACE( REPLACE( 
REPLACE(REPLACE(REPLACE(REPLACE(T.value,''/'',''.''),''\'',''.''),''('','' /*(''),'')'','')\?* ''),''pt'',''.''),''+'',''.''),''"'',''''), ''“'', ''''), ''”'', '''')
,''\s+'','' '')'+@value+' km,txt,value clean 
from tbl_tendercleanprocess T WHERE T.id in ( select id from tempdist) AND isnull(calcDistance,'''') =''''
)
select ROW_NUMBER()OVER(ORDER by id) Rn ,*  into tempkmdis
from (
SELECT *, dba.dbo.regexmatch('+CHAR(39)+'\b'+@UOM+CHAR(39)+',value,1)  t FROM CTE C
CROSS APPLY string_split(km, ''/'')
WHERE value not like ''%*%'' 
) as n
WHERE t <> ''''

select RN,id,Sr_no,km,Txt,clean,value,t,CASE WHEN isnull(distance1,'''') = '''' tHEn distance2 ELSe Distance1 END distance into tempKm from (
SELECT *,
     
	( CASE
         WHEN dba.dbo.Regexmatch('+CHAR(39)+@P0UOM+CHAR(39)+', t, 1) IN('+@P1UOM+') THEN
dba.dbo.Regexmatch(''\b(?:\d+(?:\D+\d+){0,100000}?-(?:\D+\d+){0,100000})|\b(?:\d+(?:\D+\d+){0,100000}?\d+)|\b(?:\w+\D+\d+(?:\d+){0,100000}?-(?:\D+\d+){0,100000})'',

Replace(Replace(Replace(Replace(Replace('+@Replace1+'dba.dbo.RegExReplace(t,''\s+'','' '')'+@value1+', ''to.'', ''-''), ''to'', ''-''), ''_'', ''.''), ''-'', '' - ''),''yo'',''-''), 1)
  END)Distance1,
dba.dbo.Regexmatch(''\b(?:\d+(?:\D+\d+){0,100000}?-(?:\D+\d+){0,100000})|\b(?:\d+(?:\D+\d+){0,100000}?\d+)|\b(?:\d+\D+(?:\d+\D+){0,100000}?-(?:\D+\d+){0,100000})'',

Replace(Replace(Replace(Replace(Replace('+@Replace1+'dba.dbo.RegExReplace(t,''\s+'','' '')'+@value1+', ''to.'', ''-''), ''to'', ''-''), ''_'', ''.''), ''-'', '' - ''),''yo'',''-''), 1)

Distance2
FROM   tempkmdis

) as n
ORDER  BY 1'
--into tempKm
--select * from tempKm order by 1
select @SQL

EXEC SP_executesql @SQL

DROP TABLE #temps

select ROW_NUMBER()OVER(order by RN) ids,RN,id,sr_no, T,  trim(match) calc  into #temps
from tempKm
cross apply  dba.dbo.RegExSplit('km|&|and|,',distance,1)
WHERE match <> '' and match not like  '@' --and match not like  '%[A-Z]%' 
ORDER BY RN

ALTER table #temps ADD calcdistance varchar(1000)

DECLARE @sql1  NVARCHAR(mAX), @string varchar(1000),@id varchar(100) = 1,@start int = 1 , @count int, @sr_no int ;

SET @count = (select COUNt(1)      from #temps)
WHILE @start < @count
BEGIn
SELECT @string = replace(calc,' - ','-'),@id =ids,@sr_no = sr_no  FROM #temps  Where ids = @start

SET @string = CASE WHEN @string like '%=%' THEN SUBSTRING(@string,1,CHARINDEX('=',@string)-1) ELSE @string END;

BEGIN TRY
SET @sql1 = 'update #temps set calcdistance = (SELECT CONVERT(VARCHAr(1000),ABS('+@string+'))) where ids = '+@id+''
EXEC sp_executesql @sql1
END TRY
BEGIN CATCH
INSERT INTO [dbo].[tbl_logdistance](parentid,[createdon])values(@sr_no,GETDATE())

END CATCH

SET @start = @start +1
END
 



update  tbl_tendercleanprocess SET tbl_tendercleanprocess.calcdistance = n.calc, isdistance = 1

FROM (select id, t,  string_agg(calcdistance,',') WITHIN GROUP(ORDER BY rn asc) calc  
from #temps where  calcdistance <> '' 
group by id, t
  ) as n
WHERE tbl_tendercleanprocess.id = N.id



select tbl_tendercleanprocess.calcdistance , n.calc 

FROM tbl_tendercleanprocess
 , 
(select id, t,  string_agg(calcdistance,',') WITHIN GROUP(ORDER BY rn asc) calc  
from #temps where  calcdistance <> '' 
group by id, t
  ) as n
WHERE tbl_tendercleanprocess.id = N.id



select * from tbl_tendercleanprocessword where sr_no  =4877706