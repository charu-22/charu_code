select * from (
select Top 1000  *,dba.dbo.RegExEscape(tenderdetails) a from tbl_tendercleanprocess
) as N CROSS APPLY dba.dbo.RegExSplit('[\\]',a,1)


;WITH CTE AS (
select Sr_no, tenderdetails,match text,
dba.dbo.RegExEscape(Dba.[dbo].[RegExReplace](Dba.[dbo].[RegExReplace](Match,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]',' '),'\s+|_',' '))
Clean
FROM
tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)

) , CTE2 AS (
SELECT Sr_no,rtrim(ltrim(Match)) Match FROM CTE
N CROSS APPLY dba.dbo.RegExSplit('[\\]',Clean,1)
WHERE Match <> ''
) 
SELECT sr_no, ROW_NUMBER()OVER(partition by sr_no order by sr_no) positionid , Match  into tblCleantextdetail
FROM CTE2 C 

select * from tblCleantextmaster
select * from tblCleantextdetail
