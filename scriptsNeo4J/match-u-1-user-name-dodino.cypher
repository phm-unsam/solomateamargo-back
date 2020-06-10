MATCH (u1 {userName: "Dodino"})
MATCH (f1 {destinationTo: "Dubai"})
CREATE(u1)-[:Flights {}]->(f1)