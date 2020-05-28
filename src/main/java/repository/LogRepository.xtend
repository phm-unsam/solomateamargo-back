package repository

import domain.FlightFilter
import org.bson.types.ObjectId

class LogRepository extends MongoPersistantRepo<FlightFilter>{
	
	static LogRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new LogRepository()
		}
		instance
	}

	override getEntityType() { FlightFilter }
	
	override searchById(ObjectId id) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override create(FlightFilter filter){
		if(filter.hasDataToFilter){
			ds.save(filter)
			filter
		}
	}
}