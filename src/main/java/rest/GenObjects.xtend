package rest

import domain.Flight
import domain.Route
import java.time.LocalDateTime
import domain.Airline
import domain.First
import domain.Business
import domain.Economy
import domain.Seat

class GenObjects {

	def static addToRepo() {
		val repoFlight = FlightRepository.instance
		val repoSeat =  SeatRepository.instance

		val rutaArgentina = new Route() => [
			from = "buenosAires"
			to = "salta"
			departure = LocalDateTime.of(2019, 11, 22, 12, 13)
			arrival = LocalDateTime.of(2019, 11, 24, 12, 13)
		]

		val aerolineaArgentina = new Airline() => [
			name = "argentina"
			baseCost = 2.2
		]

		val first = new First() => [
			setPrice(20.0)
		]

		val business = new Business() => [
			setPrice(40.0)
		]

		val economy = new Economy() => [
			setPrice(80.0)
		]

		val economySeat = new Seat() => [
			setType(economy)
			nextoWindow = true
		]

		val businessSeat = new Seat() => [
			setType(business)
			nextoWindow = true
			avaliable = true
		]

		val firstSeat = new Seat() => [
			setType(first)
			nextoWindow = false
			avaliable = true
		]

		val vueloA = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "barato"
			baseCost = 2.2
			setAirline(aerolineaArgentina)
			addSeat(economySeat)
			addSeat(businessSeat)
			addSeat(firstSeat)
		]
		val vueloB = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "sds"
			baseCost = 222.2
			setAirline(aerolineaArgentina)
			addSeat(economySeat)
			addSeat(businessSeat)
		]
		val vueloC = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "acs"
			baseCost = 23123.2
			setAirline(aerolineaArgentina)
			addSeat(firstSeat)
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
