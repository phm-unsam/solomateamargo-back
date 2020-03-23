package app

import controllers.FlightController
import controllers.UserController
import org.uqbar.xtrest.api.XTRest

class Aterrizapp {
	def static void main(String[] args) {
		GenObjects.generateAll
		XTRest.startInstance(
			16000,
			new FlightController(),
			new UserController()
		)

	}
}
