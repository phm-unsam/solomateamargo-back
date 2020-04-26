package repository

import domain.Flight
import javax.persistence.criteria.JoinType

class FlightRepository extends PersistantRepo<Flight> {

	private new() {
	}

	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}
	
	override getEntityType() {
		Flight
	}
	
	def searchById(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("seats", JoinType.LEFT)
			query.select(from).where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	
	

//	def getAvaliableSeatsByFlightId(String flightId) {
//		val flight = searchByID(flightId)
//		if(!flight.hasSeatsAvaliables){
//			throw new NotFoundException("No hay asientos disponibles para el vuelo "+flight.id)
//		}
//			
//		flight.seatsAvailiables
//	}
//	
//
//	def getAvaliableFlights() {
//		elements.filter[it.hasSeatsAvaliables].toList
//
//	}
//
//	override exceptionMsg() {
//		"No existen vuelos diponibles"
//	}
//
//	def getFlightsFiltered(FlightFilter filters) {
//		filterList(getAvaliableFlights, filters)
//	}
//
//	def getSeatsFiltered(SeatFilter filters, String flightId) {
//		var seats = getAvaliableSeatsByFlightId(flightId).toList
//		filterList(seats, filters)
//	}

}
