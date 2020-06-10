MATCH (gonza:User {userName: "Gonza"})
MATCH (f:Flight)
WHERE exists((gonza)-[:Flights]->(f)) 
MATCH ((u:User)-[:Flights]->(f))
WHERE u.userName <> "Gonza"
RETURN u