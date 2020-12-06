/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 361jkVUSCR+MnrFnV0VvVgwr1T4gcCap
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.WikiTag;

/**
 * Service - 文章标签
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface WikiTagService extends BaseService<WikiTag, Long> {

	/**
	 * 查找文章标签
	 * 
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @param useCache
	 *            是否使用缓存
	 * @return 文章标签
	 */
	List<WikiTag> findList(Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

}