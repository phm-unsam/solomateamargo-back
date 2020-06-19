MATCH (u1 {userName: "Gonza"})
MATCH (f1 {name: "vuelo4"})
CREATE(u1)-[:Flights {}]->(f1)