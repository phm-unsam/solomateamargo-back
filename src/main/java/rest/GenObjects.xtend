package rest

import domain.Flight
import domain.Route
import java.time.LocalDateTime
import domain.Airline

class GenObjects {
	
	def static addToRepo() {
		val repo = FlightRepository.instance
		
		val rutaArgentina = new Route() => [
			from = "buenosAires"
			to = "salta"
			departure = LocalDateTime.of(2019,11,22, 12, 13)
			arrival = LocalDateTime.of(2019,11,24, 12, 13)
		]
		
		val aerolineaArgentina = new Airline() => [
			name="argentina"
			baseCost = 2.2
		]
		

		val vueloA = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "barato"
			baseCost = 2.2
			setAirline(aerolineaArgentina)
		]
		val vueloB = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "sds"
			baseCost = 222.2
			setAirline(aerolineaArgentina)
		] 
		val vueloC = new Flight() => [
			setRoute(rutaArgentina)
			planeType = "acs"
			baseCost = 23123.2
			setAirline(aerolineaArgentina)
		]   
		
		repo =>[
			create(vueloA)
			create(vueloB)
			create(vueloC)
		]
	}

}