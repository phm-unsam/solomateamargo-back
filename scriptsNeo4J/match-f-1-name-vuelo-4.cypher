MATCH (f1 {name: "vuelo4"})
MATCH (c1 {name: "Dubai"})
CREATE(f1)-[:Destination {}]->(c1)