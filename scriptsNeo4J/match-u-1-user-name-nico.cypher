MATCH (u1 {userName: "Nico"})
MATCH (f1 {destinationTo: "Barcelona"})
CREATE(u1)-[:Flights {}]->(f1)