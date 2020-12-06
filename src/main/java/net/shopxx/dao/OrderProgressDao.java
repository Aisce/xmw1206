/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 4qpMk4b79aGF8etwqKp9WZn7PHGYiNsM
 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.OrderProgress;

/**
 * Dao - 订单进度信息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface OrderProgressDao extends BaseDao<OrderProgress, Long> {

	/**
	 * 获取进度信息
	 * @param order
	 * @param product
	 * @return
	 */
	public List<OrderProgress> findList(Long orderId, Long productId);

}