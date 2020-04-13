package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Purchase
import java.io.IOException
import java.util.List

class PurchaseSerializer extends StdSerializer<Purchase> {

	protected new(Class<Purchase> t) {
		super(t)
	}

	override serialize(Purchase value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("from", value.ticket.flight.from)
		gen.writeStringField("to", value.ticket.flight.to)
		gen.writeStringField("departure",value.ticket.flight.departure)
		gen.writeStringField("purchaseDate", value.purchaseDate)
		gen.writeStringField("airline", value.ticket.flight.airline)
		gen.writeNumberField("cost", value.cost)
		gen.writeEndObject()
	}

	static def String toJson(Purchase purchase) {
		mapper().writeValueAsString(purchase)
	}
	
	static def String toJson(List<Purchase> purchase) {
		mapper().writeValueAsString(purchase)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Purchase, new PurchaseSerializer(Purchase))
		mapper.registerModule(module)
		mapper
	}
}