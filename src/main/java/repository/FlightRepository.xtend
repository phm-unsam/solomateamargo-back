package repository

import domain.Flight
import domain.FlightFilter
import domain.Seat
import javassist.NotFoundException
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

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
	
	override void queryById(Long id, CriteriaBuilder builder, CriteriaQuery<Flight> query, Root<Flight> from){
		from.fetch("seats", JoinType.LEFT)
		query.select(from).where(builder.equal(from.get("id"), id))
	}
	
	def getAvailableFlights(FlightFilter filter) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			
			val seats = from.joinSet("seats", JoinType.INNER)
			from.fetch("seats", JoinType.INNER)
			val criterias = filter.filterCriteria(criteria, from, seats)
			
			
			query.where(criterias)
			
			entityManager.createQuery(query).resultList.toSet;
		}catch(NoResultException e ){
			throw new NotFoundException("No hay vuelos disponibles.")
		}
		finally {
			entityManager?.close
		}

	}
	

	def getAvaliableSeatsByFlightId(Long flight_id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Seat)
			val from = query.from(Seat)
			query.where(criteria.equal(from.get("flight_id"), flight_id))			
			entityManager.createQuery(query).resultList.toSet;
		}catch(NoResultException e ){
			throw new NotFoundException("No hay asientos disponibles.")
		}
		finally {
			entityManager?.close
		}
	}
}
