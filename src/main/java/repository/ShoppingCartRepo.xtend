package repository

import domain.ShoppingCart
import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors

class ShoppingCartRepo {
	@Accessors protected HashMap<String,ShoppingCart> elements = new HashMap<String,ShoppingCart>
	private new() {
	}

	static ShoppingCartRepo instance

	static def getInstance() {
		if (instance === null) {
			instance = new ShoppingCartRepo()
		}
		instance
	}

	def void create(String userId) {
		elements.put(userId,new ShoppingCart())
	}

	def getCartByKey(String userId) {
		elements.get(userId)
	}


}
