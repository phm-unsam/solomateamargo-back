package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import java.time.LocalDate
import org.bson.types.ObjectId

class LocalDateSerializer extends JsonSerializer<LocalDate> {

	override serialize(LocalDate date, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeString(Parse.getStringDateFromLocalDate(date))
	}
}

class ObjectIdSerializer extends JsonSerializer<ObjectId> {
	override serialize(ObjectId id, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeString(id.toString)
	}
}