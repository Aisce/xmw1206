/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: ob8EOzRboTgdrUJvArMcryb0rMo0eSEL
 */
package net.shopxx.dao.impl;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Repository;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.NewLaunchDao;
import net.shopxx.entity.NewLaunch;

/**
 * Dao - 新品发布
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class NewLaunchDaoImpl extends BaseDaoImpl<NewLaunch, Long> implements NewLaunchDao {

	@Override
	public List<NewLaunch> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<NewLaunch> criteriaQuery = criteriaBuilder.createQuery(NewLaunch.class);
		Root<NewLaunch> root = criteriaQuery.from(NewLaunch.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (isPublication != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("releaseFlag"), isPublication?"1":"0"));
		}
		criteriaQuery.where(restrictions);
		if (orders == null || orders.isEmpty()) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	@Override
	public Page<NewLaunch> findPage(NewLaunch newLaunch, Pageable pageable) {
		// TODO Auto-generated method stub
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<NewLaunch> criteriaQuery = criteriaBuilder.createQuery(NewLaunch.class);
		Root<NewLaunch> root = criteriaQuery.from(NewLaunch.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if(newLaunch.getCreatUser() !=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("creatUser"), "%" + newLaunch.getCreatUser() + "%"));
			//restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("creatUser"), newLaunch.getCreatUser()));;
		}
		if(newLaunch.getName()!=null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("name"), "%" + newLaunch.getName() + "%"));;
		}
		criteriaQuery.where(restrictions);
		return super.findPage(criteriaQuery, pageable);
	}

}