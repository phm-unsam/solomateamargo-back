package repository

import domain.Entidad
import domain.Flight
import domain.FlightFilter
import domain.SeatFilter
import domain.User
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.NotFoundException
import domain.Filter

abstract class Repository<T extends Entidad> {
	@Accessors protected List<T> elements = new ArrayList<T>
	protected int id = 0

	def void create(T element) {
		if (element.getId === null) {
			id++
			element.setId(newID)
			elements.add(element)
		} else {
			elements.add(element)
		}
	}

	def String newID() {
		getTipo + id.toString()
	}

	def delete(T element) {
		elements.remove(element)
	}

	def update(T elementoNuevo) {
		var id = elementoNuevo.getId()
		var elementoViejo = searchByID(id)
		delete(elementoViejo)
		create(elementoNuevo)
	}

	def searchByID(String id) {
		exceptionCatcher(elements.findFirst[it.id.contains(id)])
	}

	def String getTipo()

	def exceptionCatcher(T result) {
		if (result === null)
			throw new NotFoundException(exceptionMsg)
		result
	}

	def String exceptionMsg()

	def <E> filterList(List<E> list, Filter<E> filters) {
		list.filter[filters.matchesCriteria(it)].toList
	}
}

class FlightRepository extends Repository<Flight> {
	@Accessors String tipo = "F"

	private new() {
	}

	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}

	def getAvaliableSeatsByFlightId(String flightId) {
		val flight = searchByID(flightId)
		if(!flight.hasSeatsAvaliables){
			throw new NotFoundException("No hay asientos disponibles para el vuelo "+flight.id)
		}
			
		flight.getSeatsAvailiables
	}
	

	def getAvaliableFlights() {
		elements.filter[it.hasSeatsAvaliables].toList

	}

	override exceptionMsg() {
		"No existen vuelos diponibles"
	}

	def getFlightsFiltered(FlightFilter filters) {
		filterList(getAvaliableFlights, filters)
	}

	def getSeatsFiltered(SeatFilter filters, String flightId) {
		var seats = getAvaliableSeatsByFlightId(flightId).toList
		filterList(seats, filters)
	}

}

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
