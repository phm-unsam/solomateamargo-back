MATCH (gonza:User {userName: "Gonza"})-[:Friend]->(u:User)
MATCH (u)-[:Friend]->(u2:User)
WHERE NOT EXISTS((u2)-[:Friend]->(gonza)) AND u2.age > 18 AND u2.userName <> gonza.userName
RETURN u2