package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
class ShoppingCart {
	List<Ticket> tickets = new ArrayList()

	def totalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.cost()])
	}

	def removeTicket(Ticket ticket) {
		tickets.removeIf[it.seat == ticket.seat]
	}

	def addTicket(Ticket ticket) {
		if(ticketIsAlreadyAdded(ticket))
			throw new BusinessException("El ticket ya esta en el carrito")
		tickets.add(ticket)
	}
	
	def ticketIsAlreadyAdded(Ticket ticket){
		tickets.exists[it.seat==ticket.seat]
	}
	
	def clearCart() {
		tickets.clear()
	}
	
	def purchaseCart(){ 
		if(tickets.isEmpty)
			throw new BusinessException ("El carrito esta vacio")
		tickets.forEach[it.reserve]
		clearCart
	}

}
