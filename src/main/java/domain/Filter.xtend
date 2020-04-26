package domain

import java.time.LocalDate
import serializers.Parse
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import java.util.List
import org.hibernate.Criteria
import java.util.ArrayList
import javax.persistence.criteria.Predicate
import java.util.HashSet
import java.util.Set

/*abstract class Filter<T extends Object> {

	def boolean matchesCriteria(T value)

	def matches(String actualValue, String valueToCompare) {
		valueToCompare.nullOrEmpty || actualValue.toLowerCase().contains(valueToCompare.toLowerCase())
	}
}

class FlightFilter extends Filter<Flight> {
	LocalDate dateFrom
	LocalDate dateTo
	String departure
	String arrival

	new(String _dateFrom, String _dateTo, String _departure, String _arrival) {
		dateFrom = Parse.stringToLocalDateTime(_dateFrom)
		dateTo = Parse.stringToLocalDateTime(_dateTo)
		arrival = _arrival
		departure = _departure
	}

	override matchesCriteria(Flight flight) {
		matches(flight.destinationTo, arrival) && matches(flight.destinationFrom, departure) && filterDates(flight)
	}

	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}

	def filterDates(Flight flight) {
		!hasDatesToFilter || isBetweenTheDates(Parse.stringToLocalDateTime(flight.departure))
	}
	
	def isBetweenTheDates(LocalDate flightDate) {
		(flightDate.isBefore(dateTo) && flightDate.isAfter(dateFrom)) || 
		flightDate.equals(dateFrom) || 
		flightDate.equals(dateTo)
	}

}

class SeatFilter extends Filter<Seat> {
	String seatType
	boolean nextoWindow
	boolean filterNextoWindowNull

	new(String _seatType, String _nextoWindow) {
		seatType = _seatType
		nextoWindow = Boolean.parseBoolean(_nextoWindow)
		filterNextoWindowNull = _nextoWindow.isNullOrEmpty
	}

	override matchesCriteria(Seat seat) {
		matches(seat.type, seatType) && filterSeatPosition(seat.nextoWindow)
	}

	def filterSeatPosition(boolean seatIsNextoWindow) {
		filterNextoWindowNull || nextoWindow.equals(seatIsNextoWindow)
	}
}
*/

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
			println("ESTOY aca: filterNextoWindowNull y mi valor es:" + Boolean.parseBoolean(nextoWindow))
			println("que pija sos nextoWindow??????? Soy:" + nextoWindow)
			criterias.add(c.equal(from.get("nextoWindow"), Boolean.parseBoolean(nextoWindow)))
		}
		
		if(!seatType.isNullOrEmpty){
			println("ESTOY aca: filterSeatType y mi valor es:" + seatType)
			println("que pija sos nextoWindow??????? Soy:" + nextoWindow)
			criterias.add(c.equal(from.get("type"), seatType))
		}
		
		
		criterias.add(c.equal(from.get("available"), 1))
		criterias.add(c.equal(from.get("flight_id"), flight_id))
		return criterias
	}

}
