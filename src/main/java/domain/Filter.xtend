package domain

import java.time.LocalDate
import java.util.HashSet
import java.util.Set
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import serializers.Parse
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.SetJoin


class FlightFilter {
	LocalDate dateFrom
	LocalDate dateTo
	String departure
	String arrival
	String seatType
	String nextoWindow

	new(String _dateFrom, String _dateTo, String _departure, String _arrival, String _seatType, String _nextoWindow) {
		dateFrom = Parse.stringToLocalDateTime(_dateFrom)
		dateTo = Parse.stringToLocalDateTime(_dateTo)
		arrival = _arrival
		departure = _departure
		seatType = _seatType
		nextoWindow = _nextoWindow
	}
	
	def filterCriteria(CriteriaBuilder c, Root<Flight> from, SetJoin seats) {
		val criterias = new HashSet();
		
		if(!departure.isNullOrEmpty) criterias.add(c.like(from.get("destinationFrom"), "%" + departure + "%")) 
		if(!arrival.isNullOrEmpty) criterias.add(c.like(from.get("destinationTo"), "%" + arrival + "%"))
		
		
		if(hasDatesToFilter){
			criterias.add(c.greaterThan(from.get("departure"), dateFrom))
			criterias.add(c.lessThan(from.get("departure"), dateTo))
		}
		
		
		criterias.add(c.equal(seats.get("available"), 1))
		
		if(!nextoWindow.isNullOrEmpty){
			criterias.add(c.equal(seats.get("nextoWindow"), Boolean.parseBoolean(nextoWindow)))
		}
		
		if(!seatType.isNullOrEmpty){
			criterias.add(c.equal(seats.get("type"), seatType))
		}
				
		return criterias
	}
	
	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}
	
}