package domain

import java.time.LocalDate
import serializers.Parse


abstract class Filter <T extends Object>{
	
	def boolean matchesCriteria(T value)
	
	def matches(String actualValue, String valueToCompare){
		valueToCompare.nullOrEmpty || actualValue.contains(valueToCompare)
	}	
}

class FlightFilter extends Filter<Flight>{
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
	
	override matchesCriteria(Flight flight){
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
	

}

class SeatFilter extends Filter <Seat>{
	String seatType
	boolean nextoWindow
	boolean filterNextoWindowNull
	
	new(String _seatType, String _nextoWindow){
		seatType = _seatType
		nextoWindow = Boolean.parseBoolean(_nextoWindow)
		filterNextoWindowNull = _nextoWindow.isNullOrEmpty
	}
	
	override matchesCriteria(Seat seat){
		matches(seat.type,seatType) &&
		filterSeatPosition(seat.nextoWindow)
	}
	
	def filterSeatPosition(boolean seatIsNextoWindow){
		filterNextoWindowNull || nextoWindow.equals(seatIsNextoWindow)
	}
}





