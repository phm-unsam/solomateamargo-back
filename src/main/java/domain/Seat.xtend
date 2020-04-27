package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
@Entity(name = "seats")
class Seat {
	@Id @GeneratedValue
	Long id
	@Column
	boolean nextoWindow
	@Column
	@JsonIgnore boolean available
	@Column
	double cost
	@Column
	String number
	@Column
	String type
	@Column(name = "flight_id", insertable = false, updatable = false)
 	Long flight_id;
	new(){}

	new(boolean _nextoWindow, boolean _available, double _cost, String _number, String _type) {
		nextoWindow = _nextoWindow
		available = _available
		cost = _cost
		number = _number
		type = _type

	}

	def reserve() {
		available
			? available = false
			: throw new BusinessException("El asiento ya esta reservado")

	}

}
