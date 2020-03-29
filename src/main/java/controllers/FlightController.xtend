package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import repository.FlightRepository
import serializers.BadDateFormatException
import serializers.FlightSerializer
import serializers.NotFoundException
import serializers.Parse
import serializers.SeatSerializer
import domain.FlightFilter

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightRepository flightRepository = FlightRepository.getInstance

	@Get("/flights")
	def Result flightsFiltered(String dateFrom, String dateTo, String departure, String arrival) {
		try {
			val filters = new FlightFilter(dateFrom, dateTo, departure, arrival)
			val filtered = flightRepository.getFlightsFiltered (filters)			
			ok( FlightSerializer.toJson(filtered))
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
			val seatsAvaliables = flightRepository.getSeatsByFlightId(flightId)
			ok(SeatSerializer.toJson(seatsAvaliables))
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

}
