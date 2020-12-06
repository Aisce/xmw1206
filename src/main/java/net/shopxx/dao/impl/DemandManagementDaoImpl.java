/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: ob8EOzRboTgdrUJvArMcryb0rMo0eSEL
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
import net.shopxx.dao.DemandManagementDao;
import net.shopxx.entity.DemandManagement;


/**
 * Dao - admin dao实现类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class DemandManagementDaoImpl extends BaseDaoImpl<DemandManagement, Long> implements DemandManagementDao {

	@Override
	public List<DemandManagement> findList(Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DemandManagement> criteriaQuery = criteriaBuilder.createQuery(DemandManagement.class);
		Root<DemandManagement> root = criteriaQuery.from(DemandManagement.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		criteriaQuery.where(restrictions);
		if (orders == null || orders.isEmpty()) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	@Override
	public List<DemandManagement> findList(Date beginDate, Date endDate, Integer first, Integer count) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DemandManagement> criteriaQuery = criteriaBuilder.createQuery(DemandManagement.class);
		Root<DemandManagement> root = criteriaQuery.from(DemandManagement.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
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
	public Page<DemandManagement> findPage(Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DemandManagement> criteriaQuery = criteriaBuilder.createQuery(DemandManagement.class);
		Root<DemandManagement> root = criteriaQuery.from(DemandManagement.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && CollectionUtils.isEmpty(pageable.getOrders()))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}
	public Page<DemandManagement> findPage(DemandManagement demandManagement, Pageable pageable) {
		// TODO Auto-generated method stub
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DemandManagement> criteriaQuery = criteriaBuilder.createQuery(DemandManagement.class);
		Root<DemandManagement> root = criteriaQuery.from(DemandManagement.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if(demandManagement.getCreatUser() !=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("demandUser"), "%" + demandManagement.getDemandUser() + "%"));
			//restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("creatUser"), newLaunch.getCreatUser()));;
		}
		if(demandManagement.getName()!=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("name"), "%" + demandManagement.getName() + "%"));;
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

}