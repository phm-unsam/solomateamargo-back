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
import javax.persistence.Transient
import org.bson.types.ObjectId

@Accessors
@Entity(name = "tickets")
class Ticket {
	@Id @GeneratedValue
	Long id
	@Transient
	Flight flight
	@Transient
	Seat seat
	@Column
	@JsonIgnore double finalCost
	@Column
	LocalDate purchaseDate
	@Column
	ObjectId flightId
	@Column
	String seatId
	
	new() {
	}

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
		flightId = _flight.id
		seatId = _seat.number
	}

	def getCost() {
		purchaseDate === null
			? calculateFlightCost
			: finalCost
	}

	def calculateFlightCost() {
		flight.flightCost(seat)
	}

	def buyTicket() {
		finalCost = calculateFlightCost
		purchaseDate = LocalDate.now
		id = null
		seat.reserve
	}

	override equals(Object obj) {
		try {
			val other = obj as Ticket
			flight.id == other?.flight.id && seat.number == other?.seat.number
		} catch (ClassCastException e) {
			return false
		}
	}

}
