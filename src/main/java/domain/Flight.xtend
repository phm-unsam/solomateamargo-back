package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.ArrayList
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.NotFoundException

@Accessors
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)

class Flight{
	@Id @GeneratedValue
	Long id
	@Column
	@JsonIgnore String planeType
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JsonIgnore Set<Seat> seats = newHashSet
	@Column
	String destinationFrom
	@Column
	String destinationTo
	@Column
	String airline
	@Column
	int flightDuration
	@Column
	String departure
	@Column
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
		flightCost(cheapestSeat)
	}
	
}
 
@Entity
@Accessors
class FlightWithStopover extends Flight {
	@OneToMany(fetch=FetchType.LAZY)
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
