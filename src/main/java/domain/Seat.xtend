package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Seat implements Entidad{
	boolean nextoWindow
	boolean avaliable
	double cost
	String number
	String type
	String seatId
	
	override getID() {
		seatId
	}
	
	override setID(String id) {
		seatId = id
	}
	
	
	
	
}