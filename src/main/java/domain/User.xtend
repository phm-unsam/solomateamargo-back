package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException
import serializers.BusinessException

@Accessors
@Entity
class User {
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
	@ManyToMany(fetch=FetchType.LAZY)
	@JsonIgnore Set<User> friends = new HashSet()
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JsonIgnore List<Ticket> purchases = new ArrayList()
	
	@Column
	String profilePhoto
	
	@Column
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
