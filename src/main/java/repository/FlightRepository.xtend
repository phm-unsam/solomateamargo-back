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
		query.asList.toSet
	}
	
	def getSeatsByFlightId(ObjectId id){
		// searchById(id).seats.filter[it.available].toSet //De esta manera filtramos en memoria...
		val query = ds.createQuery(entityType)
		if(id !== null){
			query.field("id").equal(id)
		}
		query.field("seats.available").equal(true)
		query.get().seats
	}

}
