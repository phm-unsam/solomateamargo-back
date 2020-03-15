package domain


interface SeatType {

	def Double price()
	
	def String typeName() 
	
}

class FirstClass implements SeatType{
	
	override price(){
		0.0
	}
	
	override typeName(){
		"First"
	}
}