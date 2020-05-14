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