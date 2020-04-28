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

CREATE TABLE flights_change_audit(
	id INT AUTO_INCREMENT PRIMARY KEY,
    modify_date datetime NOT NULL,
    old_destination VARCHAR(255) NOT NULL,
    new_destination VARCHAR(255) NOT NULL
);



CREATE TRIGGER flight_change_log
	AFTER UPDATE
	ON aterrizapp.flights FOR EACH ROW

INSERT INTO flights_change_audit
SET modify_date = NOW(),
	old_destination = OLD.destinationFrom,
	new_destination = NEW.destinationFrom;


ALTER TABLE `aterrizapp`.`users` 
CHANGE COLUMN `cash` `cash` DOUBLE NOT NULL;