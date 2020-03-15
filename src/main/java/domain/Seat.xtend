package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Seat {
	SeatType type
	boolean nextoWindow
	boolean avaliable
	
	
	def price(){
		type.price
	}
	
	def cost() {
		0
	}
	
}