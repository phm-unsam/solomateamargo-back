package domain

import java.time.LocalDate
import serializers.Parse
import org.mongodb.morphia.query.Query
import java.text.SimpleDateFormat
import java.util.Date

class FlightFilter {
	Date dateFrom
	Date dateTo
	String departure
	String arrival
	String seatType
	String nextoWindow

	new(String _dateFrom, String _dateTo, String _departure, String _arrival, String _seatType, String _nextoWindow) {
		dateFrom = new SimpleDateFormat("dd/MM/yyyy").parse(_dateFrom)
		dateTo = new SimpleDateFormat("dd/MM/yyyy").parse(_dateTo)
		arrival = _arrival
		departure = _departure
		seatType = _seatType
		nextoWindow = _nextoWindow
	}
	
	def filterCriteria(Query<Flight> query) {
		
		if(!departure.isNullOrEmpty) query.field("destinationFrom").containsIgnoreCase(departure)
		if(!arrival.isNullOrEmpty) query.field("destinationTo").containsIgnoreCase(arrival)
		
		
		if(hasDatesToFilter){
			query.field("departure").greaterThanOrEq(dateFrom)
			query.field("departure").lessThanOrEq(dateTo)
		}
		
		query.field("seats.available").equal(true)
		
		if(!nextoWindow.isNullOrEmpty){
			query.field("seats.nextoWindow").equal(Boolean.parseBoolean(nextoWindow))
		}
		
		if(!seatType.isNullOrEmpty){
			query.field("seats.type").equal(seatType)
		}
				
		return query
	}
	
	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}
	
}