MATCH (u1 {userName: "Euge"})
MATCH (f1 {destinationTo: "Suiza"})
CREATE(u1)-[:Flights {}]->(f1)