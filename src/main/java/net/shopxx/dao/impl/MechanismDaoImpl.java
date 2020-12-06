/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: wTHqTOHxi5dLBwgpRTphiC8ho7XKcvF/
 */
package net.shopxx.dao.impl;


import java.util.Collections;
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
import net.shopxx.dao.MechanismDao;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;

/**
 * Dao - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class MechanismDaoImpl extends BaseDaoImpl<Mechanism, Long> implements MechanismDao {
	@Override
	public List<Member> search(String keyword, Integer count,User.Type type) {
		if (StringUtils.isEmpty(keyword)) {
			return Collections.emptyList();
		}
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Member> criteriaQuery = criteriaBuilder.createQuery(Member.class);
		Root<Member> root = criteriaQuery.from(Member.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.or(criteriaBuilder.like(root.<String>get("username"), "%" + keyword + "%")));
		criteriaQuery.where(restrictions);
		TypedQuery<Member> createQuery = entityManager.createQuery(criteriaQuery);
		return createQuery.getResultList();
	}
	
	public void updateUser(Mechanism mechanism,String type) {
		String jpql = "update users set dtype =:type where id = :id";
		entityManager.createNativeQuery(jpql).setParameter("type", type).setParameter("id", mechanism.getId()).executeUpdate();
		//entityManager.createQuery(jpql).setParameter("type", type).setParameter("id", mechanism.getId()).executeUpdate();
	}
	
	public List<Member> findPage(User.Type type, Pageable pageable) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Member> criteriaQuery = criteriaBuilder.createQuery(Member.class);
		Root<Member> root = criteriaQuery.from(Member.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (type != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("type"), type));
		}
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && (CollectionUtils.isEmpty(pageable.getOrders())))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		//return super.findPage(criteriaQuery, pageable);
		TypedQuery<Member> createQuery = entityManager.createQuery(criteriaQuery);
		return createQuery.getResultList();
	}
}