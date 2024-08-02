--WITH CTE AS (
--SELECT  Sr_no,id , T.value  FROM tbl_tendercleanprocess R
--CROSS APPLY STRING_SPLIT(value,' ') T
--WHERE id in (1,4,5) AND T.value <> ''
--)
--INSERT INTO [tbl_tendercleanprocessword](sr_no,parentid,words,typid)
--SELECT  Sr_no,cte.id,value,0  FROM CTE 
--LEFT JOIN [dbo].[Prep] P ON CTE.value = P.Preposition
--WHERE P.id is null


select * from [dbo].[procurement]
select * from [tbl_tendercleanprocessword]

select * from tbl_tendercleanprocess

UPDATE  [dbo].[tbl_tendercleanprocessword] set typid = 1  
WHERE contains(words,'FORMSOF(Inflectional, repair) OR FORMSOF(Inflectional, Best book ever on Full-Text Index  ) ' )



SELECT* FROM sys.dm_fts_parser('"Work of area based comprehensive road improvements, strengthening and maintenance |in state highways and major district roads |for a length |of 253.877 km |in various sub divisions |of thanjavur (h) c&m division |including initial rectification works such |as improvements and widening |from intermediate lane to double lane, double lane to multi lane i four lane, improvements |of roads |including Widening of minor bridges and slap culverts, construction of pre cast box culverts, rcc and pcc storm water drain, retaining wall, crash barrier type RCC centre medians, road safety measures to all the roads, plantation |of avenue trees |including |up keeping |for a period |of 60 months."', 3082, 0, 0)
SELECT* FROM sys.dm_fts_parser('The Microsoft business analysis', 1033, 0, 0)

SELECT * FROM sys.dm_fts_parser (' "strengthening and maintenance " ', 1033, 0, 0); 
SELECT * FROM SYS.DM_FTS_PARSER('FORMSOF(FREETEXT, "Best book ever on Full-Text Index")', 1033, 0, 0)

Repairs and Resurfacing of roads 

at dgqa, navy, army, meg areas 


of 253.877 km 
select *
FROM sys.fulltext_catalogs

SELECT * 
FROM sys.fulltext_languages  
ORDER BY lcid
 

 DECLARE @PluralVersion nvarchar(128) = ''
    DECLARE @TableName nvarchar(128) = 'Reparing and construction of road'        
    DECLARE @NounVersions TABLE(Term nvarchar(128) NOT NULL)
    DECLARE @QueryString nvarchar(4000) SET @QueryString = N'FORMSOF(INFLECTIONAL,"' + @TableName + N'")'
    INSERT INTO @NounVersions
    SELECT  display_term FROM sys.dm_fts_parser(@QueryString,1033,0,0)
    SELECT  Term  FROM @NounVersions WHERE Term Not Like '%''%' AND RIGHT(Term,1) = 's'
    SET @PluralVersion = UPPER(LEFT(@PluralVersion,1))+LOWER(SUBSTRING(@PluralVersion,2,LEN(@PluralVersion)))
    SELECT @PluralVersion 

	SELECT display_term FROM SYS.DM_FTS_PARSER('FORMSOF(THESAURUS, café)', 3082, 0, 0)

	select * FROM sys.dm_fts_parser ('"quick,brown"', 1033, 0, 1)


	SELECT* FROM sys.dm_fts_parser('"high level of performance"', 1033, 0, 0)


	FREETEXT(WorkingExperience,'"This is a whole sentence for example."')

	SELECT * FROM sys.dm_fts_parser('FORMSOF(INFLECTIONAL, "This is a whole sentence for example")', 0, (SELECT language_id from sys.fulltext_system_stopwords where  ) , 0);
SELECT * FROM sys.dm_fts_parser('"The Microsoft business analysis"', , 0, 0);




select * from [tbl_tendercleanprocessword]

SELECT  * FROM [dbo].[tbl_tendercleanprocessword] 
CROSS APPLY sys.dm_fts_parser('FORMSOF(INFLECTIONAL, "'+words+'")',3082,0,0)
WHERE typid = 0

select top 2000 id into #temps from tbl_tendercleanprocess(nolock) Where isprocess = 0 and typ  ='Product'


WITH CTE AS (
SELECT   Sr_no,id ,DBA.dbo.RegExReplace(T.value,'\s+',' ')value  FROM tbl_tendercleanprocess R
CROSS APPLY STRING_SPLIT(Dba.[dbo].[RegExReplace](value,'[(\s+|\#|\:|\*|&|\?|\/)|\-|\[|\]|\{|\}|\;|\(|\)|\,|\"|\|\%|\$|\•|\°|\>|\<|\~|\`|\@|\^|\,|\+|\.|\\|\=|^0-9]',' '),' ') T
WHERE  T.value <> '' and R.id in (select id from #temps)
), CTE2 AS (
--INSERT INTO [tbl_tendercleanprocessword](sr_no,parentid,words,typid)
SELECT  Sr_no,cte.id,value FROM CTE 
LEFT JOIN[dbo].[tbl_stopwords] P ON CTE.value = P.word
WHERE P.stopid is null
) , CTE3 AS(

--UPDATE 
--INSERT INTO [tbl_tendercleanprocessword](sr_no,parentid,words,typid,isexist)
SELECT sr_no,c.Id,value , isnull(typeid,0) typeid,CASE WHEN  isnull(typeid,0) = 0 THEN 0 ELSE 1 END  isexist
FROM CTE2 C
INNER JOIN [dbo].[vw_commonterms] P ON P.procurement = C.value 
),  CTE4 AS (
SELECT sr_no,c.Id,value , isnull(typeid,0) typeid,0 isexist
FROM CTE2 C
CROSS APPLY sys.dm_fts_parser('FORMSOF(INFLECTIONAL, "'+value+'")',1033,0,0) B
INNER JOIN [dbo].[vw_commonterms] P ON P.procurement = display_term
GROUP BY  sr_no,c.Id,value , isnull(typeid,0)
)
INSERT INTO [tbl_tendercleanprocessword](sr_no,parentid,words,typid,isexist)
select * from CTE3
union all
select * from CTE4
ORDER BY 2,1



update tbl_tendercleanprocess set isprocess = 1  where id in (select id from #temps)



--UPDATE T SET T.typid = typeid 
--FROM [dbo].[tbl_tendercleanprocessword] T
--CROSS APPLY sys.dm_fts_parser('FORMSOF(INFLECTIONAL, "'+words+'")',1033,0,0) B
--INNER JOIN [dbo].[vw_commonterms] P ON P.procurement = display_term
--WHERE typid = 0





