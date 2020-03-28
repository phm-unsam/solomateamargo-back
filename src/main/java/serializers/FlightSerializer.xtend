package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Flight
import java.io.IOException
import java.util.List

class FlightSerializer extends StdSerializer<Flight> {
	
	protected new(Class<Flight> t) {
		super(t)
	}
	
	override serialize(Flight value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("id", value.id)
		gen.writeStringField("from", value.from)
		gen.writeStringField("to", value.to)
		gen.writeStringField("airlineName", value.airline)
		gen.writeNumberField("baseCost",value.baseCost)
		gen.writeNumberField("stopoversAmount",value.stopoversAmount)		
		gen.writeNumberField("flightDuration", value.getFlightDuration)
		gen.writeStringField("DepartureDate", Parse.getStringDateFromLocalDate(value.departure))
		gen.writeEndObject()
	}
	
	static def String toJson(List<Flight> flights) {
		 mapper().writeValueAsString(flights)
	}
	
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Flight,new FlightSerializer(Flight))
		mapper.registerModule(module)
		mapper
	}
}
