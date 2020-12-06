/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: ZbM+Sli2O07MpxmquwFYxz9PMUDdVk6x
 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.WikiCategory;

/**
 * Dao - 文章分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface WikiCategoryDao extends BaseDao<WikiCategory, Long> {

	/**
	 * 查找顶级文章分类
	 * 
	 * @param count
	 *            数量
	 * @return 顶级文章分类
	 */
	List<WikiCategory> findRoots(Integer count);

	/**
	 * 查找上级文章分类
	 * 
	 * @param wikiCategory
	 *            文章分类
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @return 上级文章分类
	 */
	List<WikiCategory> findParents(WikiCategory wikiCategory, boolean recursive, Integer count);

	/**
	 * 查找下级文章分类
	 * 
	 * @param wikiCategory
	 *            文章分类
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @return 下级文章分类
	 */
	List<WikiCategory> findChildren(WikiCategory wikiCategory, boolean recursive, Integer count);

}