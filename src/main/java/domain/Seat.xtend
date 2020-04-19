package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
@Entity
class Seat {
	@Id @GeneratedValue
	Long id
	@Column
	boolean nextoWindow
	@Column
	@JsonIgnore boolean avaliable
	@Column
	double cost
	@Column
	String number
	@Column
	String type

	new(boolean _nextoWindow, boolean _avaliable, double _cost, String _number, String _type) {
		nextoWindow = _nextoWindow
		avaliable = _avaliable
		cost = _cost
		number = _number
		type = _type

	}

	def reserve() {
		avaliable
			? avaliable = false
			: throw new BusinessException("El asiento ya esta reservado")

	}

}
