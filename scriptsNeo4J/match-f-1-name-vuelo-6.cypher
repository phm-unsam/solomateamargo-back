MATCH (f1 {name: "vuelo6"})
MATCH (c1 {name: "Bariloche"})
CREATE(f1)-[:Destination {}]->(c1)