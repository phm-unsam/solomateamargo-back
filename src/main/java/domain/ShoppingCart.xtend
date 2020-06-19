package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.List
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
		val ticketid = new Long(id)
		if (!tickets.exists[it.id == ticketid])
			throw new BusinessException("No existe un ticket con ese id para eliminar")
		tickets.removeIf[it.id == ticketid]
	}

	def addTicket(Ticket ticket) {
		if (ticketIsAlreadyAdded(ticket))
			throw new BusinessException("El ticket ya esta en el carrito")
		ticket.id = currentId + 1
		tickets.add(ticket)
	}
	
	def currentId(){
		if(tickets.isEmpty)
			return new Long(0)
		tickets.maxBy[it.id].id
	}
	
	def ticketIsAlreadyAdded(Ticket ticket) {
		tickets.contains(ticket)
	}


	def reserveTickets() {
		validate
		tickets.forEach[it.buyTicket]
	}

}
