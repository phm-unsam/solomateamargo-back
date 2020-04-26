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
			gen.writeNumberField("flightId", value.flight.id)
			gen.writeStringField("from", value.flight.destinationFrom)
			gen.writeStringField("to", value.flight.destinationTo)
			gen.writeStringField("departure",value.flight.departure)
			gen.writeStringField("airline", value.flight.airline)
			gen.writeStringField("seatNumber", value.seat.getNumber)
			gen.writeStringField("seatType", value.seat.type)
			gen.writeNumberField("cost", value.getCost)
			gen.writeBooleanField("avaliable", value.seat.isAvaliable)
			gen.writeEndObject
		]
		gen.writeEndArray()
	}
	
}
