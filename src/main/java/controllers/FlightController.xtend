package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.FlightFilter
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import serializers.BadDateFormatException
import serializers.NotFoundException
import serializers.Parse
import services.FlightService

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightService flightService = new FlightService()
	
	extension JSONUtils = new JSONUtils

	@Get("/flights")
	def Result flightsFiltered(String dateFrom, String dateTo, String departure, String arrival, String seatType, String nextoWindow) {
		try {
			val filters = new FlightFilter(dateFrom, dateTo, departure, arrival, seatType, nextoWindow)
			val filteredFlights = flightService.getFlightsFiltered(filters)
			ok(filteredFlights.toJson)
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (BadDateFormatException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Get("/flight/:flightId/seats")
	def Result seats() {
		try {
			val seatsAvailables = flightService.getSeatsFromFlight(flightId)
			ok(seatsAvailables.toJson)
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
}
