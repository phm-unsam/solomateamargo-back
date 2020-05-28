package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import java.time.LocalDate
import org.bson.types.ObjectId
import java.util.Date

class DateSerializer extends JsonSerializer<Date> {

	override serialize(Date date, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeString(Parse.getStringDateFromLocalDate(date))
	}
}

class ObjectIdSerializer extends JsonSerializer<ObjectId> {
	override serialize(ObjectId id, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeString(id.toString)
	}
}