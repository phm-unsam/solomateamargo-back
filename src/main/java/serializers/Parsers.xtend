package serializers

class Parsers {
	static def errorToJson(String message) {
		'{ "error": "' + message + '" }'
	}
}
