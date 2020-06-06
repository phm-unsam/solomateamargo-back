package serializers

import com.google.gson.JsonObject
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import domain.Ticket
import java.lang.reflect.Type

class TicketGsonSerializer implements JsonSerializer<Ticket> {

 
 override serialize(Ticket src, Type typeOfSrc,
            JsonSerializationContext context) {

        val obj = new JsonObject();
        obj.addProperty("flightId", src.flightId.toString);
        obj.addProperty("seatNumber", src.seatNumber);

        return obj;
    }
}