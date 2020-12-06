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
import net.shopxx.dao.InformationDao;
import net.shopxx.entity.Information;
import net.shopxx.entity.NewLaunch;

/**
 * DaoImpl - 信息发布实现类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class InformationDaoImpl extends BaseDaoImpl<Information, Long> implements InformationDao {

	@Override
	public List<Information> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Information> criteriaQuery = criteriaBuilder.createQuery(Information.class);
		Root<Information> root = criteriaQuery.from(Information.class);
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
	public List<Information> findList(Date beginDate, Date endDate, Integer first, Integer count) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Information> criteriaQuery = criteriaBuilder.createQuery(Information.class);
		Root<Information> root = criteriaQuery.from(Information.class);
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
	public Page<Information> findPage( Boolean isPublication, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Information> criteriaQuery = criteriaBuilder.createQuery(Information.class);
		Root<Information> root = criteriaQuery.from(Information.class);
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
	public Page<Information> findPage(Information entity, Pageable pageable) {
		// TODO Auto-generated method stub
				CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
				CriteriaQuery<Information> criteriaQuery = criteriaBuilder.createQuery(Information.class);
				Root<Information> root = criteriaQuery.from(Information.class);
				criteriaQuery.select(root);
				Predicate restrictions = criteriaBuilder.conjunction();
				if(entity.getAuthor() !=null) {
					restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("author"), "%" + entity.getAuthor() + "%"));
					//restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("creatUser"), newLaunch.getCreatUser()));;
				}
				if(entity.getTitle()!=null) {
					restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.like(root.<String>get("title"), "%" + entity.getTitle() + "%"));;
				}
				criteriaQuery.where(restrictions);
				return super.findPage(criteriaQuery, pageable);
	}

}