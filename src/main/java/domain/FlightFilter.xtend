package domain

import java.text.SimpleDateFormat
import org.bson.types.ObjectId
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.query.Query
import repository.LogRepository

@Entity(value="Logs", noClassnameStored=true)
class FlightFilter {

	new() {
	}

	@Id ObjectId id
	Long userId
	String dateFrom
	String dateTo
	String departure
	String arrival
	String seatType
	String nextoWindow

	new(String _dateFrom, String _dateTo, String _departure, String _arrival, String _seatType, String _nextoWindow) {
		dateFrom = _dateFrom
		dateTo = _dateTo
		arrival = _arrival
		departure = _departure
		seatType = _seatType
		nextoWindow = _nextoWindow
	}

	def filterCriteria(Query<Flight> query) {

		if(!departure.isNullOrEmpty) query.field("destinationFrom").containsIgnoreCase(departure)
		if(!arrival.isNullOrEmpty) query.field("destinationTo").containsIgnoreCase(arrival)

		if (hasDatesToFilter) {
			query.field("departure").greaterThanOrEq(new SimpleDateFormat("dd/MM/yyyy").parse(dateFrom))
			query.field("departure").lessThanOrEq(new SimpleDateFormat("dd/MM/yyyy").parse(dateTo))
		}

		query.field("seats.available").equal(true)

		if (!nextoWindow.isNullOrEmpty) {
			query.field("seats.nextoWindow").equal(Boolean.parseBoolean(nextoWindow))
		}

		if (!seatType.isNullOrEmpty) {
			query.field("seats.type").equal(seatType)
		}

	}

	def hasDatesToFilter() {
		(dateFrom !== null) && (dateTo !== null)
	}

	def hasDataToFilter() {
		hasDatesToFilter || !departure.isNullOrEmpty || !arrival.isNullOrEmpty
	}

}
