/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: MOisUdAcYPfb8hWnp+5sl6tb9661V91n
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.WikiCategory;

/**
 * Service - 文章分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface WikiCategoryService extends BaseService<WikiCategory, Long> {

	/**
	 * 查找顶级文章分类
	 * 
	 * @return 顶级文章分类
	 */
	List<WikiCategory> findRoots();

	/**
	 * 查找顶级文章分类
	 * 
	 * @param count
	 *            数量
	 * @return 顶级文章分类
	 */
	List<WikiCategory> findRoots(Integer count);

	/**
	 * 查找顶级文章分类
	 * 
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 顶级文章分类
	 */
	List<WikiCategory> findRoots(Integer count, boolean useCache);

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
	 * 查找上级文章分类
	 * 
	 * @param wikiCategoryId
	 *            文章分类ID
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 上级文章分类
	 */
	List<WikiCategory> findParents(Long wikiCategoryId, boolean recursive, Integer count, boolean useCache);

	/**
	 * 查找文章分类树
	 * 
	 * @return 文章分类树
	 */
	List<WikiCategory> findTree();

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

	/**
	 * 查找下级文章分类
	 * 
	 * @param wikiCategoryId
	 *            文章分类ID
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 下级文章分类
	 */
	List<WikiCategory> findChildren(Long wikiCategoryId, boolean recursive, Integer count, boolean useCache);

}