package repository

import com.mongodb.MongoClient
import domain.Flight
import java.util.List
import org.bson.types.ObjectId
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.Query
import serializers.NotFoundException

abstract class MongoPersistantRepo<T>{
	static protected Datastore ds
	static Morphia morphia
	
	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				ds = createDatastore(mongo, "aterrizapp")
				ds.ensureIndexes
			]
		}
	}
	

	def T searchById(ObjectId id)

	def T create(T t) {
		ds.save(t)
		t
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	def validateQuery(Query<Flight> query, String msg) {
		if(query.asList.empty)
			throw new NotFoundException(msg)
	}
	

	abstract def Class<T> getEntityType()
	
}