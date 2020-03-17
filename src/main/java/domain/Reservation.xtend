package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Reservation {
	Flight flight
	Seat seat
	
	def totalCost(){
		flight.getBaseCost + flight.seatCost(seat)
	}
}