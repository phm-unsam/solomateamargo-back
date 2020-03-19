package domain

import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Flight implements Entidad{
	String planeType
	List<Seat> seats = new ArrayList
	Double baseCost
	String airline
	String flightId
	String from
	String to
	LocalDateTime departure
	LocalDateTime arrival

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
		ChronoUnit.HOURS.between(departure, arrival)
	}
	
	def stopoversAmount(){
		0
	}
	
}

@Accessors
class FlightWithStopover extends Flight {
	List<Flight> stopovers = new ArrayList

	override stopoversAmount(){
		stopovers.size
	}
	
	override getBaseCost()
	{
		baseCost*0.90
	}
	
}
