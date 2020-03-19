package domain

import org.eclipse.xtend.lib.annotations.Accessors

interface SeatType {

	def Double price()

	def String typeName()

	def String getId()

}

@Accessors
class First implements SeatType {
	Double price

	override price() {
	}

	override typeName() {
		"First"
	}

	override getId() {
		"F"
	}

}

@Accessors
class Business implements SeatType {
	Double price

	override price() {
	}

	override typeName() {
		"Businnes"
	}

	override getId() {
		"B"
	}

}

@Accessors
class Economy implements SeatType {
	Double price

	override price() {
	}

	override typeName() {
		"Economy"
	}

	override getId() {
		"E"
	}

}
