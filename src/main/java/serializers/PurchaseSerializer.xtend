package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Ticket
import java.io.IOException
import java.util.List

class PurchaseSerializer extends StdSerializer<Ticket> {

	protected new(Class<Ticket> t) {
		super(t)
	}

	override serialize(Ticket value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("from", value.flight.destinationFrom)
		gen.writeStringField("to", value.flight.destinationTo)
		gen.writeStringField("departure",Parse.getStringDateFromLocalDate(value.flight.departure))
		gen.writeStringField("purchaseDate", Parse.getStringDateFromLocalDate(value.purchaseDate))
		gen.writeStringField("airline", value.flight.airline)
		gen.writeNumberField("cost", value.getCost)
		gen.writeEndObject()
	}

	static def String toJson(Ticket purchase) {
		mapper().writeValueAsString(purchase)
	}
	
	static def String toJson(List<Ticket> purchase) {
		mapper().writeValueAsString(purchase)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Ticket, new PurchaseSerializer(Ticket))
		mapper.registerModule(module)
		mapper
	}
}