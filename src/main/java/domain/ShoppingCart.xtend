package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.TicketSerializer

@Accessors
class ShoppingCart implements Entidad{
	String id
	@JsonSerialize(using = typeof(TicketSerializer))
	List<Ticket> tickets = new ArrayList()
	Long userId
	
	def getTotalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.getCost()])
	}
	
	def getNumberOfTickets(){
		tickets.size
	}

	def removeTicket(String id) {
		if(!tickets.exists[it.id==id])
			throw new BusinessException("No existe un ticket con ese id para eliminar")
		tickets.removeIf[it.id == id]
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
		if(tickets.exists[!it.seat.available])
			throw new BusinessException ("Hay tickets en el carrito no disponibles")
		tickets.forEach[it.buyTicket]
		clearCart
	}

}
