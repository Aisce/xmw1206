/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: q2LXaBMEVZ7B1y58a34V/HBQFMiNTVkd
 */
package net.shopxx.dao;

import net.shopxx.entity.Cart;

/**
 * Dao - 购物车
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface CartDao extends BaseDao<Cart, Long> {

	/**
	 * 删除过期购物车
	 */
	void deleteExpired();

}