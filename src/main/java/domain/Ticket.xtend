package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.Parse

@Accessors
class Ticket implements Entidad{
	String id
	Flight flight
	Seat seat
	@JsonIgnore double finalCost
	String purchaseDate

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}

	def getCost() {
		purchaseDate.isNullOrEmpty ?
		calculateFlightCost:
		finalCost
	}
	
	def calculateFlightCost(){
		flight.flightCost(seat)
	}

	def buyTicket() {
		finalCost = calculateFlightCost
		purchaseDate = Parse.getStringDateFromLocalDate(LocalDate.now)
		seat.reserve()
	}

}
