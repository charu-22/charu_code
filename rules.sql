select * from tblCleantextmaster where sr_no in (37965042,59188494,44374122,44367585,44367703)


select * from tblCleantextdetail  where sr_no in (37965042,59188494,44374122,44367585,44367703)


select * from tblCleantextdetail  where  prepositionrow in (1,2) and match = 'of'


select * from [dbo].[ParsingRuleMatrix]


Expression of interest seamless integration of establishments with kochi metro stations -
encompassing introduction of feeder bus services, development of mobility facilities such as bus bays,
pedestrian crossings, walkways, way-finding, signage etc., for ingress to and egress from the metro stations and also to business/commercial/institutional establishments 
which are proximate to metro stations, thereby facilitating ease of use of the metro rail system.

select *,  CASE WHEN  Match BETWEEN 'of' and 'with' and ispreposition in (1,0)   THEN MATCH END  from tblCleantextdetail  


select * from [dbo].[ParsingRuleMatrix] WHERE [First propostion] <> 'of'



INSERT INTo RuleMatrix
SELECT 'of' firstrule, Preposition secondrule  FROM [dbo].[tbl_Preposition] WHERE Preposition NOT IN (
'over'
,
'with'
,'OF'
,'By way of'
,'on'
,'to'
,'with'
,'under'
)


select * from RuleMatrix

TRUNCATE TABLE  RuleMatrix


('over'
,'with'
,'OF'
,'By way of'
,'on'
,'to'
,'with'
,'under')