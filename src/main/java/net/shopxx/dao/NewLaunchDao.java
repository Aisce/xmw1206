/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: VXWq5Nbhwa2tf5PxIAjzXkPqbsmIEctb
 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.NewLaunch;

/**
 * Dao - 商品收藏
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface NewLaunchDao extends BaseDao<NewLaunch, Long> {

	List<NewLaunch> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders);
	
	public Page<NewLaunch> findPage(NewLaunch newLaunch, Pageable pageable);

}