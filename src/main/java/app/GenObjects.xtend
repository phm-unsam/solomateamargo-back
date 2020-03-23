package app

import domain.Flight
import domain.Seat
import domain.User
import java.time.LocalDateTime
import repository.FlightRepository
import repository.UserRepository

class GenObjects {

	def static addToRepo() {
		val repoFlight = FlightRepository.instance	
		val repoUser = UserRepository.instance	
		
/*
|---------------------------------------------------------------------------|
| 					CREATING FLIGHT DATA ...								|
|--------------------------------------------------------------------------*/

		val economySeat = new Seat() => [
			type = "Economy"
			nextoWindow = true
			avaliable = true
			cost = 1000
			number = "A25"
		]

		val businessSeat = new Seat() => [
			type = "Business"
			nextoWindow = true
			avaliable = true
			cost = 2000
			number = "A10"
		]

		val firstSeat = new Seat() => [
			type = "First"
			nextoWindow = false
			avaliable = true
			cost = 5000
			number = "A1"
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
		
	/*
	|---------------------------------------------------------------------------|
	| 					CREATING USER DATA ...			    					|
	|--------------------------------------------------------------------------*/
	
	
		val userA = new User() => [
			name = "Ricardo"
			lastName = "Gutierrez"
			age = 55
			username = "ricardito"
			password = "hinchadeboca" 
		]
	
		val userB = new User() => [
			name = "Julian"
			lastName = "Ramirez"
			age = 18
			username = "julian999"
			password = "asdasd" 
		]
		
		val userC = new User() => [
			name = "Benjamin"
			lastName = "Salinas"
			age = 22
			username = "benjaxxx"
			password = "tequiero" 
		]
		
		repoUser => [
			create(userA)
			create(userB)
			create(userC)
		]
	
	}

}
