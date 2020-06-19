MATCH (f1 {name: "vuelo1"})
MATCH (c1 {name: "Madrid"})
CREATE(f1)-[:Destination {}]->(c1)