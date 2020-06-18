MATCH (u1 {userName: "Tini"})
MATCH (f1 {name: "vuelo1"})
CREATE(u1)-[:Flights {}]->(f1)