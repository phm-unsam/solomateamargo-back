package repository

import domain.Entidad
import domain.Filter
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

abstract class MemoryRepository<T extends Entidad> {
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

