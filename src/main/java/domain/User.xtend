package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import javax.persistence.FetchType
import javax.persistence.JoinTable
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.NotFoundException
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.Relationship

@NodeEntity(label="User")
@Accessors
class User {
	@Id @GeneratedValue
	Long id
	
	@Property(name="name")
	String name
	
	@Property(name="lastName")
	String lastName

	@Property(name="username")
	String username
	

	String password
	int age

	@Relationship(type = "FRIENDS", direction = "INCOMING")
	@JsonIgnore Set<User> friends = new HashSet()
	
	@JsonIgnore List<Ticket> purchases = new ArrayList()
	

	String profilePhoto

	double cash = 60000


	def setCash(double newAmount) {
		cash += newAmount
	}

	def addFriend(User newFriend) {
		friends.add(newFriend)
	}

	def deleteFriend(User friend) {
		isMyFriend(friend) ? friends.remove(friend) : throw new NotFoundException("User not found in friend list")
	}

	def isMyFriend(User user) {
		friends.contains(user)
	}

	def addPurchase(Set<Ticket> newTickets,double cost) {
		if(cost>cash)
			throw new BusinessException("Dinero induficiente")
		cash -= cost
		purchases.addAll(newTickets)
	}

	override equals(Object obj) {
		try {
			val other = obj as User
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}
	
	override hashCode() {
		if (id !== null) id.hashCode else super.hashCode
	}
}
