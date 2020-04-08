package domain

import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

@Accessors
class Flight implements Entidad {
	String planeType
	List<Seat> seats = new ArrayList
	Double baseCost
	String airline
	String from
	String to
	String id
	LocalDate departure
	int flightDuration

	def flightCost(Seat seat) {
		getBaseCost + seatCost(seat)
	}

	def getSeatsAvailiables() {
		seats.filter(seat|seat.avaliable)
	}

	def seatCost(Seat seat) {
		twoOrLessSeatsAvaliable ? seat.getCost * 1.15 : seat.getCost
	}

	def twoOrLessSeatsAvaliable() {
		getSeatsAvailiables.size <= 2
	}

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
}

@Accessors
class FlightWithStopover extends Flight {
	List<Flight> stopovers = new ArrayList

	override stopoversAmount() {
		stopovers.size 
	}

	override getFlightDuration() {
		stopovers.fold(0, [totalDuration, stopover|totalDuration + stopover.flightDuration])
	}

	override getBaseCost() {
		stopovers.fold(0.0, [baseCost, stopover|baseCost + stopover.baseCost]) * 0.90
	}

}
