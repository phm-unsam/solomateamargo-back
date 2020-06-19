//Que ciudades viajo un usuario.
MATCH (u:User)-[:Flights]->(f:Flight)-[:Destination]->(c:City)
WHERE u.userName = "Gonza"
RETURN c.name