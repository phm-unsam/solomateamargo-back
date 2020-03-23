package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Seat{
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

}
