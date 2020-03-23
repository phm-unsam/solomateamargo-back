package serializers

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class Consts {
	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}

	static def getStringDateFromLocalDateTime(LocalDateTime date) {
		val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd")
		date.format(formatter)
	}

	static def getStringTimeFromLocalDateTime(LocalDateTime date) {
		val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm")
		date.format(formatter)
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

