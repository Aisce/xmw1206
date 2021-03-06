/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: VkOtBrmb6HyUeXns69e7awuUVxCZoBsy
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.Navigation;
import net.shopxx.entity.XmNavigation;

/**
 * Service - 导航
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface XmNavigationService extends BaseService<XmNavigation, Long> {

	/**
	 * 查找导航
	 * 
	 * @param navigationGroupId
	 *            导航组ID
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @param useCache
	 *            是否使用缓存
	 * @return 导航
	 */
	List<XmNavigation> findList(Long navigationGroupId, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

}