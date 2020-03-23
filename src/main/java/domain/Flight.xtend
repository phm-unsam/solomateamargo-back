package domain

import java.time.LocalDateTime
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

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
	int flightDuration

	override getID() {
		flightId
	}
	
	
	override setID(String id) {
		flightId = id
	}
	
	def flightCost(Seat seat){
		getBaseCost + seatCost(seat)
	}
	
	def getSeatsAvailiables() {
		val results = seats.filter(seat|seat.avaliable)
		if(results.empty){
			throw new NotFoundException("No hay asientos disponibles")
		}
		results
	}
	
	def seatCost(Seat seat){
		twoOrLessSeatsAvaliable ? seat.getCost * 1.15 : seat.getCost
	}
	
	def twoOrLessSeatsAvaliable(){
		getSeatsAvailiables.size<=2
	}
	
	def stopoversAmount(){
		0
	}
	
	def hasSeatsAvaliables(){
		val result = seats.exists(seat|seat.isAvaliable)
		if (!result)
			throw new NotFoundException("Este vuelo no tiene asientos disponibles")
		result
	}
}

@Accessors
class FlightWithStopover extends Flight {
	List<Flight> stopovers = new ArrayList

	override stopoversAmount(){
		stopovers.size - 1
	}
	
	override getFlightDuration(){
		stopovers.fold(0,[totalDuration,stopover | totalDuration + stopover.flightDuration])
	}
	
	override getBaseCost()
	{
		stopovers.fold(0.0,[baseCost, stopover | baseCost + stopover.baseCost]) *0.90
	}
	
}
