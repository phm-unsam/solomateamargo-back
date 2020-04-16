package tests

import app.GenObjects
import domain.Flight
import domain.User
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repository.FlightRepository
import repository.UserRepository
import domain.Seat
import domain.Ticket

class PurchaseTest {
	
	UserRepository userRepository = UserRepository.getInstance
	FlightRepository flightRepository = FlightRepository.getInstance
	User user
	Flight flight
	Seat seat
	
	@Before
	def void init() {
		GenObjects.generateAll
		user = userRepository.searchByID("1")
		flight = flightRepository.searchByID("1")
		seat = flight.seatsAvailiables.get(0)
	}
	
	@Test
	def void teste(){
		val totalPurchases = user.purchases.size
		val Ticket ticket = new Ticket(flight,seat)
		user.addTicketToCart(ticket)
		user.purchaseCartTickets()
		Assert.assertEquals(totalPurchases+1, user.purchases.size , 0.1)
	}
}