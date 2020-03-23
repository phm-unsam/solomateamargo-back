package serializers

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class Parsers {
	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}
	static def getStringDateFromLocalDateTime(LocalDateTime date){
		val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd")
        date.format(formatter)
	}
	static def getStringTimeFromLocalDateTime(LocalDateTime date){
		val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm")
        date.format(formatter)
	}
}
