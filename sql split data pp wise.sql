--CREATE     PROC  Splitprepositiontender
--As
--BEGIn 

DROP TABLE tempsr
select top 5000 sr_no into tempsr from DataCleanProcess.[dbo].[temps25022023] where isprocess = 0


DECLARE @Replace NVARCHAR(MAX), @preposition NVARCHAR(MAX) , @types NVARCHAR(MAX) ;




SELECT @Replace = STRING_AGG(Rep,''),@preposition = STRING_AGG(Prepro,''), @types = STRING_AGG(Typ,'') FROM (
select  
CONCAT('REPLACE(','')  Rep
, 

CASE WHEN id = 1 THEN  CONCAT('@cols,' ,CHAR(39)+space(1)+Preposition+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+Preposition+space(1)+CHAR(39),')') 
WHEN id >  1 THEN  CONCAT(',' ,CHAR(39)+space(1)+Preposition+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+Preposition+space(1)+CHAR(39),')') END
Prepro
,
CASE WHEN id = 1 THEN 
CONCAT('CASE WHEN dbo.regexmatch(',CHAR(39)+'\b(?:',Preposition,'(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+Preposition+CHAr(39),' THEN ',CHAr(39)+'Location'+CHAr(39))
WHEN id >  1 
THEN CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:',Preposition,'(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+Preposition+CHAr(39),' THEN ',CHAr(39)+'Location'+CHAr(39)) END
Typ
--,' ')
from  [DataCleanProcess].dbo.tbl_Preposition
UNION ALL
SELECT  CONCAT('REPLACE(',''),  CONCAT(',' ,CHAR(39)+space(1)+'of'+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+'of'+space(1)+CHAR(39),')') , CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:of(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+'of'+CHAr(39),' THEN ',CHAr(39)+'Product'+CHAr(39))
UNION ALL
SELECT  CONCAT('REPLACE(',''),CONCAT(',' ,CHAR(39)+space(1)+'from'+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+'from'+space(1)+CHAR(39),')') , CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:from(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+'from'+CHAr(39),' THEN ',CHAr(39)+'Distance'+CHAr(39))
UNION ALL
SELECT  CONCAT('REPLACE(',''),CONCAT(',' ,CHAR(39)+space(1)+'On'+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+'On'+space(1)+CHAR(39),')') , CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:On(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+'on'+CHAr(39),' THEN ',CHAr(39)+'Package'+CHAr(39))
UNION ALL
SELECT  CONCAT('REPLACE(',''),CONCAT(',' ,CHAR(39)+space(1)+'for'+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+'for'+space(1)+CHAR(39),')') , CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:for(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+'for'+CHAr(39),' THEN ',CHAr(39)+'Department'+CHAr(39))
) AS N


DECLARE @maxid int = (SELECT MAX(id) FROM  [DataCleanProcess].dbo.procurement)

select @Replace = @Replace+ STRING_AGG(T,' ' ),
@preposition= @preposition+STRING_AGG(procurement,' '),
@types = @types+STRING_AGG(tyep,' ')
FROM (
select CONCAT('REPLACE(',' ') T, 
CONCAT(',' ,CHAR(39)+procurement+' |of'+CHAR(39),',' ,CHAR(39)+procurement+' of'+CHAR(39),')') procurement
,CONVERT(VARCHAR(MAX),CASE WHEN 
id=  (SELECT MAX(id) FROM  [DataCleanProcess].dbo.procurement )
THEN 
CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:'+procurement+space(1)+ 'of(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+procurement+space(1)+ 'of'+CHAr(39),' THEN ',CHAr(39)+'Product'+CHAr(39),' END')
ELSE 
CONCAT('WHEN dbo.regexmatch(',CHAR(39)+'\b(?:'+procurement+space(1)+ 'of(?:\W+\w+){0,0}?)'+CHAR(39),',value,1) = ',CHAr(39)+procurement+space(1)+ 'of'+CHAr(39),' THEN ',CHAr(39)+'Product'+CHAr(39)) END
) tyep 
from [DataCleanProcess].dbo.procurement
) as n 


SET @preposition = REPLACE(@preposition,'@cols','tenderdetails')

DECLARE @SQL NVARCHAR(MAX)
--INSERT INTO [DataCleanProcess].dbo.tbl_tendercleanprocess(sr_no,txt,value,typ)
SET @SQL = N'
 INSERT INTO [DataCleanProcess].dbo.tbl_tendercleanprocess(sr_no,txt,value,typ)
select  Sr_No,txt,value value1  ,'+@types+' typ 
from (
select * from (
SELECT Sr_no , 
'+@Replace+''+@preposition+'
Txt
From (
select  T.sr_no,[Match] tenderdetails from DataCleanProcess.[dbo].[temps25022023] T
CROSS APPLY [dbo].[RegExSplit](''(?<=[.!?][''''"\s])\s*(?=[A-Z])'',REPLACE(REPLACE(T.productdetails,'' <br />'',''''),''#*'',''''),1) as n
WHERE t.sr_no in (select sr_no from tempsr)
) as B

) as N 
CROSS APPLY string_split(Txt,''|'') T
) as N
'
exec sp_executesql  @SQL

UPDATE DataCleanProcess.[dbo].[temps25022023] SET isprocess = 0 WHERE sr_no in (SELECT sr_no FROM tempsr)



