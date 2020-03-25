package serializers

import java.time.LocalDate
import java.time.format.DateTimeFormatter
import org.eclipse.xtend.lib.annotations.Accessors

class Parse {
	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")

	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}

	static def getStringDateFromLocalDate(LocalDate date) {
		date.format(formatter)
	}

	static def getStringTimeFromLocalDateTime(LocalDate date) {
		date.format(formatter)
	}

	static def stringToLocalDateTime(String date) {
		try {
			if (!date.nullOrEmpty)
				LocalDate.parse(date, formatter)
		} catch (Exception e) {
			throw new BadDateFormatException("La fecha ingresada es incorrecta")
		}
	}

}

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

class NotFoundException extends Exception {

	new(String msg) {
		super(msg)
	}
}

class BusinessException extends Exception {

	new(String msg) {
		super(msg)
	}
}

class BadDateFormatException extends Exception {

	new(String msg) {
		super(msg)
	}
}

class FriendAlreadyInFriendList extends Exception {

	new(String msg) {
		super(msg)
	}
}
