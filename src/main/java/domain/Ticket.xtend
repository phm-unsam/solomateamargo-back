package domain

class Ticket {
	Flight flight
	Seat seat
	
	def cost(){
		flight.flightCost(seat)
	}
}