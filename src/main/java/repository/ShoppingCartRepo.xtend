package repository

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import domain.Ticket
import java.lang.reflect.Type
import java.util.ArrayList
import java.util.List
import redis.clients.jedis.Jedis

class ShoppingCartRepo {
	Jedis jedis = new Jedis("localhost")

	static ShoppingCartRepo instance

	static def getInstance() {
		if (instance === null) {
			instance = new ShoppingCartRepo()
		}
		instance
	}

	def update(String id, List<Ticket> tickets) {
//		val gson = new GsonBuilder()
//			.excludeFieldsWithoutExposeAnnotation
//			.create
		val jsonTickets = new Gson().toJson(tickets);
		jedis.set(id, jsonTickets)
		jedis.expire(id, 180)
	}

	def clearCart(String id) {
		jedis.del(id)
	}

	def getItemsByKey(String userId) {
		val jsonTikcets = jedis.get(userId)
		
		if (jsonTikcets.isNullOrEmpty)
			return new ArrayList<Ticket>
			
		val Type listType = new TypeToken<ArrayList<Ticket>>() {
		}.getType();
		new Gson().fromJson(jsonTikcets, listType);
	}

}
