package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Transient
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import repository.FlightRepository

@Accessors
@Entity(name="tickets")
class Ticket {
	@Id @GeneratedValue
	Long id
	@Transient
	Flight flight
	@Transient
	FlightRepository flightRepo
	@Column
	@JsonIgnore double finalCost
	@Column
	LocalDate purchaseDate
	@Column
	ObjectId flightId
	@Column
	String seatNumber

	def Flight getFlight() {
		println("concha de la lora "+flightId)
			flight = flightRepo.searchById(flightId)
		flight
	}

	def getSeat() {
		getFlight.seatByNumber(seatNumber)
	}

	new() {
	}

	new(Flight _flight, Seat _seat) {
		flightId = _flight.id
		seatNumber = _seat.number
	}

	def getCost() {
		purchaseDate === null ? calculateFlightCost : finalCost
	}

	def calculateFlightCost() {
		getFlight.flightCost(getSeat)
	}

	def buyTicket() {
		finalCost = calculateFlightCost
		purchaseDate = LocalDate.now
		id = null
		//getSeat.reserve
		//flightRepo.update(flight)
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
