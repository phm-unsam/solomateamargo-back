package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ShoppingCart {
	List<Ticket> tickets = new ArrayList()

	def totalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.cost()])
	}

	def removeTicket(Ticket ticket) {
		ticket.quitReservation
		tickets.removeIf[it.seat == ticket.seat]
	}

	def addTicket(Ticket ticket) {
		ticket.reserve
		tickets.add(ticket)
	}

	def clearCart() {
		tickets.forEach[it.quitReservation]
		tickets.clear()
	}
	
	def purchaseCart(){ 
		tickets.clear
	}

}
