package repository

import domain.ShoppingCart
import domain.Ticket
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

class ShoppingCartRepo {
	@Accessors protected Set<ShoppingCart> elements = new HashSet<ShoppingCart>
	protected int id = 0
	UserRepository userRepo = UserRepository.getInstance
	private new() {
	}

	static ShoppingCartRepo instance

	static def getInstance() {
		if (instance === null) {
			instance = new ShoppingCartRepo()
		}
		instance
	}

	def void create(ShoppingCart element) {
		if (element.getId === null) {
			id++
			element.setId(id.toString())
			elements.add(element)
		} else {
			elements.add(element)
		}
	}

	def searchByID(String id) {
		elements.findFirst[it.id.contains(id)]
	}

	def getUserCart(Long userId) {
		val cart = elements.findFirst[it.userId == userId]
		if(cart === null)
			create(new ShoppingCart(userId))
			
		elements.findFirst[it.userId == userId]
	}

	def removeItem(Long userId, long ticketId) {
		getUserCart(userId).removeTicket(ticketId)
	}

	def addItem(Long userId, Ticket ticket) {
		getUserCart(userId).addTicket(ticket)
	}

}
