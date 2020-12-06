/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: DWrDL9/6cFRIuNenry+lNIaZ1AbpavpD
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.entity.WikiTag;

/**
 * Service - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface WikiService extends BaseService<Wiki, Long> {

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
	 * @param wikiCategoryId
	 *            文章分类ID
	 * @param wikiTagId
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
	List<Wiki> findList(Long wikiCategoryId, Long wikiTagId, Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

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

	/**
	 * 搜索文章分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<Wiki> search(String keyword, Pageable pageable);

	/**
	 * 查看点击数
	 * 
	 * @param id
	 *            ID
	 * @return 点击数
	 */
	long viewHits(Long id);

}