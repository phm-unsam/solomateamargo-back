package serializers

import java.time.LocalDate
import java.time.format.DateTimeFormatter

class Parse {
	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")

	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}
	static def statusOkJson() {
		'{ "status": "ok" }'
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
