/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: eCu3gxDXpo6rzY/NJJkAjbBGFNh9jHSS
 */
package net.shopxx.dao.impl;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.MechanismStoreDao;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;

/**
 * Dao - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class MechanismStoreDaoImpl extends BaseDaoImpl<MechanismStore, Long> implements MechanismStoreDao {

	@Override
	public List<MechanismStore> findList(MechanismStore.Type type, Boolean isEnabled, Boolean hasExpired, Integer first, Integer count) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismStore> criteriaQuery = criteriaBuilder.createQuery(MechanismStore.class);
		Root<MechanismStore> root = criteriaQuery.from(MechanismStore.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		if (isEnabled != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isEnabled"), isEnabled));
		}
		if (hasExpired != null) {
			if (hasExpired) {
				restrictions = criteriaBuilder.and(restrictions, root.get("endDate").isNotNull(), criteriaBuilder.lessThanOrEqualTo(root.<Date>get("endDate"), new Date()));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("endDate").isNull(), criteriaBuilder.greaterThan(root.<Date>get("endDate"), new Date())));
			}
		}
		criteriaQuery.where(restrictions);
		return findList(criteriaQuery, first, count);
	}


	@Override
	public Page<MechanismStore> findPage(MechanismStore.Type type, Boolean isEnabled, Boolean hasExpired, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismStore> criteriaQuery = criteriaBuilder.createQuery(MechanismStore.class);
		Root<MechanismStore> root = criteriaQuery.from(MechanismStore.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		if (isEnabled != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isEnabled"), isEnabled));
		}
		if (hasExpired != null) {
			if (hasExpired) {
				restrictions = criteriaBuilder.and(restrictions, root.get("endDate").isNotNull(), criteriaBuilder.lessThanOrEqualTo(root.<Date>get("endDate"), new Date()));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("endDate").isNull(), criteriaBuilder.greaterThan(root.<Date>get("endDate"), new Date())));
			}
		}
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && (CollectionUtils.isEmpty(pageable.getOrders())))) {
			criteriaQuery.orderBy(criteriaBuilder.asc(root.get("sorting")));
		}
		return super.findPage(criteriaQuery, pageable);
	}
	
	public List<MechanismStore> search(String keyword, Integer count,MechanismStore.Type type) {
		if (StringUtils.isEmpty(keyword)) {
			return Collections.emptyList();
		}
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismStore> criteriaQuery = criteriaBuilder.createQuery(MechanismStore.class);
		Root<MechanismStore> root = criteriaQuery.from(MechanismStore.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.like(root.<String>get("name"), "%" + keyword + "%")));
		criteriaQuery.where(restrictions);
		TypedQuery<MechanismStore> createQuery = entityManager.createQuery(criteriaQuery);
		return createQuery.getResultList();
	}



	@Override
	public Long count(MechanismStore.Type type,Boolean isEnabled, Boolean hasExpired) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismStore> criteriaQuery = criteriaBuilder.createQuery(MechanismStore.class);
		Root<MechanismStore> root = criteriaQuery.from(MechanismStore.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		if (isEnabled != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isEnabled"), isEnabled));
		}
		if (hasExpired != null) {
			if (hasExpired) {
				restrictions = criteriaBuilder.and(restrictions, root.get("endDate").isNotNull(), criteriaBuilder.lessThanOrEqualTo(root.<Date>get("endDate"), new Date()));
			} else {
				restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(root.get("endDate").isNull(), criteriaBuilder.greaterThan(root.<Date>get("endDate"), new Date())));
			}
		}
		criteriaQuery.where(restrictions);
		return super.count(criteriaQuery, null);
	}


	@Override
	public List<MechanismStore> findStoreId(Member member) {
		// TODO Auto-generated method stub
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismStore> criteriaQuery = criteriaBuilder.createQuery(MechanismStore.class);
		Root<MechanismStore> root = criteriaQuery.from(MechanismStore.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (member != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("mechanism"), member));
		}
		criteriaQuery.where(restrictions);
		TypedQuery<MechanismStore> createQuery = entityManager.createQuery(criteriaQuery);
		return createQuery.getResultList();
	}
}