package domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.Parse

@Accessors
class Purchase {
	Ticket ticket
	double cost
	String purchaseDate = Parse.getStringDateFromLocalDate(LocalDate.now)
	
	new(Ticket _ticket){
		ticket=_ticket
		cost=ticket.cost
	}
}