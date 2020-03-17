package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class User implements Entidad{
	String name
	String lastName
	int age
	List <User> friends = new ArrayList()
	String username
	String password
	String userId
	
	override getID() {
		userId
	}
	
	override setID(String id) {
		userId = id
	}
	
}