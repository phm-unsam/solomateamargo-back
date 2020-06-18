//Vuelos que no tengo pasaje y mis amigos sí con destino a una ciudad de clima frío
MATCH (tini:User {userName: "Tini"})-[:Friend]->(u:User)-[:Flights]->(f:Flight)-[:Destination]->(c:City)
WHERE c.climate = "Frio"
RETURN f