package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
class ShoppingCart{
	List<Ticket> tickets = new ArrayList()
	int currentId = 0
	

	def totalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.cost()])
	}

	def removeTicket(String id) {
		if(!tickets.exists[it.id==id])
			throw new BusinessException("No existe un ticket con ese id para eliminar")
		tickets.removeIf[it.id == id]
	}

	def addTicket(Ticket ticket) {
		if(ticketIsAlreadyAdded(ticket))
			throw new BusinessException("El ticket ya esta en el carrito")
		ticket.setId(currentId.toString)
		currentId++
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
		if(tickets.exists[!it.seat.avaliable])
			throw new BusinessException ("Hay tickets en el carrito no disponibles")
		tickets.forEach[it.reserve]
		clearCart
	}

}
