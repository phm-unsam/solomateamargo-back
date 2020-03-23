package repository

import domain.Entidad
import domain.Flight
import domain.ShoppingCart
import domain.User
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

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
		val result = elements.findFirst[it.ID.contains(id)]
		if(result===null)
			throw new Exception ("No existen vuelos con ese id")
		result
	}

	def List<T> search(String value) {
		elements.filter[condicionDeBusqueda(it, value)].toList
	}

	def boolean condicionDeBusqueda(T el, String value)

	def String getTipo()
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
	
	def getAvaliableFlights(){
		elements.filter(flight|flight.hasSeatsAvaliables)
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

	def match(User userToLog) {
		elements.findFirst(user|user.isThisYou(userToLog))
	}

	override condicionDeBusqueda(User el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
}

class ShoppingCartRepository extends Repository<ShoppingCart> {
	@Accessors String tipo = "R"

	override condicionDeBusqueda(ShoppingCart el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
