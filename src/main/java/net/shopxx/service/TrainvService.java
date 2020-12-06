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
import net.shopxx.entity.Trainv;

/**
 * Service - 培训
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface TrainvService extends BaseService<Trainv, Long> {

	/**
	 * 查找培训
	 * 
	 * @param isPublication
	 *            是否发布
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @return 培训
	 */
	List<Trainv> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找培训
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
	 * @return 培训
	 */
	List<Trainv> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

	/**
	 * 查找培训分页
	 * 
	 * @param isPublication
	 *            是否发布
	 * @param pageable
	 *            分页信息
	 * @return 培训分页
	 */
	Page<Trainv> findPage(Boolean isPublication, Pageable pageable);

	/**
	 * 搜索培训分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 培训分页
	 */
	Page<Trainv> search(String keyword, Pageable pageable);

	/**
	 * 查看点击数
	 * 
	 * @param id
	 *            ID
	 * @return 点击数
	 */
	long viewHits(Long id);
	
	public Page<Trainv> findPage(Trainv entity, Pageable pageable);

}