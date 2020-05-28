package services

import domain.FlightFilter
import org.bson.types.ObjectId
import repository.FlightRepository
import repository.LogRepository

class FlightService {
	FlightRepository flightRepository = FlightRepository.getInstance
	LogRepository logRepository = LogRepository.getInstance

	def getFlightsFiltered(FlightFilter filt) {
		logRepository.create(filt)
		flightRepository.getFlights(filt)
	}

	def getSeatsFromFlight(String flightId) {
		val flight = flightRepository.searchById(new ObjectId(flightId))
		flight.seats.filter[it.available].toSet
	}

}
