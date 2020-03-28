package domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Purchase {
	Ticket ticket
	double cost
	LocalDate purchaseDate = LocalDate.now
	
	new(Ticket _ticket){
		ticket=_ticket
		cost=ticket.cost
	}
}