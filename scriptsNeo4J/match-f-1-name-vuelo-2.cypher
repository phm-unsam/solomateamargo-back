MATCH (f1 {name: "vuelo2"})
MATCH (c1 {name: "Barcelona"})
CREATE(f1)-[:Destination {}]->(c1)