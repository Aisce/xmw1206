/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PRUj7vOi76D1BwCVYE0DY1cDUH+mWNXA
 */
package net.shopxx.dao.impl;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.SampleDao;
import net.shopxx.entity.Member;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;

/**
 * Dao - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class SampleDaoImpl extends BaseDaoImpl<Sample, Long> implements SampleDao {
	@Override
	public Page<Sample> findPage(Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Sample> criteriaQuery = criteriaBuilder.createQuery(Sample.class);
		Root<Sample> root = criteriaQuery.from(Sample.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && CollectionUtils.isEmpty(pageable.getOrders()))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}

	@Override
	public Page<Sample> findPage(Pageable pageable, Member currentUser,Store store) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Sample> criteriaQuery = criteriaBuilder.createQuery(Sample.class);
		Root<Sample> root = criteriaQuery.from(Sample.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (currentUser != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("memberUser"), currentUser));
		}
		if(store!=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("store"), store));
		}
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && (CollectionUtils.isEmpty(pageable.getOrders())))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}

}