package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.Ticket
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import repository.ShoppingCartRepo
import serializers.BusinessException
import serializers.Parse

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class CartController {
	ShoppingCartRepo cartRepository = ShoppingCartRepo.getInstance
	
	extension JSONUtils = new JSONUtils
	
	@Post("/user/:userId/cart/item")
	def Result addToCart(@Body String body) {
		try {
			val ticket = body.fromJson(Ticket)
			cartRepository.addItem(Long.parseLong(userId),ticket)
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Delete("/user/:userId/cart/item/:ticketId")
	def Result removeFromCart() {
		try {
			cartRepository.removeItem(Long.parseLong(userId),Long.parseLong(ticketId))
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Post("/user/:userId/cart/purchase")
	def Result purchaseCart() {
		try {
			cartRepository.purchaseCartfromUser(Long.parseLong(userId))
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(e.toJson)
		}
	}
	
	@Delete("/user/:userId/cart")
	def Result removeFromCart() {
		try {
			val cart = cartRepository.getUserCart(Long.parseLong(userId))
			cart.clearCart
			ok(Parse.statusOkJson)
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Get("/user/:userId/cart")
	def Result getShoppingCart() {
		try {
			val cart = cartRepository.getUserCart(Long.parseLong(userId))
			ok(cart.toJson)
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

}
