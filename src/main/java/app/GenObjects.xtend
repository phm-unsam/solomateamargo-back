package app

import domain.Flight
import domain.Seat
import domain.Ticket
import domain.User
import java.time.LocalDate
import repository.FlightRepository
import repository.UserRepository

class GenObjects {

	def static generateAll() {
		val repoFlight = FlightRepository.getInstance
		val repoUser = UserRepository.getInstance

		/*
		 |------------------------------------------------------------------|
		 | 					CREATING SEATS ...								|
		 |------------------------------------------------------------------|  
		 */
		 
		val seat11 = new Seat(false, true, 1000, "E10", "Economy")
		val seat12 = new Seat(false, true, 3000, "B10", "Business")
		val seat13 = new Seat(true, true, 5000, "F10", "First")
		val seat14 = new Seat(true, true, 5000, "F11", "First")
		val seat15 = new Seat(true, true, 5000, "F12", "First")

		val seat21 = new Seat(true, true, 3000, "E10", "Economy")
		val seat22 = new Seat(true, true, 4000, "B10", "Business")
		val seat23 = new Seat(false, true, 7000, "F10", "First")
		val seat24 = new Seat(true, true, 4000, "B11", "Business")
		val seat25 = new Seat(true, true, 4000, "B12", "Business")

		val seat31 = new Seat(true, true, 1300, "E10", "Economy")
		val seat32 = new Seat(false, true, 3800, "B10", "Business")
		val seat33 = new Seat(true, true, 6500, "F10", "First")
		val seat34 = new Seat(false, true, 3800, "B11", "Business")
		val seat35 = new Seat(false, true, 3800, "B12", "Business")

		val seat41 = new Seat(false, true, 2200, "E10", "Economy")
		val seat42 = new Seat(true, true, 4110, "B10", "Business")
		val seat43 = new Seat(false, true, 9810, "F10", "First")
		val seat44 = new Seat(false, true, 2200, "E11", "Economy")
		val seat45 = new Seat(false, true, 2200, "E12", "Economy")

		val seat51 = new Seat(true, true, 1590, "E10", "Economy")
		val seat52 = new Seat(false, true, 3800, "B10", "Business")
		val seat53 = new Seat(true, true, 5800, "F10", "First")
		val seat54 = new Seat(true, true, 1590, "E11", "Economy")
		val seat55 = new Seat(false, true, 3800, "B12", "Business")

		val seat61 = new Seat(true, true, 9000, "E10", "Economy")
		val seat62 = new Seat(true, true, 12000, "B10", "Business")
		val seat63 = new Seat(false, true, 15300, "F10", "First")

		val seat71 = new Seat(false, true, 1200, "E10", "Economy")
		val seat72 = new Seat(false, true, 3700, "B10", "Business")
		val seat73 = new Seat(true, true, 6900, "F10", "First")

		val seat81 = new Seat(true, true, 10000, "E10", "Economy")
		val seat82 = new Seat(true, true, 13900, "B10", "Business")
		val seat83 = new Seat(true, true, 15760, "F10", "First")

		/*
		 |--------------------------------------------------------------------------|
		 | 					CREATING FLIGHT DATA ...								|
		 |--------------------------------------------------------------------------|
		 */
		 
		val vuelo1 = new Flight() => [
			destinationFrom = "Buenos Aires"
			destinationTo = "Salta"
			departure = LocalDate.parse("2020-05-22")
			planeType = "Embraer 190"
			baseCost = 5000.0
			flightDuration = 3
			setAirline("Aerolineas Argentinas")
			seats => [
				add(seat11)
				add(seat12)
				add(seat13)
				add(seat14)
				add(seat15)
			]
		]

		val vuelo2 = new Flight() => [
			destinationFrom = "Buenos Aires"
			destinationTo = "Bariloche"
			departure = LocalDate.parse("2020-07-11")
			planeType = "Avioneta"
			baseCost = 3000.0
			flightDuration = 4
			setAirline("Fly Bondi")
			seats => [
				add(seat21)
				add(seat22)
				add(seat23)
				add(seat24)
				add(seat25)
			]
		]

		val vuelo3 = new Flight() => [
			destinationFrom = "Buenos Aires"
			destinationTo = "Montevideo"
			flightDuration = 1
			departure = LocalDate.parse("2020-11-22")
			planeType = "Boeing 737 MAX"
			baseCost = 23123.2
			setAirline("Aerolineas Argentinas")
			seats => [
				add(seat31)
				add(seat32)
				add(seat33)
				add(seat34)
				add(seat35)
			]
		]
		val vuelo4 = new Flight() => [
			destinationFrom = "Buenos Aires"
			destinationTo = "Comodoro Rivadavia"
			flightDuration = 5
			departure = LocalDate.parse("2020-09-22")
			planeType = "Airbus 340"
			baseCost = 7000.0
			setAirline("Aerolineas Argentinas")
			seats => [
				add(seat41)
				add(seat42)
				add(seat43)
				add(seat44)
				add(seat45)
			]
		]
		val vuelo5 = new Flight() => [
			destinationFrom = "Cordoba"
			destinationTo = "Mendoza"
			flightDuration = 2
			departure = LocalDate.parse("2020-01-30")
			planeType = "Airbus 300"
			baseCost = 3000.0
			setAirline("Norwegian")
			seats => [
				add(seat51)
				add(seat52)
				add(seat53)
				add(seat54)
				add(seat55)
			]
		]
		val vuelo6 = new Flight() => [
			destinationFrom = "Rio de janeiro"
			destinationTo = "Panama"
			flightDuration = 7
			departure = LocalDate.parse("2020-11-11")
			planeType = "Boeing 747"
			baseCost = 10000.0
			setAirline("American Airlines")
			seats => [
				add(seat61)
				add(seat62)
				add(seat63)
			]
		]
		val vuelo7 = new Flight() => [
			destinationFrom = "Panama"
			destinationTo = "Los Angeles"
			flightDuration = 9
			departure = LocalDate.parse("2021-01-14")
			planeType = "Boeing 747"
			baseCost = 14000.0
			setAirline("American Airlines")
			seats => [
				add(seat71)
				add(seat72)
				add(seat73)
			]
		]
		/*val vuelo8 = new FlightWithStopover() => [
			destinationFrom = "Rio de janeiro"
			destinationTo = "Los Angeles"
			departure = "16/03/2021"
			planeType = "Boeing 747"
			stopovers => [
				add(vuelo6)
				add(vuelo7)
			]
			setAirline("American Airlines")
			seats => [
				add(seat81)
				add(seat82)
				add(seat83)
			]
		]*/

		repoFlight => [
			create(vuelo1)
			create(vuelo2)
			create(vuelo3)
			create(vuelo4)
			create(vuelo5)
			create(vuelo6)
			create(vuelo7)
			//create(vuelo8)
			
		]

		/*
		 |--------------------------------------------------------------------------|
		 | 					CREATING USER DATA ...			    					|
		 |--------------------------------------------------------------------------|
		 */
		 
		val userA = new User() => [
			name = "Ricardo"
			lastName = "Gutierrez"
			age = 45
			username = "ricardito"
			password = "hinchadeboca"
			profilePhoto = "https://cdn.tn.com.ar/sites/default/files/styles/720x720/public/2018/12/09/schelotto-cara.jpg"
		]

		val userB = new User() => [
			name = "Julian"
			lastName = "Ramirez"
			age = 18
			username = "julian999"
			password = "asd"
			profilePhoto = "https://images.clarin.com/2019/12/12/leo-messi-con-su-sexto___1DhrtHL0_1256x620__1.jpg"
		]

		val userC = new User() => [
			name = "Benjamin"
			lastName = "Salinas"
			age = 22
			username = "benjaxxx"
			password = "tequiero"
			profilePhoto = "https://ep01.epimg.net/deportes/imagenes/2019/10/10/actualidad/1570703137_141070_1570812202_noticia_normal.jpg"
			friends.add(userA)
		]
		val userD = new User() => [
			name = "Florencia"
			lastName = "Perez"
			age = 26
			username = "flochu"
			password = "123"
			profilePhoto = "https://i.pinimg.com/564x/c2/3b/5b/c23b5b9447cbf0c540f38df399f4c2bd.jpg"
		]

		val userE = new User() => [
			name = "Juana"
			lastName = "Lopez"
			age = 21
			username = "juanita"
			password = "123"
			profilePhoto = "https://mott.pe/noticias/wp-content/uploads/2018/03/10-trucos-para-saber-c%C3%B3mo-tomar-fotos-profesionales-con-el-celular-portada.jpg"
			friends => [
				add(userA)
				add(userB)
			]
		]

		repoUser => [create(userA) create(userB) create(userC) create(userD) create(userE)]

		/* 
		 |---------------------------------------------------------------------------|
		 | 					BUYING TICKETS ...										 |
		 |---------------------------------------------------------------------------|*/
		 
//-----USER A----		
		var ticket = new Ticket(vuelo1, seat15)
		ticket.buyTicket
		userA.purchases.add(ticket)

		ticket = new Ticket(vuelo2, seat24)
		ticket.buyTicket
		userA.purchases.add(ticket)
//-----USER B----
		ticket = new Ticket(vuelo1, seat14)
		ticket.buyTicket
		userB.purchases.add(ticket)

		ticket = new Ticket(vuelo3, seat34)
		ticket.buyTicket
		userB.purchases.add(ticket)
//-----USER C----
		ticket = new Ticket(vuelo2, seat25)
		ticket.buyTicket
		userC.purchases.add(ticket)

		ticket = new Ticket(vuelo4, seat44)
		ticket.buyTicket
		userC.purchases.add(ticket)
//-----USER D----
		ticket = new Ticket(vuelo3, seat35)
		ticket.buyTicket
		userD.purchases.add(ticket)

		ticket = new Ticket(vuelo5, seat55)
		ticket.buyTicket
		userD.purchases.add(ticket)
//-----USER E----
		ticket = new Ticket(vuelo4, seat45)
		ticket.buyTicket
		userE.purchases.add(ticket)

		ticket = new Ticket(vuelo5, seat54)
		ticket.buyTicket
		userE.purchases.add(ticket)

		repoUser => [
			update(userA)
			update(userB)
			update(userC)
			update(userD)
			update(userE)

		]

	}
}
