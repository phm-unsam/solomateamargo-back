package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

@Accessors
class Flight implements Entidad {
	String id
	@JsonIgnore String planeType
	@JsonIgnore List<Seat> seats = new ArrayList
	String from
	String to
	String airline
	int flightDuration
	String departure
	Double baseCost

	def flightCost(Seat seat) {
		getBaseCost + seatCost(seat)
	}

	def seatsAvailiables() {
		seats.filter(seat|seat.avaliable)
	}

	def seatCost(Seat seat) {
		twoOrLessSeatsAvaliable ? seat.getCost * 1.15 : seat.getCost
	}

	def twoOrLessSeatsAvaliable() {
		seatsAvailiables.size <= 2
	}

	@JsonProperty("stopoversAmount")
	def stopoversAmount() {
		0
	}

	def hasSeatsAvaliables() {
		seats.exists[it.isAvaliable]
	}

	def getSeatByNumber(String seatNumber) {
		val seat = seats.findFirst[it.number == seatNumber]
		if (seat === null)
			throw new NotFoundException("El asiento no existe en este vuelo")
		seat
	}
	
	def cheapestSeat(){
		seatsAvailiables.minBy[it.cost]
	}
	
	@JsonProperty("priceFrom")
	def priceFrom(){
		getBaseCost + cheapestSeat.cost
	}
	
}

@Accessors
class FlightWithStopover extends Flight {
	@JsonIgnore List<Flight> stopovers = new ArrayList

	override getBaseCost() {
		stopovers.fold(0.0, [baseCost, stopover|baseCost + stopover.baseCost]) * 0.90
	}

	override stopoversAmount() {
		stopovers.size
	}

	override getFlightDuration() {
		stopovers.fold(0, [totalDuration, stopover|totalDuration + stopover.flightDuration])
	}

}
