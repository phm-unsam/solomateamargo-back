package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

@Accessors
@Entity
class User{
	@Id @GeneratedValue
	Long id
	@Column
	String name
	@Column
	String lastName
	@Column
	String username
	@Column
	String password
	@Column
	int age
	@ManyToMany(fetch=FetchType.EAGER )
	@JsonIgnore Set <User> friends = new HashSet()
	//@JsonIgnore List <Ticket> purchases = new ArrayList()
	@Column
	String profilePhoto
	@Column
	double cash = 60000
	//@JsonIgnore ShoppingCart shoppingCart = new ShoppingCart
	
	
	def isThisYou(User user) {
		checkUsername(user) && checkPassword(user)
	}
	
	def checkPassword(User user) {
		user.username == username
	}
	
	def checkUsername(User user) {
		user.password == password
	}
	
	def setCash(double newAmount){
		cash += newAmount
	}
	
	def addFriend(User newFriend){
		friends.add(newFriend)
	}
	
	def deleteFriend(User friend){
		isMyFriend(friend) ? friends.remove(friend) : throw new NotFoundException("User not found in friend list")
	}
	
	def isMyFriend(User user) {
		friends.contains(user)
	}	
	
//	def addTicketToCart(Ticket ticket){
//		shoppingCart.addTicket(ticket)
//	}
//	
//	def removeTicketFromCart(String ticketId){
//		shoppingCart.removeTicket(ticketId)
//	}
//	
//	def purchaseCartTickets(){
//		if(shoppingCart.totalCost > cash)
//			throw new BusinessException("Dinero insuficiente para realizar la compra")
//		cash -= shoppingCart.totalCost
//		purchases.addAll(shoppingCart.tickets)
//		shoppingCart.purchaseCart()
//	}
}