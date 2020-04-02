package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Ticket
import java.io.IOException
import java.util.List

class TicketSerializer extends StdSerializer<Ticket> {

	protected new(Class<Ticket> t) {
		super(t)
	}

	override serialize(Ticket value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("flightId", value.flight.id)
		gen.writeStringField("from", value.flight.from)
		gen.writeStringField("to", value.flight.to)
		gen.writeStringField("departure",Parse.getStringDateFromLocalDate(value.flight.departure))
		gen.writeStringField("airline", value.flight.airline)
		gen.writeStringField("seatNumber", value.seat.getNumber)
		gen.writeStringField("seatType", value.seat.type)
		gen.writeNumberField("cost", value.cost)
		gen.writeEndObject()
	}

	static def String toJson(Ticket ticket) {
		mapper().writeValueAsString(ticket)
	}
	
	static def String toJson(List<Ticket> ticket) {
		mapper().writeValueAsString(ticket)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Ticket, new TicketSerializer(Ticket))
		mapper.registerModule(module)
		mapper
	}
}
