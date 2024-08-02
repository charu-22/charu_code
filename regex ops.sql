


select      dba.dbo.[RegExReplace](tenderdetails union all'\b(?:'+@String1+'(?:\W+\w+){0union all90000}?\s+\'+@String2+')'union all'')union all @String1 
From tbl_tendercleanprocess 
observatory towers and viewing galleries including approaches decorative lighting parking

select  dbo.[RegExReplace](tenderdetails,' aboard | about | above | across | after | against | along | amid | among | around | as | at | before | behind | below | beneath | beside | between | beyond | but | by | close to | concerning | considering | despite | down | during | except | following | for | from | in | in front of | inside | into | like | minus | near | next | next to | of | off | On | onto | opposite | out | out of | outside | over | past | per | plus | regarding | round | save | since | than | through | to | toward | towards | under | underneath | unlike | until | up | upon | versus | via | with | within | without '
,' @ ') from tbl_tendercleanprocess

Declare @String1 nvarchar(max);
select @String1 = STRING_AGG(' '+Preposition+' ','|') from  tbl_Preposition
select *  from tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit](@String1,tenderdetails,1) T

 
select * from tbl_nounpharsenew 

select * from tbl_stopwords



select  * ,CASE WHEN  dbo.RegExMatch('\b(?:of(?:\W+\w+){0,100}?\W+)\b'  , tenderdetails,1) = 'of' THEN 'of '
WHEN  dbo.RegExMatch('\b(?:including(?:\W+\w+){0,100}?\W+)\b'  , tenderdetails,1) = 'including' THEN 'including ' END
from (
select * from tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit](@String1,tenderdetails,1) T
) as n

select * into #temp from tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit](@String1,tenderdetails,1) T

DROP TABLE #temp

Declare @String1 nvarchar(max);
select  STRING_AGG(' '+Preposition+' ','|') from  tbl_Preposition

--;WITH    Preposition AS (
select ROW_NUMBER()OVER(Partition by sr_no Order by Id ) RN,Sr_no,tenderdetails,Match   from tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit](@String1,tenderdetails,1) T
WHERE sr_no in (44186409,44214421,44355652,44367007)


)
, ofbk as (
select * from  ofbk
)
SELECT * FROM ofbk


select * from tbl_tendercleanprocess


select dbo.RegExMatch('\b(?:(?:\W+\w+){2,3}\W+?to(?:\W+\w+){2,3}?\W+)\b','Renewal and general repair work of service road of bhimpur dy. from km. 5.730 to km. 11.600',1)

select dbo.RegExMatch('((\d+[0-9.0-9]))','Renewal and general repair work of service road of bhimpur dy. from km. 756.730 to km. 11.600',1)


select dbo.RegExMatch('\d[^a-z0-9.]','Renewal and general repair work of service road of bhimpur dy. from km. 756.730 to km. 11.600',1)


select  STRING_AGG(CONCAT('REPLACE(',''),''),  
STRING_AGG(CASE WHEN id = 1 THEN  CONCAT('(@cols,' ,CHAR(39)+space(1)+Preposition+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+Preposition+space(1)+CHAR(39),')') 
WHEN id >  1 THEN  CONCAT(',' ,CHAR(39)+space(1)+Preposition+space(1)+CHAR(39),',' ,CHAR(39)+space(1)+'|'+Preposition+space(1)+CHAR(39),')') END,' ')
from  tbl_Preposition


select * from   tbl_Preposition


select  *,CASE WHEN dbo.regexmatch('\b(?:in(?:\W+\w+){0,0}?)',value,1) = 'in' THEN 'Location'
 WHEN dbo.regexmatch('\b(?:of(?:\W+\w+){0,0}?)',value,1) = 'of' THEN 'product'
  WHEN dbo.regexmatch('\b(?:over(?:\W+\w+){0,0}?)',value,1) = 'over' THEN 'Location'
  WHEN dbo.regexmatch('\b(?:as(?:\W+\w+){0,0}?)',value,1) = 'as' THEN 'Location'
    WHEN dbo.regexmatch('\b(?:near(?:\W+\w+){0,0}?)',value,1) = 'near' THEN 'Location'
 ENd
from (
select * from (
SELECT Sr_no , 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
tenderdetails,' aboard ',' |aboard '),' of ',' |of '),' on ',' |on ') ,' from ',' |from '),' about ',' |about ') ,' above ',' |above ') ,' across ',' |across ') ,' after ',' |after ') ,' against ',' |against ') ,' along ',' |along ') ,' amid ',' |amid ') ,' among ',' |among ') ,' around ',' |around ') ,' as ',' |as ') ,' at ',' |at ') ,' before ',' |before ') ,' behind ',' |behind ') ,' below ',' |below ') ,' beneath ',' |beneath ') ,' beside ',' |beside ') ,' between ',' |between ') ,' beyond ',' |beyond ') ,' but ',' |but ') ,' by ',' |by ') ,' close to ',' |close to ') ,' concerning ',' |concerning ') ,' considering ',' |considering ') ,' despite ',' |despite ') ,' down ',' |down ') ,' during ',' |during ') ,' except ',' |except ') ,' following ',' |following ') ,' in ',' |in ') ,' in front of ',' |in front of ') ,' inside ',' |inside ') ,' into ',' |into ') ,' like ',' |like ') ,' minus ',' |minus ') ,' near ',' |near ') ,' next ',' |next ') ,' next to ',' |next to ') ,' off ',' |off ') ,' onto ',' |onto ') ,' opposite ',' |opposite ') ,' out ',' |out ') ,' out of ',' |out of ') ,' outside ',' |outside ') ,' over ',' |over ') ,' past ',' |past ') ,' per ',' |per ') ,' plus ',' |plus ') ,' regarding ',' |regarding ') ,' round ',' |round ') ,' save ',' |save ') ,' since ',' |since ') ,' than ',' |than ') ,' through ',' |through ') ,' toward ',' |toward ') ,' towards ',' |towards ') ,' under ',' |under ') ,' underneath ',' |underneath ') ,' unlike ',' |unlike ') ,' until ',' |until ') ,' up ',' |up ') ,' upon ',' |upon ') ,' versus ',' |versus ') ,' via ',' |via ') ,' with ',' |with ') ,' within ',' |within ') ,' without ',' |without ') ,' including ',' |including ')
Txt
from tbl_tendercleanprocess
WHERE sr_no in (58561195)
) as N 
CROSS APPLY string_split(Txt,'|') T
) as N
 44412340
44416072
Construction |of 6-lane Greenfield Varanasi Ranchi Kolkata Highway |from Donoreshan village to junction |with NH20
|in Bongabar village |from km 288.600 to km 325.500
|under Bharatmala Pariyojana |in the State |of Jharkhand |on Hybrid Annuity Mode (PKG11)

 Construction |of C.C. Road |from Main Road to |towards Hansraj house |through Gokul gurjar, Main Road to 
 |towards Vicky Yadav and Manmohan singh to |towards Gurjar |at ward No. 19.

Work |of area based comprehensive road improvements, strengthening and maintenance
|in state highways and major district roads for a length |of 253.877 km |in various sub divisions
|of thanjavur (h) c&m division |including initial rectification works such |as improvements and widening 
|from intermediate lane to double lane, double lane to multi lane i four lane, improvements |of roads |including widening
|of minor bridges and slap culverts, construction |of pre cast box culverts, rcc and pcc storm water drain, retaining wall, 
crash barrier type RCC centre medians, road safety measures to all the roads, 
plantation |of avenue trees |including |up keeping for a period |of 60 months.



Upgradation |of existing 2lane carriageway to 4lane divided carriageway |from ch.179.780 (existing km.506.660) 
|in bitada or movi |in netrang taluka to ch.208.900 (existing km. 535.930) 
|in nasarpore |in umarpada taluka sec |of nh56 |in gujarat |on ham pkg-5
-- 44186409,55765288,


-- Work of area based comprehensive road improvements, strengthening and maintenance |in state highways and major district roads for a length of 253.877 km
-- |in various sub divisions of thanjavur (h) c&m division |including initial rectification works such |as improvements and widening from intermediate lane to double lane, double lane to multi lane i four lane, improvements of roads |including widening of minor bridges and slap culverts, construction of pre cast box culverts, rcc and pcc storm water drain, retaining wall, crash barrier type RCC centre medians, road safety measures 
-- to all the roads, plantation of avenue trees |including |up keeping for a period of 60 months.


-- select * from tbl_tendercleanprocess where tenderdetails like '%lane%'

--select * from  tbl_nounpharse where nounpharse like '%gold medal%'  where tcno = 57387751

--select * from  tbl_nounpharsenew where nounpharse like '%gold%' where tcno = 57267987

--select * from tbl_noun where noun like '%gold%'

--truncate table tbl_nounpharsenew

--select * from  tbl_nounpharse

--update tbl_nounpharse set isflag = 0