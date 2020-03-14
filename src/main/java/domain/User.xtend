package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class User {
	String name
	String lastName
	int age
	List <User>friends = new ArrayList()
	String username
	String password
	
}