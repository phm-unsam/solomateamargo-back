package repository

import domain.Flight
import domain.FlightFilter
import org.bson.types.ObjectId
import serializers.NotFoundException

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
		println("concha de la lora 2")
		ds.get(Flight, id)
	}

	def void update(Flight flight) {
		ds.update(flight, this.defineUpdateOperations(flight))
	}

	def defineUpdateOperations(Flight flight) {
		ds.createUpdateOperations(entityType).set("seats", flight.seats)
	}

	def getFlights(FlightFilter filter) {
		val query = ds.createQuery(entityType)
		val result = filter.filterCriteria(query)
		result.asList.toSet
	}

}
