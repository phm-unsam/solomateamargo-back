package rest

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import domain.User
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class FlightController {
	FlightRepository flightRepository = FlightRepository.getInstance
	UserRepository userRepository = UserRepository.getInstance
	
	extension JSONUtils = new JSONUtils
	
	@Get("/vuelos_disponibles")
	def Result allFlights(){
		try{
			val vueloDisponible = flightRepository.getElements
			ok(FlightSerializer.toJson(vueloDisponible.toList)) 
		}	catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Post("/login")
	def login(@Body String body){
		try{
			val userBody = body.fromJson(User)
			val user = this.userRepository.match(userBody)
			
			user !== null ? return ok(userIdCreator(user)) : return badRequest(errorJson("Usuario no encontrado."))
			
		}	catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	private def errorJson(String message) {
        '{ "error": "' + message + '" }'
    }
    
    private def userIdCreator(User user){
    	'{ 
			"userId": "' + user.userId + '",
			"status": "OK"
		}'
    }
}

