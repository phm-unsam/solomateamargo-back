package services

import domain.Ticket
import repository.FlightRepository
import repository.ShoppingCartRepo
import repository.UserRepository
import domain.ShoppingCart

class CartService {
	UserRepository userRepo = UserRepository.getInstance
	ShoppingCartRepo shoppingCartRepo = ShoppingCartRepo.getInstance

	def purchaseCartfromUser(String userId) {
		val cart = getUserCart(userId)
		val user = userRepo.searchById(userId)
		user.addPurchase(cart.tickets.toSet, cart.totalCost)
		popularTickets(cart)
		cart.purchaseCart
		cart.tickets.forEach[FlightRepository.getInstance.update(it.flight)]
		userRepo.update(user)
		cart.clearCart
	}

	def removeItem(String userId, String ticketId) {
		val cart = getUserCart(userId)
		cart.removeTicket(ticketId)
		shoppingCartRepo.update(userId, cart.tickets)
	}

	def addItem(String userId, Ticket ticket) {
		val cart = getUserCart(userId)
		cart.addTicket(ticket)
		
		shoppingCartRepo.update(userId, cart.tickets)
	}

	def cleanUserCart(String userId) {
		shoppingCartRepo.clearCart(userId)
	}

	def getUserCart(String userId) {
		val items = shoppingCartRepo.getItemsByKey(userId)
		val cart = new ShoppingCart(items)
		popularTickets(cart)
		cart
	}

	def popularTickets(ShoppingCart cart) {
			cart.tickets.forEach[it.popularData]
	}

}
