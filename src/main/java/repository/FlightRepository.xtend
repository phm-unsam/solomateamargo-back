package repository

import domain.Flight
import domain.FlightFilter
import org.bson.types.ObjectId

class FlightRepository extends MongoPersistantRepo<Flight> {
	
	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}

	override getEntityType() { Flight }
	
	override searchById(ObjectId id) {
		val query = ds.createQuery(entityType)
		if(id !== null){
			query.field("id").equal(id)
		}
		validateQuery(query, "No existe el vuelo")
		query.get()
	}
	
	def void update(Flight flight) {
		ds.update(flight, this.defineUpdateOperations(flight))
	}

	def defineUpdateOperations(Flight flight){
		ds.createUpdateOperations(entityType)
			.set("seats", flight.seats)
	}
	
	def getFlights(FlightFilter filter){
		val query = ds.createQuery(entityType)
		filter.filterCriteria(query)
		query.asList
	}

}
