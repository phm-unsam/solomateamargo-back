package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ShoppingCart implements Entidad{
	List <Ticket> tickets = new ArrayList()
	String repositoryId
	String userId
	
	override getID() {
		repositoryId
	}
	
	override setID(String id) {
		repositoryId = id
	}
	
	def ticketsCost() {
		tickets.fold(0.0, [total, ticket | total + ticket.cost()])
	}
	
	def delete(Ticket ticket){
		tickets.remove(ticket)
	}
	
	def add(Ticket ticket){
		tickets.add(ticket)
	}
	
	def deleteAll(){
		tickets.clear()
	}
	
	
	
}