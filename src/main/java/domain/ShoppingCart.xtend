package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.TicketSerializer

@Accessors
class ShoppingCart implements Entidad {
	String id
	@JsonSerialize(using=typeof(TicketSerializer))
	List<Ticket> tickets = newArrayList
	Long userId
	
	long idCounter = 0

	def validate() {
		if (tickets.isEmpty)
			throw new BusinessException("El carrito esta vacio")
		if (tickets.exists[!it.seat.avaliable])
			throw new BusinessException("Hay tickets en el carrito no disponibles")
	}

	new(Long _userId) {
		userId = _userId
	}

	def getTotalCost() {
		tickets.fold(0.0, [total, ticket|total + ticket.getCost()])
	}
	
	def getNumberOfTickets() {
		tickets.size
	}

	def removeTicket(long id) {
		if (!tickets.exists[it.id == id])
			throw new BusinessException("No existe un ticket con ese id para eliminar")
		tickets.removeIf[it.id == id]
	}

	def addTicket(Ticket ticket) {
		if (ticketIsAlreadyAdded(ticket))
			throw new BusinessException("El ticket ya esta en el carrito")
		ticket.id=idCounter
		idCounter++
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
