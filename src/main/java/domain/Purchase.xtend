package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Purchase {
	Ticket ticket
	double cost
}