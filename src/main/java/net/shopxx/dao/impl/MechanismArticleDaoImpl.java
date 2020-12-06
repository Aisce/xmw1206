/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: wTHqTOHxi5dLBwgpRTphiC8ho7XKcvF/
 */
package net.shopxx.dao.impl;


import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Repository;

import net.shopxx.dao.MechanismArticleDao;
import net.shopxx.entity.MechanismArticle;

/**
 * Dao - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class MechanismArticleDaoImpl extends BaseDaoImpl<MechanismArticle, Long> implements MechanismArticleDao {
	@Override
	public List<MechanismArticle> search(MechanismArticle.Type type) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<MechanismArticle> criteriaQuery = criteriaBuilder.createQuery(MechanismArticle.class);
		Root<MechanismArticle> root = criteriaQuery.from(MechanismArticle.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		criteriaQuery.where(restrictions);
		TypedQuery<MechanismArticle> createQuery = entityManager.createQuery(criteriaQuery);
		return createQuery.getResultList();
	}
}