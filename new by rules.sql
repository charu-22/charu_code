
DECLARE @string varchar(MAX);

select @string =  STRING_AGG(abc,'') from (
select  (CONCAT(firstrule,'(?:\W+\w+){0,100000}?\W+',secondrule,'|')) abc from   RuleMatrix WHERE firstrule = 'OF'

) as n

--select  distinct  STRING_AGG((CONCAT(firstrule,'(?:\W+\w+){0,100000}?\W+',secondrule,'|')) ,'')from   RuleMatrix WHERE firstrule = 'OF'
SET @string = CONCAT('dbo.regexmatch(',CHAr(39),'\b(?:',SUBSTRING(@string,1,LEN(@string)-1),')'+CHAR(39),',tenderdetails,1)')


--select *,dbo.regexmatch('\b(?:of(?:\W+\w+){0,100000}?\W+aboard|of(?:\W+\w+){0,100000}?\W+about|of(?:\W+\w+){0,100000}?\W+above|of(?:\W+\w+){0,100000}?\W+across|of(?:\W+\w+){0,100000}?\W+after|of(?:\W+\w+){0,100000}?\W+against|of(?:\W+\w+){0,100000}?\W+along|of(?:\W+\w+){0,100000}?\W+amid|of(?:\W+\w+){0,100000}?\W+among|of(?:\W+\w+){0,100000}?\W+around|of(?:\W+\w+){0,100000}?\W+as|of(?:\W+\w+){0,100000}?\W+at|of(?:\W+\w+){0,100000}?\W+before|of(?:\W+\w+){0,100000}?\W+behind|of(?:\W+\w+){0,100000}?\W+below|of(?:\W+\w+){0,100000}?\W+beneath|of(?:\W+\w+){0,100000}?\W+beside|of(?:\W+\w+){0,100000}?\W+between|of(?:\W+\w+){0,100000}?\W+beyond|of(?:\W+\w+){0,100000}?\W+but|of(?:\W+\w+){0,100000}?\W+by|of(?:\W+\w+){0,100000}?\W+close to|of(?:\W+\w+){0,100000}?\W+concerning|of(?:\W+\w+){0,100000}?\W+considering|of(?:\W+\w+){0,100000}?\W+despite|of(?:\W+\w+){0,100000}?\W+down|of(?:\W+\w+){0,100000}?\W+during|of(?:\W+\w+){0,100000}?\W+except|of(?:\W+\w+){0,100000}?\W+following|of(?:\W+\w+){0,100000}?\W+in front of|of(?:\W+\w+){0,100000}?\W+in|of(?:\W+\w+){0,100000}?\W+including|of(?:\W+\w+){0,100000}?\W+inside|of(?:\W+\w+){0,100000}?\W+into|of(?:\W+\w+){0,100000}?\W+like|of(?:\W+\w+){0,100000}?\W+minus|of(?:\W+\w+){0,100000}?\W+near|of(?:\W+\w+){0,100000}?\W+next to|of(?:\W+\w+){0,100000}?\W+next|of(?:\W+\w+){0,100000}?\W+off|of(?:\W+\w+){0,100000}?\W+onto|of(?:\W+\w+){0,100000}?\W+opposite|of(?:\W+\w+){0,100000}?\W+out of|of(?:\W+\w+){0,100000}?\W+out|of(?:\W+\w+){0,100000}?\W+outside|of(?:\W+\w+){0,100000}?\W+past|of(?:\W+\w+){0,100000}?\W+per|of(?:\W+\w+){0,100000}?\W+plus|of(?:\W+\w+){0,100000}?\W+regarding|of(?:\W+\w+){0,100000}?\W+round|of(?:\W+\w+){0,100000}?\W+save|of(?:\W+\w+){0,100000}?\W+since|of(?:\W+\w+){0,100000}?\W+than|of(?:\W+\w+){0,100000}?\W+through|of(?:\W+\w+){0,100000}?\W+toward|of(?:\W+\w+){0,100000}?\W+towards|of(?:\W+\w+){0,100000}?\W+underneath|of(?:\W+\w+){0,100000}?\W+unlike|of(?:\W+\w+){0,100000}?\W+until|of(?:\W+\w+){0,100000}?\W+up|of(?:\W+\w+){0,100000}?\W+upon|of(?:\W+\w+){0,100000}?\W+versus|of(?:\W+\w+){0,100000}?\W+via|of(?:\W+\w+){0,100000}?\W+within|of(?:\W+\w+){0,100000}?\W+without)',tenderdetails,1) 
--from (
--SELECT sr_no,[Match] tenderdetails FROM  tbl_tendercleanprocess 
--CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)
-- where sr_no in (37965042,59188494,44374122,44367585,44367703)
--) as n 


 --into [NewTendersTest].dbo.tblcleantext
DECLARE @SQL NVARCHAR(MAX)
--INSERT INTO [DataCleanProcess].dbo.tbl_tendercleanprocess(sr_no,txt,value,typ)
SET @SQL = N'
SELECt Sr_no ,tenderdetails ,CASE WHEN txt = '''' THEN tenderdetails ELSE txt END txt into [NewTendersTest].dbo.tblcleantext FROM (
SELECT Sr_no ,tenderdetails,   '+@string+'  Txt
From (
select sr_no,

[dbo].[RegExReplace]([dbo].[RegExReplace](Match,''[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]'','' ''),''\s+|_'','' '')

tenderdetails
FROM tbl_tendercleanprocess


CROSS APPLY [dbo].[RegExSplit](''(?<=[.!?][''''"\s])\s*(?=[A-Z])'',REPLACE(REPLACE(tenderdetails,'' <br />'',''''),''#*'',''''),1)
--where sr_no in (37965042,59188494,44374122,44367585,44367703)
) as B
) as N
'
--select @SQL
execute sp_executesql @SQL




  SELECt Sr_no ,tenderdetails ,CASE WHEN txt = '' THEN tenderdetails ELSE txt END txt into  FROM ( 
  SELECT Sr_no ,tenderdetails,   dbo.regexmatch('\b(?:of(?:\W+\w+){0,100000}?\W+aboard|of(?:\W+\w+){0,100000}?\W+about|of(?:\W+\w+){0,100000}?\W+above|of(?:\W+\w+){0,100000}?\W+across|of(?:\W+\w+){0,100000}?\W+after|of(?:\W+\w+){0,100000}?\W+against|of(?:\W+\w+){0,100000}?\W+along|of(?:\W+\w+){0,100000}?\W+amid|of(?:\W+\w+){0,100000}?\W+among|of(?:\W+\w+){0,100000}?\W+around|of(?:\W+\w+){0,100000}?\W+as|of(?:\W+\w+){0,100000}?\W+at|of(?:\W+\w+){0,100000}?\W+before|of(?:\W+\w+){0,100000}?\W+behind|of(?:\W+\w+){0,100000}?\W+below|of(?:\W+\w+){0,100000}?\W+beneath|of(?:\W+\w+){0,100000}?\W+beside|of(?:\W+\w+){0,100000}?\W+between|of(?:\W+\w+){0,100000}?\W+beyond|of(?:\W+\w+){0,100000}?\W+but|of(?:\W+\w+){0,100000}?\W+by|of(?:\W+\w+){0,100000}?\W+close to|of(?:\W+\w+){0,100000}?\W+concerning|of(?:\W+\w+){0,100000}?\W+considering|of(?:\W+\w+){0,100000}?\W+despite|of(?:\W+\w+){0,100000}?\W+down|of(?:\W+\w+){0,100000}?\W+during|of(?:\W+\w+){0,100000}?\W+except|of(?:\W+\w+){0,100000}?\W+following|of(?:\W+\w+){0,100000}?\W+in|of(?:\W+\w+){0,100000}?\W+in front of|of(?:\W+\w+){0,100000}?\W+inside|of(?:\W+\w+){0,100000}?\W+into|of(?:\W+\w+){0,100000}?\W+like|of(?:\W+\w+){0,100000}?\W+minus|of(?:\W+\w+){0,100000}?\W+near|of(?:\W+\w+){0,100000}?\W+next|of(?:\W+\w+){0,100000}?\W+next to|of(?:\W+\w+){0,100000}?\W+off|of(?:\W+\w+){0,100000}?\W+onto|of(?:\W+\w+){0,100000}?\W+opposite|of(?:\W+\w+){0,100000}?\W+out|of(?:\W+\w+){0,100000}?\W+out of|of(?:\W+\w+){0,100000}?\W+outside|of(?:\W+\w+){0,100000}?\W+past|of(?:\W+\w+){0,100000}?\W+per|of(?:\W+\w+){0,100000}?\W+plus|of(?:\W+\w+){0,100000}?\W+regarding|of(?:\W+\w+){0,100000}?\W+round|of(?:\W+\w+){0,100000}?\W+save|of(?:\W+\w+){0,100000}?\W+since|of(?:\W+\w+){0,100000}?\W+than|of(?:\W+\w+){0,100000}?\W+through|of(?:\W+\w+){0,100000}?\W+toward|of(?:\W+\w+){0,100000}?\W+towards|of(?:\W+\w+){0,100000}?\W+underneath|of(?:\W+\w+){0,100000}?\W+unlike|of(?:\W+\w+){0,100000}?\W+until|of(?:\W+\w+){0,100000}?\W+up|of(?:\W+\w+){0,100000}?\W+upon|of(?:\W+\w+){0,100000}?\W+versus|of(?:\W+\w+){0,100000}?\W+via|of(?:\W+\w+){0,100000}?\W+within|of(?:\W+\w+){0,100000}?\W+without|of(?:\W+\w+){0,100000}?\W+including|of(?:\W+\w+){0,100000}?\W+in|of(?:\W+\w+){0,100000}?\W+with)',tenderdetails,1)  Txt  From ( 
  select sr_no,    [dbo].[RegExReplace]([dbo].[RegExReplace]
  (Match,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]',' '),'\s+|_',' ')    tenderdetails   FROM tbl_tendercleanprocess    
  CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)  --where sr_no in (37965042,59188494,44374122,44367585,44367703) 
  ) as B  ) as N  
  

  select *,dbo.regexmatch('\b(?:km(?:\W+\w+\d+){0,100000}?\W+to(?:\W+\w+\d+){0,10})',tenderdetails,1) from tbl_tendercleanprocess Where tenderdetails like '%Km%'

  /(\d+[a-z0-9]+[a-z](?<!km\b))(?:,|$)/i

  SELECT *,dbo.regexmatch('\b(?:km(?:\W+\w+\d+){0,100000}?\W+to(?:\W+\w+\d+){0,10})',tenderdetails,1) FROM (
  select sr_no,    [dbo].[RegExReplace]([dbo].[RegExReplace]
  (Match,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]',' '),'\s+|_',' ')    tenderdetails   FROM tbl_tendercleanprocess    
  CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1) Where tenderdetails like '% Km %' --where sr_no in (37965042,59188494,44374122,44367585,44367703) 
  ) AS N

  select * from tbl_tendercleanprocess WHERE value like '% Km %'
  (?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10})
  
  select sr_no,value 
  ,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:km(?:\W+\w+\D+\d+\S+\s+){0,100000}?\d+ )',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'from',''),'/','.'),'+','.'),'-',' to '),'and',' to '),1) 
  km -- into km
  from tbl_tendercleanprocess Where value like '% Km %'


  -- (?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10}?\W+to(?:\W+\w+\d+){0,100000})

  --(?:"|(?!^)\G)\K([^ "]*) +(?=[^"]*")

  select 
  * from (
   SELECT sr_no,value,Match
  --,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:km(?:\W+\w+\D+\d+\S+\s+){0,100000}?\d+ )',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'from',''),'/','.'),'+','.'),'-',' to '),'and',' to '),1) 
--  km -- into km
  from tbl_tendercleanprocess
  cross applY DBA.DBO.RegExSplit('[\(-(,))]',value,1)  
  Where value like '% Km %'
  ) as n
  cross applY DBA.DBO.RegExSplit('[\(?*)] ',Match,1)  

  select * from (
  select *
  ,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000}?\d+(?:\d+){0,200})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:\d+(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000}?\d+(?:\d+){0,200})|(?:\d+(?:\W+\w+\d+){0,100000}?\W+km(?:\W+\w+\d+){0,10}) ',match,1)  abc
  from (
   select 
  * from (
  SELECT id,sr_no,dba.[dbo].[RegExReplace](REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
  REPLACE(value,'th',''),'km.','km'),'km. to',' to '),'km to',' to '),'to km',' to '),'pt','.')
                                       ,'from','')
									              ,'/','.')
												            ,'+','.')
															     ,'-',' to ')
						  										    
																	      ,'(',' /(')
																		       ,')',')/ ')
  --,dba.dbo.regexmatch('\b(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000})|(?:\d+(?:\W+\w+\d+){222,100000}?\W+km(?:\W+\w+\d+){0,10})|(?:km(?:\W+\w+\D+\d+\S+\s+){0,100000}?\d+ )',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'from',''),'/','.'),'+','.'),'-',' to '),'and',' to '),1) 
--  km -- into km
,'\s+|_',' ')value
  from tbl_tendercleanprocess
   Where value like '% Km %'
   ) AS N
   cross applY DBA.DBO.RegExSplit('[\/]',value,1)  
   WHERE  MATCH NOT LIKE '%(%'
   
   ) as n 
   WHERE  MATCH NOT LIKE '%)%' AND MATCH <> ''
   ) as n where abc = ''
   
  -- 58635578

  --km 0.0 to 1.200,1.800 to 42.400,43.900 to 44.100, 47.400 to 59. 100, 64.450 to 72.080,72.680 to 78.750,79.050 to 88.330 

  --(?:km(?:\W+\w+){0,100000}?\W+to(?:\W+\w+){0,100000}?\d+(?:\d+){0,200})
