package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.NotFoundException

@Accessors
class User implements Entidad{
	String name
	String lastName
	String id
	String username
	String password
	int age
	@JsonIgnore Set <User> friends = new HashSet()
	@JsonIgnore List <Purchase> purchases = new ArrayList()
	String profilePhoto
	double cash = 400000
	@JsonIgnore ShoppingCart shoppingCart = new ShoppingCart
	
	
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
	
	def addTicketToCart(Ticket ticket){
		shoppingCart.addTicket(ticket)
	}
	
	def removeTicketFromCart(Ticket ticket){
		shoppingCart.removeTicket(ticket)
	}
	
	def purchaseCartTickets(){
		if(shoppingCart.totalCost > cash)
			throw new BusinessException("Dinero insuficiente para realizar la compra")
		cash -= shoppingCart.totalCost
		shoppingCart.tickets.forEach[purchases.add(new Purchase(it))]
		shoppingCart.purchaseCart()
	}
}