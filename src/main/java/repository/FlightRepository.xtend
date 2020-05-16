package repository

import domain.Flight
import domain.FlightFilter

class FlightRepository extends MongoPersistantRepo<Flight> {
	
	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}

	override getEntityType() { Flight }
	
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
	
	def createWhenNew(Flight flight) {
		if (searchByExample(flight).isEmpty) {
			this.create(flight)
		}
	}
	
	def getFlights(FlightFilter filter){
		val query = ds.createQuery(entityType)
		val result = filter.filterCriteria(query)
		result.asList.toSet
	}

}
