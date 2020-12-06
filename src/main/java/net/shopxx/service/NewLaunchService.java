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
import net.shopxx.entity.Business;
import net.shopxx.entity.Member;
import net.shopxx.entity.Product;
import net.shopxx.entity.ProductFavorite;
import net.shopxx.entity.NewLaunch;

/**
 * Service -  新品发布
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface NewLaunchService extends BaseService<NewLaunch, Long> {


	public List<NewLaunch> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache);

	/**
	 * 搜索新品发布分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<NewLaunch> search(String keyword, Pageable pageable);
	
	/**
	 * 查看次数
	 * 
	 * @param id
	 *            ID
	 * @return 点击数
	 */
	long viewHits(Long id);
	/**
	 *  条件查询分页新品
	 */
	/**
	 * 搜索新品发布分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	public Page<NewLaunch> findPage(NewLaunch entity, Pageable pageable);
}