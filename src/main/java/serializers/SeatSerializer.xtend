package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Seat
import java.io.IOException
import java.util.List

class SeatSerializer extends StdSerializer<Seat> {

	protected new(Class<Seat> t) {
		super(t)
	}

	override serialize(Seat value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("class", value.type)
		gen.writeStringField("number", value.number)
		gen.writeBooleanField("isNextToWindow", value.nextoWindow)
		gen.writeNumberField("cost", value.cost)
		gen.writeEndObject()
	}

	static def String toJson(List<Seat> seats) {
		mapper().writeValueAsString(seats)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Seat, new SeatSerializer(Seat))
		mapper.registerModule(module)
		mapper
	}
}
