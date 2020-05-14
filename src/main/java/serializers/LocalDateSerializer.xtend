package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import java.time.LocalDate

class LocalDateSerializer extends JsonSerializer<LocalDate> {

	override serialize(LocalDate date, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeString(Parse.getStringDateFromLocalDate(date))
	}
}