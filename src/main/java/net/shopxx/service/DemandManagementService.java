/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: F1/9Cy6tQMam6ISCzNMBc578KNMkKo4/
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Article;
import net.shopxx.entity.ArticleCategory;
import net.shopxx.entity.ArticleTag;
import net.shopxx.entity.DemandManagement;

/**
 * Service - 集成电路需求管理
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface DemandManagementService extends BaseService<DemandManagement, Long> {
	/**
	 * 查找文章
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param articleTag
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
	List<DemandManagement> findList(Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找文章
	 * 
	 * @param articleCategoryId
	 *            文章分类ID
	 * @param articleTagId
	 *            文章标签ID
	 * @param isPublication
	 *            是否发布
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @param useCache
	 *            是否使用缓存
	 * @return 文章
	 */
	List<DemandManagement> findList(Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

	/**
	 * 查找文章分页
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param articleTag
	 *            文章标签
	 * @param isPublication
	 *            是否发布
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<DemandManagement> findPage(Pageable pageable);

	/**
	 * 搜索文章分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<DemandManagement> search(String keyword, Pageable pageable);

	/**
	 * 查看点击数
	 * 
	 * @param id
	 *            ID
	 * @return 点击数
	 */
	long viewHits(Long id);
	
	public Page<DemandManagement> findPage(DemandManagement entity, Pageable pageable);

}