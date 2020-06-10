MATCH (tini:User {userName: "Tini"})-[:Friend]->(u:User)
MATCH (u)-[:Flights]->(f:Flight)
WHERE f.climate = "Frio"
RETURN f