package rest

import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.Flight
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import java.util.List
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.module.SimpleModule

class FlightSerializer extends StdSerializer<Flight> {
	
	protected new(Class<Flight> t) {
		super(t)
	}
	
	override serialize(Flight value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("id", value.flightId)
		gen.writeStringField("from", value.from)
		gen.writeStringField("to", value.to)
		gen.writeStringField("airportName", value.airportName)
		gen.writeNumberField("baseCost",value.baseCost)
		gen.writeNumberField("flightDuration", value.getFlightDuration)
		gen.writeEndObject()
	}
	
	static def String toJson(List<Flight> items) {
		if(items===null || items.empty){return "[ ]"}
		mapper().writeValueAsString(items)
	}
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Flight,new FlightSerializer(Flight))
		mapper.registerModule(module)
		mapper
	}
	
	
}