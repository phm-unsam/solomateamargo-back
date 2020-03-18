package rest

import org.uqbar.xtrest.api.XTRest

class FlightApp {
	def static void main(String[] args) {
		GenObjects.addToRepo
		XTRest.startInstance (16000,
			new FlightController()
		)
		
	}}