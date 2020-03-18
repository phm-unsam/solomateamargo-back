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
class Flight implements Entidad{
	Route route
	String planeType
	List<Seat> seats = new ArrayList
	Double baseCost
	Airline airline
	String flightId

	override getID() {
		flightId
	}
	
	
	override setID(String id) {
		flightId = id
	}
	
	def getSeatsAvaliable() {
		seats.filter(seat|seat.avaliable)
	}
	
	def seatCost(Seat seat){
		twoOrLessSeatsAvaliable ? seat.getCost * 1.15 : seat.getCost
	}
	
	def twoOrLessSeatsAvaliable(){
		getSeatsAvaliable.size<=2
	}

	def getFlightDuration() {
		route.travelDuration
	}
	
	def stopoversAmount(){
		0
	}
	
	def from(){
		route.from
	}
	
	def to(){
		route.to
	}
	
	def airportName(){
		airline.name
	}
}

@Accessors
class FlightWithStopover extends Flight {
	List<Route> stopovers = new ArrayList

	override stopoversAmount(){
		stopovers.size
	}
	override getBaseCost()
	{
		baseCost*0.90
	}
	override getFlightDuration() {
		ChronoUnit.HOURS.between(getMinimalDeparture, getMaximalArrival)
	}
	
	def getMinimalDeparture(){
		stopovers.fold(LocalDateTime.MAX,[minDate , stopover| minDate < stopover.departure ? minDate :stopover.departure])
	}
	
	def getMaximalArrival(){
		stopovers.fold(LocalDateTime.MIN,[maxDate , stopover| maxDate > stopover.arrival ? maxDate :stopover.arrival])
	}
	
}
