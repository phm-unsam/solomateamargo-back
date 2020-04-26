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
class Ticket {
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

	new() {
	}

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}

//reveer
	def getCost() {
		purchaseDate.isNullOrEmpty
			? calculateFlightCost
			: finalCost
	}

	def calculateFlightCost() {
		flight.flightCost(seat)
	}

	def buyTicket() {
		finalCost = calculateFlightCost
		purchaseDate = Parse.getStringDateFromLocalDate(LocalDate.now)
		id = null
		seat.reserve
	}

	override equals(Object obj) {
		try {
			val other = obj as User
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}

	override hashCode() {
		if(id !== null) id.hashCode else super.hashCode
	}

}
