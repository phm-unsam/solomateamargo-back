package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import repository.FlightRepository
import serializers.FlightSerializer
import serializers.Parsers

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightRepository flightRepository = FlightRepository.getInstance
	
	//extension JSONUtils = new JSONUtils
	
	@Get("/flights/all")
	def Result allFlights(){
		try{
			val vueloDisponible = flightRepository.getElements
			ok(FlightSerializer.toJson(vueloDisponible.toList)) 
		}	catch (Exception e) {
			internalServerError(Parsers.errorToJson(e.message))
		}
	}
}

