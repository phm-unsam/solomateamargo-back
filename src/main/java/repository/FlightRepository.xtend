package repository

import domain.Flight

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
