package repository

import domain.Ticket
import domain.User
import java.util.Set
import javax.persistence.criteria.JoinType

class UserRepository extends PersistantRepo<User> {

	private new() {
	}

	static UserRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new UserRepository()
		}
		instance
	}

	override getEntityType() {
		User
	}

	def login(User userToLog) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("username"), userToLog.username),
					criteria.equal(from.get("password"), userToLog.password)
				)
			)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}

	}


	def searchById(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("friends", JoinType.LEFT)
			from.fetch("purchases", JoinType.LEFT)
			query.select(from).where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def addFriend(Long userId, Long friendId) {
		val user = searchById(userId)
		user.addFriend(searchById(friendId))
		update(user)
	}

	def deleteFriend(Long userId, Long friendId) {
		val user = searchById(userId)
		user.deleteFriend(searchById(friendId))
		update(user)
	}

	def getPossibleFriends(Long id) {
		val a = searchById(id)
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("friends",JoinType.LEFT)
			if(a.friends.empty)
				query.where(criteria.notEqual(from.get("id"),id))
			else
				query.where(criteria.not(from.get("id").in(a.friends.map[it.id].toSet)),
					criteria.notEqual(from.get("id"),id)
				)
			
			entityManager.createQuery(query).resultList.toSet
		} finally {
			entityManager?.close
		}
	}

	def addCash(Long userId, double cashToAdd) {
		val user = searchById(userId)
		user.setCash(cashToAdd)
		update(user)
	}

	def updateProfile(Long id, User userUpdated) {  
		var user  = searchById(id)
		user.age = userUpdated.age
		user.password = userUpdated.password
		update(user)
	}
	
	def addTickets(Set<Ticket> tickets, double cost, Long userId){
		val user = searchById(userId)
		user.addPurchase(tickets,cost)
		update(user)
	}

}
