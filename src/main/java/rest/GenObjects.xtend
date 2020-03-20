package rest

import domain.Flight
import java.time.LocalDateTime
import domain.Seat

class GenObjects {

	def static addToRepo() {
		val repoFlight = FlightRepository.instance
		val repoSeat = SeatRepository.instance

		val economySeat = new Seat() => [
			nextoWindow = true
		]

		val businessSeat = new Seat() => [
			nextoWindow = true
			avaliable = true
		]

		val firstSeat = new Seat() => [
			nextoWindow = false
			avaliable = true
		]

		val vueloA = new Flight() => [
			from = "buenosAires"
			to = "salta"
			departure = LocalDateTime.of(2019, 11, 22, 12, 13)
			planeType = "barato"
			baseCost = 2.2
			setAirline("aerolineaArgentina")
			seats.add(economySeat)
			seats.add(businessSeat)
			seats.add(firstSeat)
		]
		val vueloB = new Flight() => [
			from = "buenosAires"
			to = "salta"
			departure = LocalDateTime.of(2019, 11, 22, 12, 13)
			planeType = "sds"
			baseCost = 222.2
			setAirline("aerolineaArgentina")
			seats.add(economySeat)
			seats.add(businessSeat)
		]
		val vueloC = new Flight() => [
			from = "buenosAires"
			to = "salta"
			departure = LocalDateTime.of(2019, 11, 22, 12, 13)
			planeType = "acs"
			baseCost = 23123.2
			setAirline("aerolineaArgentina")
			seats.add(firstSeat)
		]

		repoFlight => [
			create(vueloA)
			create(vueloB)
			create(vueloC)
		]

		repoSeat => [
			create(firstSeat)
			create(economySeat)
			create(businessSeat)
		]
	}

}
