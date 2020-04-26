package domain

import java.time.LocalDate
import java.util.HashSet
import java.util.Set
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import serializers.Parse

abstract class Filter<T extends Object> {

	def Set<Predicate> filterCriteria(CriteriaBuilder c, Root<T> from)
}

class FlightFilter extends Filter<Flight> {
	LocalDate dateFrom
	LocalDate dateTo
	String departure
	String arrival
	Set<Predicate> criterias = new HashSet();

	new(String _dateFrom, String _dateTo, String _departure, String _arrival) {
		dateFrom = Parse.stringToLocalDateTime(_dateFrom)
		dateTo = Parse.stringToLocalDateTime(_dateTo)
		arrival = _arrival
		departure = _departure
	}
	
	override filterCriteria(CriteriaBuilder c, Root<Flight> from) {
		criterias.add(c.like(from.get("destinationFrom"), "%" + departure + "%"))
		criterias.add(c.like(from.get("destinationTo"), "%" + arrival + "%"))
		
		if(hasDatesToFilter){
			criterias.add(c.greaterThan(from.get("departure"), dateFrom))
			criterias.add(c.lessThan(from.get("departure"), dateTo))
		}
			
		return criterias
	}
	
	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}
	
}

class SeatFilter extends Filter<Seat> {
	String seatType
	String nextoWindow
	Long flight_id
	Set<Predicate> criterias = new HashSet();

	new(String _seatType, String _nextoWindow, String flightId) {
		seatType = _seatType
		nextoWindow = _nextoWindow
		flight_id = Long.parseLong(flightId)
	}
	
	override filterCriteria(CriteriaBuilder c, Root<Seat> from) {
		if(!nextoWindow.isNullOrEmpty){
			criterias.add(c.equal(from.get("nextoWindow"), Boolean.parseBoolean(nextoWindow)))
		}
		
		if(!seatType.isNullOrEmpty){
			criterias.add(c.equal(from.get("type"), seatType))
		}
		
		
		criterias.add(c.equal(from.get("available"), 1))
		criterias.add(c.equal(from.get("flight_id"), flight_id))
		return criterias
	}

}
