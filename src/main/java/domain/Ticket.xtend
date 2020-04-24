package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.Parse

@Accessors
@Entity
class Ticket{
	@Id @GeneratedValue
	Long id
	@ManyToOne
	Flight flight
	@OneToOne(cascade=CascadeType.MERGE)
	Seat seat
	@Column
	@JsonIgnore double finalCost
	@Column
	String purchaseDate
	
	new(){}

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}
//reveer
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
		seat.avaliable=false
	}

}
