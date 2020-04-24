package repository

import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

abstract class PersistantRepo<T>{
	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("aterrizapp")
	 
	def List<T> allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}
	
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
	

	
	def querySingleResult((CriteriaBuilder,CriteriaQuery<T>,Root<T>,T)=>CriteriaQuery<T> queryBlock,T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			queryBlock.apply(criteria,query,from,t)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	
	def query((CriteriaBuilder,CriteriaQuery<T>,Root<T>,T)=>CriteriaQuery<T> bloqueLoco,T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			bloqueLoco.apply(criteria,query,from,t)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}
	
	

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}
}