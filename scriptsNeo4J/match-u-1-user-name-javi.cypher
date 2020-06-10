MATCH (u1 {userName: "Javi"})
MATCH (u2 {userName: "Tini"})
CREATE(u1)-[:Friend {}]->(u2)