package repository

import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

abstract class PersistantRepo<T>{
	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("aterrizapp")
	
	abstract def Class<T> getEntityType()
	
	def create(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	def update(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}
	
	def searchById(String id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			this.queryById(Long.parseLong(id), criteria, query, from)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager.close
		}
	}
	
	def void queryById(Long id, CriteriaBuilder builder, CriteriaQuery<T> query, Root<T> from)
	
	
	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}
}