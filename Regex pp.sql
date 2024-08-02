
TRUNCATE TABLE tbl_tendercleanprocess


--STEP 1
INSERT INTO dbo.tbl_tendercleanprocess(Sr_No,tenderdetails)
SELECT tenderprocId,STRING_AGG(LTRIM(RTRIM(Dba.[dbo].[RegExReplace](value,'\s+|_',' '))) + '.',' ') ProductDetails
FROM (SELECT TOP 100 tenderprocId ,tendersBrief FROm [TendersNeo_UAT].apptender.tbl_tenderproduct T
LEFT JOIN NewTendersTest.[dbo].[tblTenderData] D ON T.tenderprocId = D.SrNo 
WHERE D.SrNo IS NULL
) AS   T
--CROSS APPLY string_split(tendersBrief,'.')  AS V  
CROSS APPLY string_split(Dba.[dbo].[RegExReplace](tendersBrief,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\=|^0-9]',' '),'.')  AS V  
 WHERE  value <> '' 
 GROUP BY tenderprocId
--STEP 2
DECLARE @Start int = 1 , @End INT 

SELECT @End =COUNt(1) FROM dba.dbo.tbl_Preposition

WHILE  @Start <= @End
BEGIN

Declare @String1 varchar(80), @String2 varchar(80), @RegEx Varchar(200)

SELECT @String1= Preposition ,@String2 = '.'   FROM dba.dbo.tbl_Preposition Where id = @Start

IF @Start = 1 
BEGIN
UPDATE tbl_tendercleanprocess set cleantext  =   dba.dbo.[RegExReplace](tenderdetails ,'\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')','')

UPDATE tbl_tendercleanprocess set cleantext =  dba.dbo.[RegExReplace](cleantext ,'\b(?:'+@String1+'(?:\W+\w+){0,90000}?\'+@String2+')','') 
END ELSE IF @Start > 1
BEGIN 

UPDATE tbl_tendercleanprocess set cleantext =   dba.dbo.[RegExReplace](cleantext ,'\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')','')

UPDATE tbl_tendercleanprocess set cleantext =  dba.dbo.[RegExReplace](cleantext ,'\b(?:'+@String1+'(?:\W+\w+){0,90000}?\'+@String2+')','') 
END 


SET @Start = @Start + 1
END


INSERT INTo [NewTendersTest].dbo.tbltenderdata (srno,databrief)
select sr_no, cleantext ctext from tbl_tendercleanprocess 


INSERT INTO DATAS (tcno,ProductDetails)
SELECT Top 100  SrNo,DataBrief 
FROM [NewTendersTest].dbo.tbltenderdata 
Where ispharse = 1

UPDATE [NewTendersTest].dbo.tbltenderdata SET ispharse  = 0 
WHERE Sr_No in (SELECT tcno FROm DATAS);


TRUNCATE TABLE DATAS;