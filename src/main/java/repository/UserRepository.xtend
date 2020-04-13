package repository

import domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

class UserRepository extends Repository<User> {
	@Accessors String tipo = "U"

	private new() {
	}

	static UserRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new UserRepository()
		}
		instance
	}

	override update(User user) { // PROB ESTO CAMBIE 
		var elementoViejo = searchByID(user.getId())
		user.friends = elementoViejo.friends
		user.purchases = elementoViejo.purchases
		delete(elementoViejo)
		create(user)
	}

	def match(User userToLog) {
		elements.findFirst(user|user.isThisYou(userToLog))
	}

	override exceptionMsg() {
		"Usuario no encontrado"
	}

	def addCash(String userId, double cashToAdd) {
		if (cashToAdd <= 0) {
			throw new BusinessException("La suma de dinero ingresada es incorrecta")
		}
		searchByID(userId).setCash(cashToAdd)
	}

	def addFriend(String userId, String friendId) {
		val user = searchByID(userId)
		val friend = searchByID(friendId)

		user.addFriend(friend)
	}

	def deleteFriend(String userId, String friendId) {
		val user = searchByID(userId)
		val friend = searchByID(friendId)

		user.deleteFriend(friend)
	}

	def getPossibleFriends(String userId) {
		val friendList = searchByID(userId).friends
		elements.filter(user|!friendList.contains(user) && user.getId != userId).toSet
	}

}