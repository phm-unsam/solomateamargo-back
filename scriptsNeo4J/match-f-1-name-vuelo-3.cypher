MATCH (f1 {name: "vuelo3"})
MATCH (c1 {name: "Suiza"})
CREATE(f1)-[:Destination {}]->(c1)