package repository

class RepoUserNeo4J extends RepoNeo4J{
	static RepoUserNeo4J instance
	
	def static RepoUserNeo4J getInstance() {
		if(instance === null){
			instance = new RepoUserNeo4J
		}
		instance
	}
	
	
}