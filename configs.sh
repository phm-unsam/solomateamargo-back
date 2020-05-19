mongo mongodb://127.0.0.1:40001
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "kubernetes.docker.internal:40001" },
      { _id : 1, host : "kubernetes.docker.internal:40002" },
    ]
  }
)
exit

mongo mongodb://127.0.0.1:50001

rs.initiate(
  {
    _id: "shard1rs",
    members: [
      { _id : 0, host : "kubernetes.docker.internal:50001" },
      { _id : 1, host : "kubernetes.docker.internal:50002" },
    ]
  }
)
exit

mongo mongodb://127.0.0.1:50004

rs.initiate(
  {
    _id: "shard2rs",
    members: [
      { _id : 0, host : "kubernetes.docker.internal:50004" },
      { _id : 1, host : "kubernetes.docker.internal:50005" },
    ]
  }
)
exit

mongo mongodb://127.0.0.1:60000

sh.addShard("shard1rs/kubernetes.docker.internal:50001,kubernetes.docker.internal:50002")
sh.addShard("shard1rs/kubernetes.docker.internal:50003,kubernetes.docker.internal:50004")

db.Flights.ensureIndex({"flightDuration": "hashed"})

sh.enableSharding("aterrizapp")

sh.shardCollection("aterrizapp.Flights", {"flightDuration": "hashed" }, false)

#  ---- extra...

# sh.shardCollection("aterrizapp.Flights", {"departure": "hashed" }, false)

# docker volume prune
# docker volume ls -f dangling=true
# docker rmi
# docker system prune -a
# docker system prune
