package repository

import domain.Entidad
import domain.Flight
import domain.ShoppingCart
import domain.User
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException
import serializers.Filter
import serializers.NotFoundException

abstract class Repository<T extends Entidad> {
	@Accessors protected Set<T> elements = new HashSet<T>
	protected int id = 0

	def void create(T element) {
		if (element.getID === null) {
			id++
			element.setID(newID)
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
		var id = elementoNuevo.getID()
		var elementoViejo = searchByID(id)
		delete(elementoViejo)
		create(elementoNuevo)
	}

	def searchByID(String id) {
		exceptionCatcher(elements.findFirst[it.ID.contains(id)])
	}

	def List<T> search(String value) {
		elements.filter[condicionDeBusqueda(it, value)].toList
	}

	def boolean condicionDeBusqueda(T el, String value)

	def String getTipo()

	def exceptionCatcher(T result) {
		if (result === null)
			throw new NotFoundException(exceptionMsg)
		result
	}

	def String exceptionMsg()
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

	override condicionDeBusqueda(Flight el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	def getSeatsByFlightId(String flightId) {
		searchByID(flightId).getSeatsAvailiables.toList
	}

	def getAvaliableFlights() {
		elements.filter(flight|flight.hasSeatsAvaliables)

	}

	override exceptionMsg() {
		"No existen vuelos diponibles"
	}
	//beta
	def getFlightsFiltered(Filter filters) {
		var filtered = elements.filter(elem | true)
		if(filters.hasDatesToFilter)
			filtered = filtered.filter(flight|flight.isBetweenTheDates(filters.dateFrom,filters.dateTo))
		if(!filters.departure.nullOrEmpty)
			filtered = filtered.filter(flight|flight.from.contains(filters.departure))
		if(!filters.arrival.nullOrEmpty)
			filtered = filtered.filter(flight|flight.to.contains(filters.arrival))
		//if(filters.seatClass.nullOrEmpty)
		
		filtered.toList
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
		var elementoViejo = searchByID(user.getID())
		user.friends = elementoViejo.friends
		user.purchases = elementoViejo.purchases
		delete(elementoViejo)
		create(user)
	}

	def match(User userToLog) {
		elements.findFirst(user|user.isThisYou(userToLog))
	}

	override condicionDeBusqueda(User el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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
		elements.filter(user|!friendList.contains(user) && user.getID != userId).toSet
	}

}

class ShoppingCartRepository extends Repository<ShoppingCart> {
	@Accessors String tipo = "R"

	override condicionDeBusqueda(ShoppingCart el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override exceptionMsg() {
		"Carrito de compras no encontrado"
	}

}
