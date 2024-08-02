




select *,dbo.regexmatch('\b(?:of(?:\W+\w+){0,100000}?\W+on|(?:\W+\w+){0,100000}?\W+at|Routine(?:\W+\w+){0,100000}?\W+of|of(?:\W+\w+){0,100000}?\W+in|of(?:\W+\w+){0,100000}?\W+as)',tenderdetails,1)  from (
select *,dbo.regexmatch('\b(?:of(?:\W+\w+){0,100000}?\W+on|of(?:\W+\w+){0,100000}?\W+with|Routine(?:\W+\w+){0,100000}?\W+of|of(?:\W+\w+){0,100000}?\W+in|of(?:\W+\w+){0,100000}?\W+as)',tenderdetails,1) 
from (
SELECT sr_no,[Match] tenderdetails FROM  tbl_tendercleanprocess 
CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)
 where sr_no in (37965042,59188494,44374122,44367585,44367703)
) as n 
) as B
--CROSS APPLY [dbo].[RegExSplit]('\b(?:Construction of(?:\W+\w+){0,100000}?\W+on|Construction(?:\W+\w+){0,100000}?\W+at|Routine(?:\W+\w+){0,100000}?\W+of|Work of(?:\W+\w+){0,100000}?\W+in|divisions of(?:\W+\w+){0,100000}?\W+as)',tenderdetails,1)

Select @RegEx=
'\b(?:'+@String1+'(?:\W+\w+){0,4}?\W+'+@String2+'|'+@String2+'(?:\W+\w+){0,4}?\W'+@String1+')\b'
SELECT dbo.RegExMatch(@RegEx,'A RegEx expression can often be wrong but it is usually possible to put it right.',1)
--split a string into words
SELECT * FROM dbo.RegExSplit('\W+','this is an exciting  regular   expression',1)


Work of area based comprehensive road improvements, strengthening and maintenance 
in state highways and major district roads for a length of 253.877 km in various sub divisions of thanjavur
(h) c&m division including initial rectification works such as improvements and widening 
from intermediate lane to double lane, double lane to multi lane i four lane, improvements of roads including widening of minor bridges and slap culverts, construction of pre cast box culverts, rcc and pcc storm water drain, retaining wall, crash barrier type RCC centre medians, road safety measures to all the roads, plantation of avenue trees including up keeping for a period of 60 months.

DRop table Cleantext

SELECT sr_no,[Match] tenderdetails,
Dba.[dbo].[RegExReplace]([Match],'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\=|^0-9]',' ')
cleantext -- into Cleantext
FROM  tbl_tendercleanprocess 
CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)
WHERE Sr_no In (44311300,44186409)


select * from [dbo].[tbl_tendercleanprocess]

