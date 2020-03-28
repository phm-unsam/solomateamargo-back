package domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.Parse

@Accessors
class Filter {
	LocalDate dateFrom
	LocalDate dateTo
	String departure
	String arrival
	String seatClass

	new(String _dateFrom, String _dateTo, String _seatClass, String _departure, String _arrival) {
		dateFrom = Parse.stringToLocalDateTime(_dateFrom)
		dateTo = Parse.stringToLocalDateTime(_dateTo)
		seatClass = _seatClass
		arrival = _arrival
		departure = _departure
	}

	def hasDatesToFilter() {
		return dateFrom !== null && dateTo !== null
	}
	

}