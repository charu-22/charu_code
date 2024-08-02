--select * from data
declare @loop int =1,@loopno int =1
,@val  nvarchar(1000),@prc varchar(100)
,@instr int,@typ varchar(100)
,@umoloop int ,@unit nvarchar(100),@desc nvarchar(100)



while @loopno <=(select count(1)from [dbo].[vw_commonterms])
 begin



  select  @prc =  procurement , @unit =  typs
  from(select typs,procurement,row_number()over(order by typs)sr
       from [dbo].[vw_commonterms] 
	   )f
  where sr =  @loopno
  -- CASE WHEN  dba.dbo.regexmatch('\b(?:'+procurement+'(?:\W+\w+){0,0}?)',@val,1)  = procurement  THEN 1 END isflag ,


  update  tbl_tendercleanprocess	   set typ = @unit	,isprocess= 1   where  dba.dbo.regexmatch('\b(?:'+@prc+'(?:\W+\w+){0,0}?)',value,1) =  @prc AND isprocess = 0

 
 set @loopno=@loopno+1
 end


 --select * from [dbo].[vw_commonterms]
   

   --select *  from tbl_tendercleanprocess(nolock)  where project <> ''

   --update data set typ = NULL

-- truncate table tbl_tendercleanprocess

WITH CTE AS (
SELECT  Sr_no,id , T.value  FROM tbl_tendercleanprocess R
CROSS APPLY STRING_SPLIT(value,' ') T
WHERE id in (1,4,5) AND T.value <> ''
)
SELECT * FROM CTE 
LEFT JOIN tbl_Preposition P ON CTE.value = P.Preposition

-- AND  contains(R.value,'FORMSOF(Inflectional, repair) OR FORMSOF(Inflectional, resurface) ' )



