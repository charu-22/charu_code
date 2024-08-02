sp_wia


select distinct  sr_no from  tbl_tendercleanprocess where Sr_no = 5255297


5056415
select * from  tbl_tendercleanprocessword where Sr_no = 5255297

DROP TABLE #temp



select  tdp.sr_no,value,TT.id,calcDistance,pos
,dba.dbo.Regexmatch('\b(?:NH(?:\D+\d+){0,100000}?\W+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH-(?:\D+\d+){0,100000}?\W+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\W+\s+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\d+)'
,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'NH.','NH'),'N.H','NH'),'N.H.','NH'),'NH-','NH'),'NH -','NH'),'NH – ','NH'),'NH ','NH '),1) NHR  INTO #temp

from tbl_tendercleanprocess tdp 
INNER JOIN tbl_tendercleanprocessword TT ON TT.sr_no = tdp.Sr_no AND TT.parentid = tdp.id AND typid = 6 and words like '%nh%' 




   
 UPDATE #temp SET NHR =
dba.dbo.Regexmatch('\b(?:NH(?:\D+\d+){0,100000}?\W+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\W+\s+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\d+)'
,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'NH.','NH'),'N.H','NH'),'N.H.','NH'),'NH-','NH'),'NH -','NH'),'NH – ','NH'),'NH ','NH'),1) 
 where nhr =  ''

 
UPDATE  #temp SET NHR = T   from (

SELECT *  
,
dba.dbo.Regexmatch('\b(?:NH(?:\D+\d+){0,100000}?\w+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z]\s+)'
,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'NH.','NH'),'N.H','NH'),'N.H.','NH'),'NH-','NH'),'NH -','NH'),'NH – ','NH'),'NH ','NH'),'(NEW','#'),1)  t
FROM    #temp 
where nhr <>  '' --and sr_no = 7995299
) as n Where T <> '' AND n.id = #temp.id



SELECT * FROM #temp 

--  select * from tbl_tendercleanprocess
  
--  DROP TABLE #tempNH
SELECT * INTO #tempNH

--dba.dbo.Regexmatch('\b(?:NH(?:\D+\d+){0,100000}?\W+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\W+\s+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z])|(?:NH(?:\D+\d+){0,100000}?\d+)'
--,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'NH.','NH'),'N.H','NH'),'N.H.','NH'),'NH-','NH'),'NH -','NH'),'NH – ','NH'),'NH ','NH'),1) 
FROM    #temp 
CROSS APPLY DBA.dbo.RegExSplit('[)|(|.|,|To| ]',(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(NHR,'(NEW','#'),'(OLD','@'),'# ','#'),'@ ','@'),' #','#'),' @','@'),'No.',''),'-',''),'- ',''),'NH ','NH'),'NH ','NH'),'NH','NH-')),1)
where nhr <>  '' AND Match <> '' and sr_no = 7995299

--UPDATE tbl_tendercleanprocessword  SET tbl_tendercleanprocessword.id = 
--FROM #tempNH  --WHERE Sr_no = 12209001
--WHERE
--LTRIM(RTRIm(MATCH))  LIKE 'NH%'

BEGIN TRAN
UPDATE tbl_tendercleanprocessword SET words = VAL

FROM (
select id, STRING_AGG(MATCH,',') VAL
FROM #tempNH  --WHERE Sr_no = 12209001
WHERE
LTRIM(RTRIm(MATCH))  LIKE 'NH%'
GROUP BY id
) AS N WHERE tbl_tendercleanprocessword.id = N.id

Commit



select words , VAL,*


FROM tbl_tendercleanprocessword, (
select id, STRING_AGG(MATCH,',') VAL
FROM #tempNH  --WHERE Sr_no = 12209001
WHERE
LTRIM(RTRIm(MATCH))  LIKE 'NH%'
GROUP BY id
) AS N WHERE tbl_tendercleanprocessword.id = N.id
select tbl_tendercleanprocessword.id  into #id
    FROM tbl_tendercleanprocessword ,

 (
select id, STRING_AGG(MATCH,',') VAL
FROM #tempNH  --WHERE Sr_no = 12209001
WHERE
LTRIM(RTRIm(MATCH))  LIKE 'NH%'
GROUP BY id
) AS N WHERE tbl_tendercleanprocessword.id = N.id


--UPDATE [tbl_tendercleanprocessword] SET [tbl_tendercleanprocessword].words = T.words

--FROM [CleanProcess].dbo.[tbl_tendercleanprocessword] T WHERE T.id in (select * from #id)
--AND tbl_tendercleanprocessword.id = T.id

NH- 8A (47) B
NH- 8A (47) B
--UPDATE  #temp SET NHR = T   from (

--SELECT *  
--,
--dba.dbo.Regexmatch('\b(?:NH(?:\D+\d+){0,100000}?\w+\d+[B|A|C|D|E|F|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z]\s+)'
--,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(value,'NH.','NH'),'N.H','NH'),'N.H.','NH'),'NH-','NH'),'NH -','NH'),'NH – ','NH'),'NH ','NH'),'(NEW','#'),1)  t
--FROM    #temp 
--where nhr <>  '' --and sr_no = 7995299
--) as n Where T <> '' AND n.id = #temp.id
