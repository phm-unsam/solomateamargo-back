MATCH (u1 {userName: "Gonza"})
MATCH (f1 {destinationTo: "Bariloche"})
CREATE(u1)-[:Flights {}]->(f1)