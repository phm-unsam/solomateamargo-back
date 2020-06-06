package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.TicketSerializer

@Accessors
class ShoppingCart {
	@JsonSerialize(using=typeof(TicketSerializer))
	List<Ticket> tickets = newArrayList
	
	new(List<Ticket> _tickets){
		tickets = _tickets
	}

	def validate() {
		if (tickets.isEmpty)
			throw new BusinessException("El carrito esta vacio")
	}

	def getTotalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.getCost()])
	}
	
	def getNumberOfTickets() {
		tickets.size
	}

	def removeTicket(String id) {
		if (!tickets.exists[it.idC == idC])
			throw new BusinessException("No existe un ticket con ese id para eliminar")
		tickets.removeIf[it.idC.toString == id]
	}

	def addTicket(Ticket ticket) {
		if (ticketIsAlreadyAdded(ticket))
			throw new BusinessException("El ticket ya esta en el carrito")
		ticket.idC = new ObjectId
		tickets.add(ticket)
	}

	def ticketIsAlreadyAdded(Ticket ticket) {
		tickets.contains(ticket)
	}

	def clearCart() {
		tickets.clear()
	}

	def purchaseCart() {
		validate
		tickets.forEach[it.buyTicket]
	}

}
