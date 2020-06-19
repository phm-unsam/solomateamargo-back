//Pasaje de más de $100.000
MATCH (u:User)-[fs:Flights]->(f:Flight)
WHERE f.price > 100000
RETURN u