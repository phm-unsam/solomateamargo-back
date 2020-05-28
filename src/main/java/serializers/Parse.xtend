package serializers

import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Date
import java.text.DateFormat

class Parse {
	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	static val DateFormat df = new SimpleDateFormat("dd/MM/yyyy")

	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}
	static def statusOkJson() {
		'{ "status": "ok" }'
	}

	static def getStringDateFromLocalDate(Date date) {
		df.format(date)
	}
	
	static def getStringFromDate(Date date) {
		val dateFormat = new SimpleDateFormat("dd/MM/yyyy");  
		dateFormat.format(date)
	}

	static def stringToLocalDateTime(String date) {
		try {
			if (!date.nullOrEmpty)
				LocalDate.parse(date, formatter)
		} catch (Exception e) {
			throw new BadDateFormatException(e.message)
		}
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
