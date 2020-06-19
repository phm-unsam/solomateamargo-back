package domain

import com.google.gson.annotations.Expose
import java.util.Calendar
import java.util.Date
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
	@Id @GeneratedValue @Expose
	Long id
	@Transient
	Flight flight
	@Transient 
	Seat seat
	@Column
	double finalCost
	@Column 
	Date purchaseDate
	@Column @Expose
	ObjectId flightId
	@Column @Expose
	String seatNumber


	new() {
	}
	
	def popularData(){
		flight = FlightRepository.getInstance.searchById(flightId)
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
		validate()
		id=null
		finalCost = calculateFlightCost
		purchaseDate = Calendar.getInstance().getTime()
		seat.available = false
		println("compra")
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
