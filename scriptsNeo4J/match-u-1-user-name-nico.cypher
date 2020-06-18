MATCH (u1 {userName: "Nico"})
MATCH (f1 {name: "vuelo5"})
CREATE(u1)-[:Flights {}]->(f1)