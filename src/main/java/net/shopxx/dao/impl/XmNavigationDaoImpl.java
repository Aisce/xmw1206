/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: CG/Ce2l+WgeR0Ve16QD18KhvWj2UjmlC
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
import net.shopxx.dao.NavigationDao;
import net.shopxx.dao.XmNavigationDao;
import net.shopxx.entity.Navigation;
import net.shopxx.entity.NavigationGroup;
import net.shopxx.entity.XmNavigation;
import net.shopxx.entity.XmNavigationGroup;

/**
 * Dao - 导航
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class XmNavigationDaoImpl extends BaseDaoImpl<XmNavigation, Long> implements XmNavigationDao {

	public List<XmNavigation> findList(XmNavigationGroup navigationGroup, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<XmNavigation> criteriaQuery = criteriaBuilder.createQuery(XmNavigation.class);
		Root<XmNavigation> root = criteriaQuery.from(XmNavigation.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (navigationGroup != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("navigationGroup"), navigationGroup));
		}
		criteriaQuery.where(restrictions);
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

}