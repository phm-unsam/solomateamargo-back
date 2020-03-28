package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.Ticket
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import repository.FlightRepository
import repository.UserRepository
import serializers.BusinessException
import serializers.Parse
import serializers.TicketSerializer

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class CartController {
	UserRepository userRepository = UserRepository.getInstance
	FlightRepository flightRepository = FlightRepository.getInstance

	@Post("/user/:userId/cart/add")
	def Result addToCart(String flightId, String seatNumber) {
		try {
			val user = userRepository.searchByID(userId)
			user.addTicketToCart(createTicket(flightId,seatNumber))
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Post("/user/:userId/cart/remove")
	def Result removeFromCart(String flightId, String seatNumber) {
		try {
			val user = userRepository.searchByID(userId)
			user.removeTicketFromCart(createTicket(flightId,seatNumber))
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Post("/user/:userId/cart/purchase")
	def Result purchaseCart() {
		try {
			val user = userRepository.searchByID(userId)
			user.purchaseCartTickets()
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	@Delete("/user/:userId/cart/clear")
	def Result removeFromCart() {
		try {
			val user = userRepository.searchByID(userId)
			user.shoppingCart.clearCart
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Get("/user/:userId/cart")
	def Result getShoppingCart() {
		try {
			val cart = userRepository.searchByID(userId).shoppingCart
			ok(TicketSerializer.toJson(cart.tickets))
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	

	def createTicket(String flightId, String seatNumber) {
		val flight = flightRepository.searchByID(flightId)
		val seat = flight.getSeatByNumber(seatNumber)
		new Ticket(flight,seat)

	}

}
