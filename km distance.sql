With  cte as (
  select * from (
  select *
  ,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000}?\d+(?:\d+){0,200})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:\d+(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000}?\d+(?:\d+){0,200})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10}) ',match,1)  abc
  from (
   select 
  * from (
  SELECT TOP 2000 T.id,T.sr_no,dba.[dbo].[RegExReplace](REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
  REPLACE(
  REPLACE(lower(value),'th',''),'km.','km'),'km. to',' to '),'km &',' to '),'km to',' to '),'to km',' to '),'pt','.'),'ch.',''),'ch','')
                                       ,'from','')
									              ,'/','.')
												            ,'+','.')
															     ,'-',' to ')
						  										    
																	      ,'(',' /(')
																		       ,')',')/ ')
  --,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:\d+(?:\W+\w+\d+){222,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:km(?:\W+\w+\D+\d+\S+\s+){0,100000}?\d+ )',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'from',''),'/','.'),'+','.'),'-',' to '),'and',' to '),1) 
--  km -- into km
,'\s+|_',' ') value  -- drop table kmmeter
  from tbl_tendercleanprocess T
  INNER JOIN [dbo].[uom] U ON  U.unit =  dba.dbo.regexmatch('\b(?:'+U.unit+'(?:\W+\w+){0,0}?)', T.value,1)
   Where   t.typ ='Location'
   ) AS N
   cross applY DBA.DBO.RegExSplit('[\/]',value,1)  
   WHERE  MATCH NOT LIKE '%(%'
   
   ) as n 
   WHERE  MATCH NOT LIKE '%)%'  AND MATCH <> ''
   ) as n 
   ) select id,sr_no,value,Match , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(abc,'1st',''),'2nd',''),'3rd',''),'rd.',''),'rd',''),'&',','),'and',','),'km',' ') abc  --,CASE WHEN MATCH = '' THEN DBA.dbo.regexmatch('(?:\d+(?:\D+\d+){0,100000})',match,1) ELSE abc END  
  -- into  kmmeter
   from cte
    --ALTER table kmmeter ADD distance numeric(18,2)
  -- DROP TABLE   kmmeter

   --update kmmeter set abc=  DBA.dbo.regexmatch('(\d+\S+)',match,1) WHERE abc = '' 

   ALTER table tbl_tendercleanprocess ADD distance varchar(1000)
update tbl_tendercleanprocess SET tbl_tendercleanprocess.distance =  B.km

 from  ( select id , sr_no , string_agg( km,',') km
  --, CONVERT(numeric,SUBSTRING(km,1,charindex('-',km)-1)),CONVERT(numeric,SUBSTRING(km,charindex('-',km)+1,Len(km)))
   from (
   select distinct  id , value, sr_no,dba.[dbo].[RegExReplace](Rtrim(ltrim(REPLACE(k.match,'to','-'))),'\s+',' ') km from kmmeter
cross applY DBA.DBO.RegExSplit(',',abc,1) k  
--
) as N 
--CROSS APPLY string_split(km,'-')
--WHERE km not like '%[A-Z]%' and km like '%-%'
GRoup by id , sr_no
) as b Where b.id =tbl_tendercleanprocess.id and B.Sr_no = tbl_tendercleanprocess.Sr_no




--SELECT dba.dbo.RegexMatch('^[0-9]{5,5}([. ]?[0-9]{4,4}[-])?$[0-9]{5,5}([. ]?[0-9]{4,4})','02115.4653-065',1)
----WHERE abc  like '%&%' 

--select * from tbl_tendercleanprocess where distance is not null
   