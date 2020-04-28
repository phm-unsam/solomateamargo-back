CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vuelos_mas_de_3_pasajes` AS
    SELECT 
        `f`.`id` AS `id`,
        `f`.`destinationFrom` AS `destinationFrom`,
        `f`.`destinationTo` AS `destinationTo`,
        COUNT(`t`.`id`) AS `tickets_amount`
    FROM
        (`tickets` `t`
        JOIN `flights` `f` ON ((`t`.`flight_id` = `f`.`id`)))
    GROUP BY `f`.`id`
    HAVING (`tickets_amount` > 3)
    
    
CREATE DEFINER=`root`@`localhost` PROCEDURE `pasajes_de_primera`(in destination VARCHAR(50))
BEGIN
SELECT f.destinationFrom, f.destinationTo, t.finalCost
FROM tickets t
inner join seats s on t.seat_id = s.id
inner join flights f on t.flight_id = f.id
where s.type = "first" and destinationTo= destination;
END
