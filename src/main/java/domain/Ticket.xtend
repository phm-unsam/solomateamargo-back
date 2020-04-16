package domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.Parse

@Accessors
class Ticket implements Entidad{
	String id
	Flight flight
	Seat seat
	double finalCost
	String purchaseDate

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}

	def cost() {
		flight.flightCost(seat)
	}

	def buyTicket() {
		purchaseDate = Parse.getStringDateFromLocalDate(LocalDate.now)
		finalCost = cost() 
		seat.reserve()
	}

}
