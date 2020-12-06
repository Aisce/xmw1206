/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 8kKrtCU78VC6hlld5DF9tTY6c/HeXRcG
 */
package net.shopxx.dao.impl;

import java.util.List;

import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import net.shopxx.dao.OrderProgressDao;
import net.shopxx.entity.OrderProgress;

/**
 * Dao - 订单进度信息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class OrderProgressDaoImpl extends BaseDaoImpl<OrderProgress, Long> implements OrderProgressDao {

	@Override
	public List<OrderProgress> findList(Long orderId, Long productId) {
		String jpql = "select orderProgress from OrderProgress orderProgress where order.id = :orderId and product.id = :productId";
		TypedQuery<OrderProgress> query = entityManager.createQuery(jpql, OrderProgress.class).setParameter("orderId", orderId).setParameter("productId", productId);
		return query.getResultList();
	}

	

}