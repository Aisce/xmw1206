/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: rSrkQddnns8eVjoilpwndkN/nJOqs6kx
 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
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
public interface XmNavigationDao extends BaseDao<XmNavigation, Long> {

	/**
	 * 查找导航
	 * 
	 * @param navigationGroup
	 *            导航组
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @return 导航
	 */
	List<XmNavigation> findList(XmNavigationGroup navigationGroup, Integer count, List<Filter> filters, List<Order> orders);

}