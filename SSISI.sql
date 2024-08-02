

select * from [dbo].[tbl_Preposition]

Declare @String1 varchar(80), @String2 varchar(80)



CASE WHEN @String1 = 'in' THEN '\b(?:'+@String1+'(?:\W+\w+){0,90000}?\s+\'+@String2+')'  







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


select * from [dbo].[tbl_Preposition]


Motor vehicles.#*. Dynamic purchasing system (dps) for the purchase of heavy vehicles for oslo kommune (oslo municipality).

select * from tbl_nounpharse