MATCH (u:User)-[:Flights]->(f:Flight)
WHERE u.userName = "Gonza"
RETURN f.destinationTo