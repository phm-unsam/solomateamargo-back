package domain

import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Route {
	String from
	String to
	LocalDateTime departure
	LocalDateTime arrival

	def travelDuration() {
		ChronoUnit.HOURS.between(departure, arrival)
	}
}

@Accessors
class Flight {
	Route route
	String planeType
	List<Seat> seats = new ArrayList
	Double baseCost

	def seatsAvaliable() {
		seats.filter(seat|seat.avaliable)
	}

	def cost() {
		0.0
	}

	def getFlightDuration() {
		route.travelDuration
	}

}

@Accessors
class FlightWithStopover extends Flight {
	List<Route> stopovers = new ArrayList

	override cost() {
		baseCost * 0.90
	}

	override getFlightDuration() {
		stopovers.fold(0.0, [total, route|total + route.flightDuration])
	}

}
