package rest

import org.uqbar.xtrest.api.annotation.Controller
import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.Result
@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightRepository flightRepository = FlightRepository.getInstance
	
	@Get("/vuelos_disponibles")
	def Result allFlights(){
		try{
			
			val vueloDisponible = flightRepository.getElementos
			ok(FlightSerializer.toJson(vueloDisponible.toList)) 
		}	catch (Exception e) {
			internalServerError(e.message)
		}
		
	}
	
}