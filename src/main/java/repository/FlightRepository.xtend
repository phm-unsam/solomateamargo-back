package repository

import domain.Flight

class FlightRepository extends PersistantRepo<Flight> {
	
	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}

	override getEntityType() { Flight }
	
	def createWhenNew(Flight flight) {
		if (searchByExample(flight).isEmpty) {
			this.create(flight)
		}
	}
	
	
	override searchByExample(Flight f) {
		val query = ds.createQuery(entityType)
		if(f.id !== null){
			query.field("id").equal(f.id)
		}
		query.asList
	}
	
	override defineUpdateOperations(Flight t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	

}
