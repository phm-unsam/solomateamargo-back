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
import serializers.BusinessException

@Accessors
@Entity(name="tickets")
class Ticket {
	@Id @GeneratedValue
	Long id
	@Transient
	Flight flight
	@Transient
	Seat seat
	@Transient
	FlightRepository flightRepo = FlightRepository.getInstance
	@Column
	@JsonIgnore double finalCost
	@Column
	LocalDate purchaseDate
	@Column
	ObjectId flightId
	@Column
	String seatNumber


	new() {
	}
	
	def popularData(){
		flight = flightRepo.searchById(flightId)
		seat = flight.seatByNumber(seatNumber)
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
		popularData()
		validate()
		id=null
		finalCost = calculateFlightCost
		purchaseDate = LocalDate.now
		seat.reserve
		flightRepo.update(flight)
	}

	def validate() {
		if (!getSeat.available)
			throw new BusinessException("El asiento del ticket " + id + " esta ocupado")
	}

	override equals(Object obj) {
		try {
			val other = obj as Ticket
			flightId == other?.flightId && seatNumber == other?.seatNumber
		} catch (ClassCastException e) {
			return false
		}
	}

}
