--select k.* into tbl_tenderkeywordBk  from [apptender].[tbl_tenderkeyword] K
--LEFT JOIN [apptender].[tbl_tender]  T On K.tcno   = T.tcno
--WHERE  T.tcno IS NULL 

--select k.* into tbl_tenderdocsbk  from [apptender].[tbl_tenderdocs] K
--LEFT JOIN [apptender].[tbl_tender]  T On K.tcno   = T.tcno
--WHERE  T.tcno IS NULL 
--select DISTINcT  K.tcno  from [apptender].[tbl_tenderCorrigendum] k
--LEFT JOIN [apptender].[tbl_tender]  T On K.tcno   = T.tcno
--WHERE  T.tcno IS NULL 

select ERROR_STATE ( )  


DELETE  from tbl_Preposition where Preposition in ('to'
,'from'
,'on'
,'for' 
)


select *  from tbl_Preposition


DECLARE @source geography = 'POINT(756.730)'
DECLARE @target geography = 'POINT(11.600)'

SELECT @source.STDistance(@target)


DECLARE
@GEO1 GEOGRAPHY,
@LAT VARCHAR(10),
@LONG VARCHAR(10)

SET @LAT='756.730'
SET @LONG='11.600'


SET @geo1= geography::Point(@LAT, @LONG, 4326)

SELECT (@geo1.STDistance(geography::Point(ISNULL(LAT,0), _
ISNULL(LONG,0), 4326))) as DISTANCE  


Declare @String1 nvarchar(max);
select @String1 =  STRING_AGG(' '+Preposition+' ','|') from  tbl_Preposition

--truncate table 
--insert into tbl_Preposition(Preposition)
--select * from #temp where Preposition in ('to', 'from', 'on',  'for','of' )

select ROW_NUMBER()OVER(Partition by sr_no Order by Id ) RN,Sr_no,tenderdetails,Match   from tbl_tendercleanprocess
CROSS APPLY [dbo].[RegExSplit](@String1,tenderdetails,1) T
WHERE sr_no in (44186409,44214421,44355652,44367007)


SELECT *,

CASE
  WHEN id = 1 
     THEN  'With '+Preposition+ ' AS ( select ROW_NUMBER()OVER(Partition by sr_no Order by Id ) RN,Sr_no,tenderdetails,Match,''Location'' Typed   from tbl_tendercleanprocess
          CROSS APPLY [dbo].[RegExSplit]('+CHAR(39)+SPACE(1)+Preposition+SPACE(1)+CHAR(39)+ ',tenderdetails,1) T WHERE sr_no in (44186409,44214421,44355652,44367007)),'  
  WHEN id > 1 
     THEN  CONCAT('[',Preposition,'] as ( SELECT   ROW_NUMBER()OVER(Partition by sr_no Order by RN ) RN ,sr_no , [',lag(Preposition) over(order by id)+'].tenderdetails, '
	 ,' T.match ,', CHAr(39)+'Location'+CHAr(39)  ,' Typed FROM [',lag(Preposition) over(order by id),']
           CROSS APPLY [dbo].[RegExSplit](',+CHAR(39)+SPACE(1),Preposition+SPACE(1)+CHAR(39),',[',lag(Preposition) over(order by id),'].match,1) T
     ),') END 
FROM tbl_Preposition 
