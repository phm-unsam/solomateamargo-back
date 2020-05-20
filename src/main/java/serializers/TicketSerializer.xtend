package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import domain.Ticket
import java.io.IOException
import java.util.List

class TicketSerializer extends JsonSerializer<List<Ticket>>  {
	
	override serialize(List<Ticket> tickets, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartArray()
		tickets.forEach[value|
			gen.writeStartObject()
			gen.writeNumberField("id", value.id)
			gen.writeStringField("flightId", value.getFlight.id.toString)
			gen.writeStringField("from", value.getFlight.destinationFrom)
			gen.writeStringField("to", value.getFlight.destinationTo)
			gen.writeStringField("departure",Parse.getStringFromDate(value.flight.departure))
			gen.writeStringField("airline", value.getFlight.airline)
			gen.writeStringField("seatNumber", value.getSeat.getNumber)
			gen.writeStringField("seatType", value.getSeat.type)
			gen.writeNumberField("cost", value.getCost)
			gen.writeBooleanField("avaliable", value.getSeat.isAvailable)
			gen.writeEndObject
		]
		gen.writeEndArray()
	}
	
}
