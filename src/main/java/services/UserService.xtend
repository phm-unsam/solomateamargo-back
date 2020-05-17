package services

import domain.Ticket
import domain.User
import java.util.Set
import repository.UserRepository

class UserService {
	
	UserRepository userRepo = UserRepository.getInstance
	
	def addCash(String userId, double cashToAdd) {
		val user = userRepo.searchById(userId)
		user.setCash(cashToAdd)
		userRepo.update(user)
	}

	def updateProfile(String id, User userUpdated) {
		var user = userRepo.searchById(id)
		user.age = userUpdated.age
		user.password = userUpdated.password
		userRepo.update(user)
	}

	def addTickets(Set<Ticket> tickets, double cost, String userId) {
		val user = userRepo.searchById(userId)
		user.addPurchase(tickets, cost)
		userRepo.update(user)
	}
	
	def addFriend(String userId, String friendId) {
		val user = userRepo.searchById(userId)
		user.addFriend(userRepo.searchById(friendId))
		userRepo.update(user)
	}

	def deleteFriend(String userId, String friendId) {
		val user = userRepo.searchById(userId)
		user.deleteFriend(userRepo.searchById(friendId))
		userRepo.update(user)
	}
	
	def userPurchases(String id) {
		userRepo.searchById(id).purchases
	}
	
	def getUserFriends(String id) {
		userRepo.searchById(id).friends
	}
	
	
}