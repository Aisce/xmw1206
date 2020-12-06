/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: d5yaR9qn/h44LkOBQ2KHJd26RBx5Rs6U
 */
package net.shopxx.dao;

import java.util.Date;
import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.entity.WikiTag;

/**
 * Dao - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface WikiDao extends BaseDao<Wiki, Long> {

	/**
	 * 查找文章
	 * 
	 * @param wikiCategory
	 *            文章分类
	 * @param wikiTag
	 *            文章标签
	 * @param isPublication
	 *            是否发布
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @return 文章
	 */
	List<Wiki> findList(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找文章
	 * 
	 * @param wikiCategory
	 *            文章分类
	 * @param isPublication
	 *            是否发布
	 * @param beginDate
	 *            起始日期
	 * @param endDate
	 *            结束日期
	 * @param first
	 *            起始记录
	 * @param count
	 *            数量
	 * @return 文章
	 */
	List<Wiki> findList(WikiCategory wikiCategory, Boolean isPublication, Date beginDate, Date endDate, Integer first, Integer count);

	/**
	 * 查找文章分页
	 * 
	 * @param wikiCategory
	 *            文章分类
	 * @param wikiTag
	 *            文章标签
	 * @param isPublication
	 *            是否发布
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<Wiki> findPage(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Pageable pageable);

}