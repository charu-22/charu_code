select *,  ROW_NUMBER()OVER(Partition by sr_no Order by sr_no,positionid ) RNk

from tblCleantextdetail C
left  join [NewTendersTest].dbo.tblTenderPrepositionList  P On C.match = p.Preposition COLLATE Latin1_General_CI_AI
WHERE  sr_no in ( 37965042,43574812,44017009)

select  * from tblCleantextmaster
 WHERE  sr_no in ( 37965042,43574812,44017009)

 Expression of interest seamless integration of establishments with kochi metro stations - encompassing introduction of feeder bus services, development of mobility facilities such as bus bays, pedestrian crossings, walkways, way-finding, signage etc., for ingress to and egress from the metro stations and also to business/commercial/institutional establishments which are proximate to metro stations, thereby facilitating ease of use of the metro rail system.

 Expression of interest seamless integration of establishments with kochi metro stations - encompassing introduction of feeder bus services, development of mobility facilities such as bus bays, pedestrian crossings, walkways, way-finding, signage etc., for ingress to and egress from the metro stations and also to business/commercial/institutional establishments which are proximate to metro stations, thereby facilitating ease of use of the metro rail system.