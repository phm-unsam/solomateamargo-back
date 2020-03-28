package domain

import org.eclipse.xtend.lib.annotations.Accessors
import serializers.BusinessException

@Accessors
class Seat {
	boolean nextoWindow
	boolean avaliable
	double cost
	String number
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

	def quitReservation() {
		avaliable
			? throw new BusinessException("El asiento no esta reservado")
			: avaliable = true
	}

}
