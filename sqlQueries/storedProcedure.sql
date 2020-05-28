CREATE DEFINER=`root`@`localhost` PROCEDURE `pasajes_de_primera`(in destination VARCHAR(50))
BEGIN
	SELECT f.destinationFrom, f.destinationTo, t.finalCost
	FROM tickets t
	inner join seats s on t.seat_id = s.id
	inner join flights f on t.flight_id = f.id
	where s.type = "first" and destinationTo= destination;
END
