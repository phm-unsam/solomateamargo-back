package domain


interface SeatType {

	def Double price()
	
	def String typeName() 
	
}

class First implements SeatType{
	
	override price(){
		0.0
	}
	
	override typeName(){
		"First"
	}
}

class Business implements SeatType{
	
	override price() {
	}
	
	override typeName() {
	}
	
}

class Economy implements SeatType{
	
	override price() {
	}
	
	override typeName() {
	}
	
}