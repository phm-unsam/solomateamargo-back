package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Ticket {
	Flight flight
	Seat seat

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}

	def cost() {
		flight.flightCost(seat)
	}

	def reserve() {
		seat.reserve()
	}

}
