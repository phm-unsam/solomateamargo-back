package repository

import domain.User
import javax.persistence.NoResultException
import serializers.NotFoundException

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

	def User seatchById(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	
	def login(User userToLog) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
				query.select(from)
				.where(
					criteria.and(
					criteria.equal(from.get("username"), userToLog.username),
					criteria.equal(from.get("password"), userToLog.password)
					)
				)
			entityManager.createQuery(query).singleResult
		}catch(NoResultException e ){
			throw new NotFoundException("No existe la combinacion de usuario y contraseña")
		}
		finally {
			entityManager?.close
		}
	}

//	override update(User user) { // PROB ESTO CAMBIE 
//		var elementoViejo = searchByID(user.getId())
//		user.friends = elementoViejo.friends
//		user.purchases = elementoViejo.purchases
//		delete(elementoViejo)
//		create(user)
//	}
//
//	def match(User userToLog) {
//		elements.findFirst(user|user.isThisYou(userToLog))
//	}
//
//	override exceptionMsg() {
//		"Usuario no encontrado"
//	}
//
//	def addCash(String userId, double cashToAdd) {
//		if (cashToAdd <= 0) {
//			throw new BusinessException("La suma de dinero ingresada es incorrecta")
//		}
//		searchByID(userId).setCash(cashToAdd)
//	}
//
//	def addFriend(String userId, String friendId) {
//		val user = searchByID(userId)
//		val friend = searchByID(friendId)
//
//		user.addFriend(friend)
//	}
//
//	def deleteFriend(String userId, String friendId) {
//		val user = searchByID(userId)
//		val friend = searchByID(friendId)
//
//		user.deleteFriend(friend)
//	}
//
//	def getPossibleFriends(String userId) {
//		val friendList = searchByID(userId).friends
//		elements.filter(user|!friendList.contains(user) && user.getId != userId).toSet
// }
}
