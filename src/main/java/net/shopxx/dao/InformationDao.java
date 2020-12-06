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
import net.shopxx.entity.DemandManagement;
import net.shopxx.entity.Information;

/**
 * Dao - 芯梦观点
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface InformationDao extends BaseDao<Information, Long> {

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
	 * @return 信息
	 */
	List<Information> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找观点
	 *
	 * @param beginDate
	 *            起始日期
	 * @param endDate
	 *            结束日期
	 * @param first
	 *            起始记录
	 * @param count
	 *            数量
	 * @return 信息
	 */
	List<Information> findList(Date beginDate, Date endDate, Integer first, Integer count);

	/**
	 * 查找信息观点
	 *
	 * @param isPublication
	 *            是否发布
	 * @param pageable
	 *            分页信息
	 * @return 信息分页
	 */
	Page<Information> findPage(Boolean isPublication, Pageable pageable);
	
	public Page<Information> findPage(Information entity, Pageable pageable);

}