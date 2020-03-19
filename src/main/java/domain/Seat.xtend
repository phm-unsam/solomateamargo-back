package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Seat implements Entidad{
	SeatType type
	boolean nextoWindow
	boolean avaliable
	String typeSeatId
	String seatId
	def getCost(){
		type.price
	}
	
	override getID() {
		seatId
	}
	
	override setID(String id) {
		seatId = type.getId() +  id
	}
	
	
	
	
}