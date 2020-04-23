package repository

import domain.ShoppingCart
import domain.Ticket
import domain.User

class ShoppingCartRepo extends MemoryRepository<ShoppingCart>{
	
	
	private new() {
	}

	static ShoppingCartRepo instance

	static def getInstance() {
		if (instance === null) {
			instance = new ShoppingCartRepo()
		}
		instance
	}
	
	
	override getTipo() {
		"SC"
	}
	
	override exceptionMsg() {
		"carrito no encontrado"
	}
	
	def getUserCart(Long userId){
		elements.findFirst[it.userId == userId]
	}
	
	def addItem(Long userId, Ticket ticket){
		getUserCart(userId).addTicket(ticket)
	}
	
	def purchaseCartfromUser(User user){
		val cart = getUserCart(user.id)
		cart.purchaseCart
		user.addTickets(cart.tickets)
	}
}