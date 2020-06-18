//Qué vuelos aún no tomé
MATCH (gonza:User {userName: "Gonza"})
MATCH (f:Flight)
WHERE NOT exists((gonza)-[:Flights]->(f)) AND date() < f.departure
RETURN f