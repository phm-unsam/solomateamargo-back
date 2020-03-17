package rest

import java.util.Set
import java.util.HashSet
import java.util.List
import domain.Entidad
import domain.Flight
import domain.User
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Repository <T extends Entidad>{
	Set<T> elementos = new HashSet<T>
	int id = 0

	def void create(T element) {
		if (element.getID === null) {
			id++
			element.setID(newID)
			elementos.add(element)
		} else {
			elementos.add(element)
		}
	}

	def String newID() {
		getTipo + id.toString()
	}

	def delete(T element) {
		elementos.remove(element)
	}

	def update(T elementoNuevo) {
		var id = elementoNuevo.getID()
		var elementoViejo = searchByID(id)
		delete(elementoViejo)
		create(elementoNuevo)
	}

	def searchByID(String id) {
		elementos.findFirst(element|element.getID == id)
	}

	def List<T> search(String value) {
		elementos.filter[condicionDeBusqueda(it, value)].toList
	}

	def boolean condicionDeBusqueda(T el, String value)

	def String getTipo()
}

class FlightRepository extends Repository<Flight> {
	@Accessors String tipo = "F"
	
	override condicionDeBusqueda(Flight el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}

class UserRepository extends Repository<User> {
	@Accessors String tipo = "U"
	
	override condicionDeBusqueda(User el, String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}