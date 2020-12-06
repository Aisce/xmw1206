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
import javax.persistence.criteria.Subquery;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.WikiDao;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.entity.WikiTag;

/**
 * Dao - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class WikiDaoImpl extends BaseDaoImpl<Wiki, Long> implements WikiDao {

	@Override
	public List<Wiki> findList(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Wiki> criteriaQuery = criteriaBuilder.createQuery(Wiki.class);
		Root<Wiki> root = criteriaQuery.from(Wiki.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (wikiCategory != null) {
			Subquery<WikiCategory> subquery = criteriaQuery.subquery(WikiCategory.class);
			Root<WikiCategory> subqueryRoot = subquery.from(WikiCategory.class);
			subquery.select(subqueryRoot);
			subquery.where(criteriaBuilder.or(criteriaBuilder.equal(subqueryRoot, wikiCategory), criteriaBuilder.like(subqueryRoot.<String>get("treePath"), "%" + WikiCategory.TREE_PATH_SEPARATOR + wikiCategory.getId() + WikiCategory.TREE_PATH_SEPARATOR + "%")));
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.in(root.get("wikiCategory")).value(subquery));
		}
		if (wikiTag != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.join("wikiTags"), wikiTag));
		}
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
	public List<Wiki> findList(WikiCategory wikiCategory, Boolean isPublication, Date beginDate, Date endDate, Integer first, Integer count) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Wiki> criteriaQuery = criteriaBuilder.createQuery(Wiki.class);
		Root<Wiki> root = criteriaQuery.from(Wiki.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (wikiCategory != null) {
			Subquery<WikiCategory> subquery = criteriaQuery.subquery(WikiCategory.class);
			Root<WikiCategory> subqueryRoot = subquery.from(WikiCategory.class);
			subquery.select(subqueryRoot);
			subquery.where(criteriaBuilder.or(criteriaBuilder.equal(subqueryRoot, wikiCategory), criteriaBuilder.like(subqueryRoot.<String>get("treePath"), "%" + WikiCategory.TREE_PATH_SEPARATOR + wikiCategory.getId() + WikiCategory.TREE_PATH_SEPARATOR + "%")));
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.in(root.get("wikiCategory")).value(subquery));
		}
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
	public Page<Wiki> findPage(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Wiki> criteriaQuery = criteriaBuilder.createQuery(Wiki.class);
		Root<Wiki> root = criteriaQuery.from(Wiki.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (wikiCategory != null) {
			Subquery<WikiCategory> subquery = criteriaQuery.subquery(WikiCategory.class);
			Root<WikiCategory> subqueryRoot = subquery.from(WikiCategory.class);
			subquery.select(subqueryRoot);
			subquery.where(criteriaBuilder.or(criteriaBuilder.equal(subqueryRoot, wikiCategory), criteriaBuilder.like(subqueryRoot.<String>get("treePath"), "%" + WikiCategory.TREE_PATH_SEPARATOR + wikiCategory.getId() + WikiCategory.TREE_PATH_SEPARATOR + "%")));
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.in(root.get("wikiCategory")).value(subquery));
		}
		if (wikiTag != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.join("wikiTags"), wikiTag));
		}
		if (isPublication != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("isPublication"), isPublication));
		}
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && CollectionUtils.isEmpty(pageable.getOrders()))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("isTop")), criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}

}