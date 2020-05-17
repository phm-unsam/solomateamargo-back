package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.ArrayList
import java.util.Date
import java.util.List
import java.util.Set
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import serializers.NotFoundException

@Accessors
@Entity(value="Flights", noClassnameStored=true)
class Flight{
	@Id ObjectId id
	@JsonIgnore String planeType
	@Embedded
	@JsonIgnore Set<Seat> seats = newHashSet
	String destinationFrom
	String destinationTo
	String airline
	int flightDuration
	//@JsonSerialize(using = LocalDateSerializer)  
	Date departure
	Double baseCost
	Double priceFrom

	def flightCost(Seat seat) {
		baseCost + seatCost(seat)
	}

	def seatsAvailiables() {
		seats.filter(seat|seat.available)
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
		seats.exists[it.isAvailable]
	}

	def getSeatById(String seatNumber) {
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
		flightCost(cheapestSeat)
	}
	
	def seatByNumber(String number){
		seats.findFirst[it.number == number]
	}
	
}
 
@Accessors
class FlightWithStopover extends Flight {
	@Embedded
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
