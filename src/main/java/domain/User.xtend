package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import java.util.HashSet
import serializers.NotFoundException

@Accessors
class User implements Entidad{
	String name
	String lastName
	int age
	String username
	String password
	String userId
	@JsonIgnore Set <User> friends = new HashSet()
	@JsonIgnore List <Purchase> purchases = new ArrayList()
	String profilePhoto
	double cash
	
	override getID() {
		userId
	}
	
	override setID(String id) {
		userId = id
	}
	
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
	
	
	
}