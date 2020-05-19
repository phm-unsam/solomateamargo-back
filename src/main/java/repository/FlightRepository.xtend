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
		validateQuery(query, "No existen vuelos para esos parametros")
		query.asList.toSet
	}
	
	def getSeatsByFlightId(ObjectId id){
		// searchById(id).seats.filter[it.available].toSet //De esta manera filtramos en memoria...
		val query = ds.createQuery(entityType)
		if(id !== null){
			query.field("id").equal(id)
		}
		query.field("seats.available").equal(true)
		validateQuery(query, "No hay asientos para ese vuelo")
		query.get().seats
	}

}
