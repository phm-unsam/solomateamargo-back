package domain

import java.time.LocalDate
import serializers.Parse
import org.mongodb.morphia.query.Query

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
	
	def filterCriteria(Query<Flight> query) {
		
		if(!departure.isNullOrEmpty) query.field("destinationFrom").equal(departure)
		if(!arrival.isNullOrEmpty) query.field("destinationTo").equal(arrival)
		
		
		if(hasDatesToFilter){
			query.field("departure").greaterThan(dateFrom)
			query.field("departure").lessThan(dateTo)
		}
		
		//criterias.add(c.equal(seats.get("available"), 1))
		
		if(!nextoWindow.isNullOrEmpty){
			//criterias.add(c.equal(seats.get("nextoWindow"), Boolean.parseBoolean(nextoWindow)))
		}
		
		if(!seatType.isNullOrEmpty){
			//criterias.add(c.equal(seats.get("type"), seatType))
		}
				
		return query
	}
	
	def hasDatesToFilter() {
		dateFrom !== null && dateTo !== null
	}
	
}