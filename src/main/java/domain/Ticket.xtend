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

@Accessors
@Entity(name = "tickets")
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
	LocalDate purchaseDate

	new() {
	}

	new(Flight _flight, Seat _seat) {
		flight = _flight
		seat = _seat
	}

//reveer
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
			flight.id == other?.flight.id && seat.id == other?.seat.id
		} catch (ClassCastException e) {
			return false
		}
	}

}
