MATCH (u:User)-[fs:Flights]->(f:Flight)
WHERE f.price > 100000
RETURN u