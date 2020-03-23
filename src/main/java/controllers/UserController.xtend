package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.User
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import repository.UserRepository
import serializers.Parsers
import serializers.UserSerializer

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class UserController {
	UserRepository userRepository = UserRepository.getInstance
	extension JSONUtils = new JSONUtils

	@Post("/user/login")
	def login(@Body String body) {
		try {
			val userBody = body.fromJson(User)
			val user = this.userRepository.match(userBody)
			if (user === null) {
				return notFound("Username o password incorrectos")
			}
			return ok(UserSerializer.toJson(user))
			
		} catch (Exception e) {
			internalServerError(Parsers.errorToJson(e.message))
		}
	}
}
