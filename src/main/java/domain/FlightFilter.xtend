package domain

import java.time.LocalDate
import serializers.Parse

class FlightFilter {
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
	
	def flightMatchCriteria(Flight flight){
		matches(flight.to,arrival) &&
		matches(flight.from,departure)  &&
		filterDates(flight)
	}
	

	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}
	
	def filterDates(Flight flight){
		!hasDatesToFilter || flight.isBetweenTheDates(dateFrom,dateTo)
	} 
	
	def matches(String actualValue, String valueToCompare){
		valueToCompare.nullOrEmpty || actualValue.contains(valueToCompare)
	}

}

class SeatsFilter{
	
}