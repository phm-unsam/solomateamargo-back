package repository

import domain.User
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

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
		querySingleResult(loginQuery, userToLog)
	}

	def loginQuery() {
		[ CriteriaBuilder criteria, CriteriaQuery<User> query, Root<User> from, User userToLog |
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("username"), userToLog.username),
					criteria.equal(from.get("password"), userToLog.password)
				)
			)
		]
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
//	def getPossibleFriends(String userId) {
//		val friendList = searchByID(userId).friends
//		elements.filter(user|!friendList.contains(user) && user.getId != userId).toSet
// }
}
