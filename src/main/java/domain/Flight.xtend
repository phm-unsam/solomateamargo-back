package domain

import java.time.LocalDateTime
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
	double flightDuration

	override getID() {
		flightId
	}
	
	
	override setID(String id) {
		flightId = id
	}
	
	def flightCost(Seat seat){
		getBaseCost + seatCost(seat)
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
	
	override getFlightDuration(){
		stopovers.fold(0.0,[totalDuration,stopover | totalDuration + stopover.flightDuration])
	}
	
	override getBaseCost()
	{
		baseCost*0.90
	}
	
}
