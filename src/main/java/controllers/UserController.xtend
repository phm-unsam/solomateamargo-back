package controllers

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import domain.User
import javax.persistence.NoResultException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repository.UserRepository
import serializers.BusinessException
import serializers.NotFoundException
import serializers.Parse
import serializers.PurchaseSerializer
import serializers.UserSerializer
import services.UserService

@Controller
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
class UserController {
	UserRepository userRepository = UserRepository.getInstance
	UserService userService = new UserService()
	extension JSONUtils = new JSONUtils

	@Post("/user/login")
	def login(@Body String body) {
		try {
			val userBody = body.fromJson(User)
			val user = this.userRepository.login(userBody)
			return ok(UserSerializer.toJson(user))
		} catch (NoResultException e) {
			notFound(Parse.errorToJson("No existe la combinacion de usuario y contraseña"))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Get("/user/:userId/profile")
	def profile() {
		try {
			val user = userRepository.searchById(userId)
			return ok(user.toJson)
		} catch (NoResultException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Get("/user/:userId/friends")
	def friends() {
		try {
			val friends = userService.getUserFriends(userId)
			return ok(UserSerializer.toJson(friends))
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Get("/user/:userId/possiblefriends")
	def possibleFriends() {
		try {
			val possibleFriends = this.userRepository.getPossibleFriends(userId)
			return ok(UserSerializer.toJson(possibleFriends))
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Put("/user/:userId/addcash")
	def addCash(@Body String body) {
		try {
			val cash = body.fromJson(Double)
			userService.addCash(userId, cash)
			return ok("{status : ok}")
		} catch (BusinessException e) {
			badRequest(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Put("/user/:userId/profile")
	def updateProfile(@Body String body) {
		try {
			val userBody = body.fromJson(User)
			userService.updateProfile(userId,userBody)
			return ok("{status : ok}")
			
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}

	@Post("/user/:userId/friends/:newFriendId")
	def addFriend() {
		try {
			userService.addFriend(userId, newFriendId)
			return ok("{status : ok}")
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Delete("/user/:userId/friends/:deletedId")
	def deleteFriend() {
		try {
			userService.deleteFriend(userId, deletedId)
			return ok("{status : ok}")
		} catch (BusinessException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
	
	@Get("/user/:userId/purchases")
	def purchases() {
		try {
			val purchases = userService.userPurchases(userId)
			return ok(PurchaseSerializer.toJson(purchases))
		} catch (NotFoundException e) {
			notFound(Parse.errorToJson(e.message))
		} catch (Exception e) {
			internalServerError(Parse.errorToJson(e.message))
		}
	}
}
