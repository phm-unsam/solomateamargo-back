package repository

import domain.ShoppingCart
import domain.Ticket

class ShoppingCartRepository extends Repository<ShoppingCart>{
	
	
	
	
	def addTicket(Long cartId, Ticket ticket){
		val cart = searchByID(cartId)
		cart.addTicket(ticket)
	}
	
	
	override exceptionMsg() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}