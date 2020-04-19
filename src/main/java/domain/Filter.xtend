package domain

import java.time.LocalDate
import serializers.Parse

abstract class Filter<T extends Object> {

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
