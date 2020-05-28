package services

import domain.Ticket
import repository.FlightRepository
import repository.ShoppingCartRepo
import repository.UserRepository

class CartService {
	UserRepository userRepo = UserRepository.getInstance
	ShoppingCartRepo shoppingCartRepo = ShoppingCartRepo.getInstance

	def purchaseCartfromUser(String userId) {
		val cart = getUserCart(userId)
		val user = userRepo.searchById(userId)
		user.addPurchase(cart.tickets.toSet, cart.totalCost)
		cart.tickets.forEach[it.popularData]
		cart.purchaseCart
		cart.tickets.forEach[FlightRepository.getInstance.update(it.flight)]
		userRepo.update(user)
		cart.clearCart
	}

	def removeItem(String userId, long ticketId) {
		getUserCart(userId).removeTicket(ticketId)
	}

	def addItem(String userId, Ticket ticket) {
		getUserCart(userId).addTicket(ticket)
	}
	
	def cleanUserCart(String userId) {
		val cart = getUserCart(userId)
			cart.clearCart
	}
	
	def getUserCart(String userId) {
		val cart = shoppingCartRepo.getCartByKey(userId)
		if(cart === null){
			shoppingCartRepo.create(userId)
			return shoppingCartRepo.getCartByKey(userId)
		}
		cart.tickets.forEach[it.popularData]
		cart
	}
	
}

