package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.FlightFilter
//import domain.SeatFilter
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repository.FlightRepository
import serializers.BadDateFormatException
import serializers.NotFoundException
import serializers.Parse
import domain.SeatFilter

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightRepository flightRepository = FlightRepository.getInstance
	
	extension JSONUtils = new JSONUtils

	@Get("/flights")
	def Result flightsFiltered(String dateFrom, String dateTo, String departure, String arrival) {
		try {
			val filters = new FlightFilter(dateFrom, dateTo, departure, arrival)
			val filtered = flightRepository.getAvailableFlights(filters)			
			ok(filtered.toJson)
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (BadDateFormatException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Get("/flight/:flightId/seats")
	def Result seats(String seatType, String nextoWindow) {
		try {
			val filters = new SeatFilter(seatType, nextoWindow, flightId)
			val seatsAvaliables = flightRepository.getAvaliableSeatsByFlightId(filters)
			ok(seatsAvaliables.toJson)
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
}
