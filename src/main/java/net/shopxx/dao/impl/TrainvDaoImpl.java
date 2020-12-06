/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PRUj7vOi76D1BwCVYE0DY1cDUH+mWNXA
 */
package net.shopxx.dao.impl;

import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.TrainvDao;
import net.shopxx.entity.DemandManagement;
import net.shopxx.entity.Information;
import net.shopxx.entity.Trainv;

/**
 * Dao - 培训
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class TrainvDaoImpl extends BaseDaoImpl<Trainv, Long> implements TrainvDao {

	@Override
	public List<Trainv> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Trainv> criteriaQuery = criteriaBuilder.createQuery(Trainv.class);
		Root<Trainv> root = criteriaQuery.from(Trainv.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (isPublication != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isPublication"), isPublication));
		}
		criteriaQuery.where(restrictions);
		if (orders == null || orders.isEmpty()) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("isTop")), criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	@Override
	public List<Trainv> findList(Boolean isPublication, Date beginDate, Date endDate, Integer first, Integer count) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Trainv> criteriaQuery = criteriaBuilder.createQuery(Trainv.class);
		Root<Trainv> root = criteriaQuery.from(Trainv.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		
		if (isPublication != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isPublication"), isPublication));
		}
		if (beginDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.greaterThanOrEqualTo(root.<Date>get("createdDate"), beginDate));
		}
		if (endDate != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.lessThanOrEqualTo(root.<Date>get("createdDate"), endDate));
		}
		criteriaQuery.where(restrictions);
		return super.findList(criteriaQuery, first, count);
	}

	@Override
	public Page<Trainv> findPage(Boolean isPublication, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Trainv> criteriaQuery = criteriaBuilder.createQuery(Trainv.class);
		Root<Trainv> root = criteriaQuery.from(Trainv.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		
		if (isPublication != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isPublication"), isPublication));
		}
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && CollectionUtils.isEmpty(pageable.getOrders()))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("isTop")), criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}

	@Override
	public Page<Trainv> findPage(Trainv entity, Pageable pageable) {
		// TODO Auto-generated method stub
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Trainv> criteriaQuery = criteriaBuilder.createQuery(Trainv.class);
		Root<Trainv> root = criteriaQuery.from(Trainv.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if(entity.getSponsor() !=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("sponsor"), "%" + entity.getSponsor() + "%"));
			//restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("creatUser"), newLaunch.getCreatUser()));;
		}
		if(entity.getSubject()!=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("subject"), "%" + entity.getSubject() + "%"));;
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

}