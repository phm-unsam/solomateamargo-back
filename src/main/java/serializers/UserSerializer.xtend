package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.User
import java.io.IOException

class UserSerializer extends StdSerializer<User> {

	protected new(Class<User> t) {
		super(t)
	}

	override serialize(User value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeStringField("id", value.userId)
		gen.writeStringField("name", value.name)
		gen.writeStringField("lastName", value.lastName)
		gen.writeEndObject()
	}

	static def String toJson(User user) {
		mapper().writeValueAsString(user)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(User, new UserSerializer(User))
		mapper.registerModule(module)
		mapper
	}
}
