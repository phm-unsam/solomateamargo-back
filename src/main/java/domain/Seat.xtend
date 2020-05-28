package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
class Seat {
	boolean nextoWindow
	@JsonIgnore boolean available
	double cost
	String number
	String type
	
	new(){}

	new(boolean _nextoWindow, boolean _available, double _cost, String _number, String _type) {
		nextoWindow = _nextoWindow
		available = _available
		cost = _cost
		number = _number
		type = _type

	}
	
	def validate(){
		if(!available)
			throw new BusinessException("El asiento ya esta reservado")
	}

	def reserve() {
		validate()
		available = false

	}

}
