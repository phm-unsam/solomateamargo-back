package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class User implements Entidad{
	String name
	String lastName
	int age
	String username
	String password
	String userId
	List <User> friends = new ArrayList()
	List <Purchase> purchases = new ArrayList() 
	
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
	
}