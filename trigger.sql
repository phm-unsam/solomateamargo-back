CREATE TABLE flights_change_audit(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_flight LONG NOT NULL,
    modify_date datetime NOT NULL,
    old_destination VARCHAR(255) NOT NULL,
    new_destination VARCHAR(255) NOT NULL
);

CREATE TRIGGER flight_change_log
	AFTER UPDATE
	ON aterrizapp.flights FOR EACH ROW

INSERT INTO flights_change_audit
SET modify_date = NOW(),
	id_flight = OLD.id,
	old_destination = OLD.destinationFrom,
	new_destination = NEW.destinationFrom;