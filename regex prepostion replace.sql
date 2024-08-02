--insert data1

select DataBrief from NewTendersTest.dbo.tblTenderData where srno = 57881637 

	
	SELECT COUNT(id) Counter FROM data1
SELECT  * FROM data1 WHERE id = @Counter

RCK 10.23

usercertid 

tbl_creefited


191

domainwise 
SELECT * FROM tbl_nounpharse
oslo municipality

--INSERT INTO data1
SELECT tcno,ProductDetails FROM [dbo].[DATAS] where contains(ProductDetails,'near') and tcno in (42061860
,42056229
,42136764)

seelect * from 



TRUNCATE TABLE  tbl_nounpharse

SELECT [dbo].[RegExReplace]('abc_def_1234','\babc(?:\W+\w+){1,2}?\W+def\b','' )

SELECT dbo.RegExIsMatch('\bfor(?:\W+\w+){0,2}?\W+last\b',
           'You have failed me for the last time, Admiral',1)--1
SELECT dbo.RegExIsMatch('\bfor(?:\W+\w+){1,2}?\.\b',
           'You have failed me for what could be the last time, Admiral',1)--0
 
--




SELECT dbo.RegExIsMatch('\bfor(?:\W+\w+){1,2}?\W+last\b',
           'You have failed me for what could be the last time, Admiral',1)--0


SELECT dbo.RegExIsMatch('\bfor(?:\W+\w+){0,2}?\W+last\b',
           'You have failed me for the last time, Admiral',1)--1
SELECT dbo.RegExIsMatch('\bfor(?:\W+\w+){1,2}?\W+last\b',
           'You have failed me for what could be the last time, Admiral',1)--0
 

 SELECT [dbo].[RegExReplace]('Motor vehicles.#*. Dynamic purchasing system (dps) for the purchase of heavy vehicles for oslo kommune (oslo municipality).'
,'\bfor(?:\W+\w+){1,90000}?\.','' )

SELECT * ,[dbo].[RegExReplace](ProductDetails,'\bin(?:\W+\w+){1,90000}?\.||\bfor(?:\W+\w+){1,90000}?\.','' )   FROM [DATA1]
SELECT * ,[dbo].[RegExReplace](ProductDetails,'\bNear(?:\W+\w+){1,90000}?\.','' )   FROM [DATA1]

SELECT * ,[dbo].[RegExReplace](ProductDetails,'^in\s',' ' )   FROM [DATA1]


SELECT * ,[dbo].[RegExMatch](ProductDetails,'^ in [a-zA-Z0-9]{3,20}.(.)$','' )   FROM [DATA1]


SELECT * ,SUBSTRING(ProductDetails,CHARINDEX(' in ',ProductDetails),LEN(ProductDetails)-CHARINDEX('.',ProductDetails))  FROM [DATA1]
SELECT *--- ,REPLACE(ProductDetails,SUBSTRING(ProductDetails,CHARINDEX(' '+CHAR(105)+CHAR(110)+' ',ProductDetails),LEN(ProductDetails)),'')
,SUBSTRING(ProductDetails,CHARINDEX(' '+CHAR(105)+CHAR(110)+' ',ProductDetails),LEN(ProductDetails))  ,
SUBSTRING(ProductDetails,CHARINDEX(CHAR(105)+CHAR(110),ProductDetails),CHARINDEX(CHAR(105)+CHAR(110),ProductDetails))
FROM [DATA1]
Engagement of an agency for data entry/re-entry and printing works in connection with the digitization of land records in 14 revenue circles in barak valley.
Engagement of an agency for data entry/re-entry and printing works    connection with the digitization of land records  14 revenue circles  barak valley.
Motor vehicles.#*. Dynamic purchasing system (dps) for the purchase of heavy vehicles for oslo kommune (oslo municipality).
CHAR(106)+CHAR(110)



select CHAR(105)+CHAR(110)


--UPDATE [DATA1] set texts = ProductDetails 

Declare @String1 varchar(80), @String2 varchar(80), @RegEx Varchar(200)
Select  @String1= ('near'),
           @String2=('.')
Select @RegEx=  
CASE WHEN @String1 = 'in' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 
WHEN @String1 = 'for' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 
WHEN @String1 = 'near' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 
WHEN @String1 = 'at' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\'+@String2+')' 
WHEN @String1 = 'at' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' END
SELECT dbo.RegExMatch(@RegEx,updatetexts,1),ProductDetails,updatetexts
FROM [DATA1]

--SELECT ProductDetails, [dbo].[RegExReplace](ProductDetails,'[(\s+|\#|\:|\*|&|\?|\/)|^0-9]',' ')FROM [DATA1]


SELECT  * FROM 







Declare @String1 varchar(80), @String2 varchar(80), @RegEx Varchar(200)
Select  @String1= ('for'),
           @String2=('.')
Select @RegEx=  
CASE WHEN @String1 = 'in' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 
WHEN @String1 = 'for' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 

WHEN @String1 = 'near' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' 
WHEN @String1 = 'at' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\'+@String2+')' 
WHEN @String1 = 'at' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')' END
SELECT dbo.[RegExReplace](updatetexts,@RegEx,''),ProductDetails,updatetexts
FROM [DATA1]





Select  dbo.[RegExReplace](updatetexts,
CASE WHEN CHARINDEX('in',updatetexts) = 'in' THEN '\b(?:in(?:\W+\w+){0,90000}?\s+\.)' 
WHEN CHARINDEX('for',updatetexts) = 'for' THEN '\b(?:for(?:\W+\w+){0,90000}?\s+\.)' 

WHEN  CHARINDEX('near',updatetexts) = 'near' THEN '\b(?:for(?:\W+\w+){0,90000}?\s+\.)' 
WHEN CHARINDEX('at',updatetexts) = 'at' THEN '\b(?:at(?:\W+\w+){0,90000}?\.)' 
WHEN CHARINDEX('at',updatetexts) = 'at' THEN '\b(?:at(?:\W+\w+){0,90000}?\s+\.)' END
,''),ProductDetails,updatetexts
FROM [DATA1]


SE


SELECT ProductDetails, [dbo].[RegExReplace](ProductDetails,'[(\s+|\#|\:|\*|&|\?|\/)|^0-9]',' ')FROM [DATA1]


SELECt * FROm [DATA1]

--update [DATA1] SET updatetexts = lower([dbo].[RegExReplace](ProductDetails,'[(\s+|\#|\:|\*|&|\?|\/)|^0-9]',' '))

--Motor vehicles.  . Dynamic purchasing system  dps  for the purchase of heavy vehicles for oslo kommune  oslo municipality .

select * from tbl_nounpharse


Engagement of an agency for data entry/re-entry and printing works in connection with the digitization of land records in 14 revenue circles in barak valley.
engagement of an agency for data entry re-entry and printing works in connection with the digitization of land records in    revenue circles in barak valley.