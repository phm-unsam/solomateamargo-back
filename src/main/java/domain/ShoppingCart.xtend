package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.TicketSerializer

@Accessors
@Entity
class ShoppingCart{
	@Id @GeneratedValue
	Long id
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JsonSerialize(using = typeof(TicketSerializer))
	List<Ticket> tickets = new ArrayList()
	
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
		if(tickets.exists[!it.seat.avaliable])
			throw new BusinessException ("Hay tickets en el carrito no disponibles")
		tickets.forEach[it.buyTicket]
		clearCart
	}

}
