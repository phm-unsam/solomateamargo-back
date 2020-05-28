package repository

import domain.User
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

class UserRepository extends PersistantRepo<User> {

	private new() {
	}

	static UserRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new UserRepository()
		}
		instance
	}

	override getEntityType() {
		User
	}

	def login(User userToLog) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("username"), userToLog.username),
					criteria.equal(from.get("password"), userToLog.password)
				)
			)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}

	}

	override void queryById(Long id, CriteriaBuilder builder, CriteriaQuery<User> query, Root<User> from) {
		from.fetch("friends", JoinType.LEFT)
		from.fetch("purchases", JoinType.LEFT)
		query.select(from).where(builder.equal(from.get("id"), id))
	}

	def getPossibleFriends(String id) {
		val user = searchById(id)
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("friends", JoinType.LEFT)
			if (user.friends.empty)
				query.where(criteria.notEqual(from.get("id"), id))
			else
				query.where(
					criteria.not(from.get("id").in(user.friends.map[it.id].toSet)),
					criteria.notEqual(from.get("id"), id)
				)

			entityManager.createQuery(query).resultList.toSet
		} finally {
			entityManager?.close
		}
	}

}
