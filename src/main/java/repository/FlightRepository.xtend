package repository

import domain.Flight
import domain.FlightFilter
import domain.Seat
import domain.SeatFilter
import javassist.NotFoundException
import javax.persistence.NoResultException
import javax.persistence.criteria.JoinType

class FlightRepository extends PersistantRepo<Flight> {

	private new() {
	}

	static FlightRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new FlightRepository()
		}
		instance
	}
	
	override getEntityType() {
		Flight
	}
	
	def searchById(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("seats", JoinType.LEFT)
			query.select(from).where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	
	def getAvailableFlights(FlightFilter filter) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("seats", JoinType.LEFT)
			val seats = from.joinSet("seats", JoinType.INNER)
			val criterias = filter.filterCriteria(criteria, from)
			
			query.where(criteria.equal(seats.get("available"), 1))
			query.where(criterias)
			
			entityManager.createQuery(query).resultList.toSet;
		}catch(NoResultException e ){
			throw new NotFoundException("No hay vuelos disponibles.")
		}
		finally {
			entityManager?.close
		}

	}
	

	def getAvaliableSeatsByFlightId(SeatFilter filter) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Seat)
			val from = query.from(Seat)
			val criterias = filter.filterCriteria(criteria, from)
			
			query.where(criterias)
			
			entityManager.createQuery(query).resultList.toSet;
		}catch(NoResultException e ){
			throw new NotFoundException("No hay vuelos disponibles.")
		}
		finally {
			entityManager?.close
		}
	}
}
