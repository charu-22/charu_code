TRUNCATE tABLE tempword


WITH CTE AS (
SELECT sr_no,id,typeid,pharse, REPLACE(REPLACE(REPLACE(LTRIM(RTRIm(Match)),',',''),')',''),'(','') words FROM (
SELECT sr_no,id,typeid, value pharse, dba.dbo.RegExEscape( Replace(value,'/',' ')) Clean  FROM tbl_tendercleanprocess  WHERE Typeid = 1
)AS b
CROSS APPLY dba.dbo.RegExSplit('[\\]',Clean,1)
WHERE Match <> ''
)
INSERT INTO tempword (sr_no,Id,typeid,pharse)
SELECT sr_no,id,typeid, value pharse  FROM tbl_tendercleanprocess  WHERE Typeid = 1
SELECT sr_no,cte.id,typeid,pharse    FROM CTE
LEFT JOIN [dbo].[Prep] T ON T.Preposition = CTE.words
WHERE T.id IS NULL AND words NOT IN ('.')



INSERT INTO [dbo].[tbl_tendercleanprocessword](sr_no,parentId,pharse,words,typid)
SELECT sr_no,cte2.Id,pharse,words,typeid FROM tempword CTE2
LEFT JOIN product P On P.product = CTE2.words
WHERE p.id is not null
order by  CTE2.id




INSERT INTO [dbo].[tbl_tendercleanprocessword](sr_no,parentId,pharse,words,typid)
SELECT sr_no,cte2.Id,pharse,words,2 FROM tempword CTE2
--LEFT JOIN product P On P.product = CTE2.words
LEFT JOIN procurement PR On PR.procurement = words
WHERE pR.id is not null
order by  CTE2.id


select *   from [tbl_tendercleanprocessword]

SELECT sr_no,cte2.Id,pharse,words,typeid,
(SELECT product FROM product  WHERE contains(words,
'formsof (inflectional, '+product+')')


z
)  FROM tempword CTE2
--LEFT JOIN product P On P.product = CTE2.words
--WHERE p.id is not null
order by  CTE2.id

SELECT product FROM product  WHERE contains(description, ' formsof (inflectional, great) ')

SELECT * FROM content WHERE contains(description, ' formsof (inflectional, great) ')

SELECT * FROM tempword  WHERE contains(words,' formsof (inflectional, road) ')
order by  id
--update  tbl_tendercleanprocess  set tbl_tendercleanprocess.rowid = t.rn

--FROM (SELECT Id , Row_number()over(order by id) rN FROM tbl_tendercleanprocess WHERE typeid = 1) as T
--Where tbl_tendercleanprocess.id = t.id



;WITH CTE AS (
select Sr_no, tenderdetails,match text,
dba.dbo.RegExEscape(Dba.[dbo].[RegExReplace](Dba.[dbo].[RegExReplace](Match,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]',' '),'\s+|_',' '))
Clean
FROM
tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit]('(?<=[.!?][''''"\s])\s*(?=[A-Z])',REPLACE(REPLACE(tenderdetails,' <br />',''),'#*',''),1)
WHERE Typeid = 1

) , CTE2 AS (
SELECT Sr_no,rtrim(ltrim(Match)) Match FROM CTE
N CROSS APPLY dba.dbo.RegExSplit('[\\]',Clean,1)
WHERE Match <> ''
) 
SELECT sr_no, ROW_NUMBER()OVER(partition by sr_no order by sr_no) positionid , Match  into tblCleantextdetail
FROM CTE2 C 



DECLARE @sql nvarchar(max);

SET @sql = 'SELECT sr_no,cte2.Id,pharse,words,typeid,
(SELECT product FROM product  WHERE contains(words,
''formsof (inflectional, product)''))
  FROM tempword CTE2'

  SELECt @sql

  SELECT sr_no,cte2.Id,pharse,words,typeid,
(SELECT product FROM product  WHERE contains(words,'formsof (inflectional, road)'))
  FROM tempword CTE2

  SELECT sr_no,cte2.Id,pharse,words,typeid FROM tempword CTE2
, product P 



DECLARE @startid int =  1 , @end int , @product varchar(500), @typs int, @product1 nvarchar(500);


select @end = COUNt (1) from [vw_master] 
WHILE  @startid <=@end
BEGIn
select @product=  keys, @typs = typs from [vw_master] WHERE id =  @startid

SET @product1 = @product

SET @product  = CONCAT('formsof (inflectional,',@product ,')')

INSERT INTO [dbo].[tbl_tendercleanprocessword](sr_no,parentId,pharse,words,typid)
 SELECT distinct  sr_no,Id,pharse,@product1,@typs FROM tempword WHERE FREETEXT(pharse,@product )

 SET @startid = @startid+ 1
END 



select * from [vw_master]


DECLARE @startid int =  1 , @end int , @pharse varchar(500), @typs int,@parent int, @product nvarchar(500),@sr_no  nvarchar(500);


SELECT   @end =  COUNt(1) FROM tempword


WHILE  @startid <=@end
BEGIn

SELECT @pharse = pharse ,@sr_no = Sr_no, @parent = id   FROM tempword WHERE Rowid = @startid

--select @product=  keys, @typs = typs from [vw_master] WHERE id =  @startid
SET @pharse  = CONCAT('formsof (inflectional,',@pharse ,')')


SELECT 1 typs, procurement keys FROM procurement WHERE FREETEXT(procurement,@pharse )
UNION ALL
SELECT 2 typs, product FROM       [dbo].product  WHERE FREETEXT(product,@pharse )
UNION ALL 
SELECT 3 typs, keyname FROM tbl_keyword WHERE FREETEXT(keyname,@pharse )
UNION ALL
SELECT 4 typs, synname  from  tbl_synonym WHERE FREETEXT(synname,@pharse )



--SET @product1 = @product

--SET @product  = CONCAT('formsof (inflectional,',@product ,')')

--INSERT INTO [dbo].[tbl_tendercleanprocessword](sr_no,parentId,pharse,words,typid)
-- SELECT distinct  sr_no,Id,pharse,@product1,@typs FROM tempword WHERE FREETEXT(pharse,@product )

 SET @startid = @startid+ 1
END 


select @end = COUNt (1) from [vw_master] 


select * from tbl_tendercleanprocess