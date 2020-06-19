MATCH (u1 {userName: "Euge"})
MATCH (f1 {name: "vuelo2"})
CREATE(u1)-[:Flights {}]->(f1)