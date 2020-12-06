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
import net.shopxx.entity.DemandManagement;
import net.shopxx.entity.Information;

/**
 * Service - 芯梦观点
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface InformationService extends BaseService<Information, Long> {

	/**
	 * 查找观点
	 *
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
	List<Information> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找观点
	 * 
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
	List<Information> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

	/**
	 * 查找观点分页
	 * 
	 * @param isPublication
	 *            是否发布
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<Information> findPage(Boolean isPublication, Pageable pageable);

	/**
	 * 搜索观点分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<Information> search(String keyword, Pageable pageable);

	/**
	 * 查看点击数
	 * 
	 * @param id
	 *            ID
	 * @return 点击数
	 */
	long viewHits(Long id);
	
	public Page<Information> findPage(Information entity, Pageable pageable);

}