MATCH (u1 {userName: "Tini"})
MATCH (f1 {destinationTo: "Bariloche"})
CREATE(u1)-[:Flights {}]->(f1)