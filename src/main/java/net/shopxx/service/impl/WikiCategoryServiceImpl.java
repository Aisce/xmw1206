/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: ang1ZYfuV/PpvxJiR7VPUk9MK7Ay/yBE
 */
package net.shopxx.service.impl;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import net.shopxx.dao.WikiCategoryDao;
import net.shopxx.entity.WikiCategory;
import net.shopxx.service.WikiCategoryService;

/**
 * Service - 文章分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class WikiCategoryServiceImpl extends BaseServiceImpl<WikiCategory, Long> implements WikiCategoryService {

	@Inject
	private WikiCategoryDao wikiCategoryDao;

	@Override
	@Transactional(readOnly = true)
	public List<WikiCategory> findRoots() {
		return wikiCategoryDao.findRoots(null);
	}

	@Override
	@Transactional(readOnly = true)
	public List<WikiCategory> findRoots(Integer count) {
		return wikiCategoryDao.findRoots(count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "wikiCategory", condition = "#useCache")
	public List<WikiCategory> findRoots(Integer count, boolean useCache) {
		return wikiCategoryDao.findRoots(count);
	}

	@Override
	@Transactional(readOnly = true)
	public List<WikiCategory> findParents(WikiCategory wikiCategory, boolean recursive, Integer count) {
		return wikiCategoryDao.findParents(wikiCategory, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "wikiCategory", condition = "#useCache")
	public List<WikiCategory> findParents(Long wikiCategoryId, boolean recursive, Integer count, boolean useCache) {
		WikiCategory wikiCategory = wikiCategoryDao.find(wikiCategoryId);
		if (wikiCategoryId != null && wikiCategory == null) {
			return Collections.emptyList();
		}
		return wikiCategoryDao.findParents(wikiCategory, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	public List<WikiCategory> findTree() {
		return wikiCategoryDao.findChildren(null, true, null);
	}

	@Override
	@Transactional(readOnly = true)
	public List<WikiCategory> findChildren(WikiCategory wikiCategory, boolean recursive, Integer count) {
		return wikiCategoryDao.findChildren(wikiCategory, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "wikiCategory", condition = "#useCache")
	public List<WikiCategory> findChildren(Long wikiCategoryId, boolean recursive, Integer count, boolean useCache) {
		WikiCategory wikiCategory = wikiCategoryDao.find(wikiCategoryId);
		if (wikiCategoryId != null && wikiCategory == null) {
			return Collections.emptyList();
		}
		return wikiCategoryDao.findChildren(wikiCategory, recursive, count);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public WikiCategory save(WikiCategory wikiCategory) {
		Assert.notNull(wikiCategory, "[Assertion failed] - wikiCategory is required; it must not be null");

		setValue(wikiCategory);
		return super.save(wikiCategory);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public WikiCategory update(WikiCategory wikiCategory) {
		Assert.notNull(wikiCategory, "[Assertion failed] - wikiCategory is required; it must not be null");

		setValue(wikiCategory);
		for (WikiCategory children : wikiCategoryDao.findChildren(wikiCategory, true, null)) {
			setValue(children);
		}
		return super.update(wikiCategory);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public WikiCategory update(WikiCategory wikiCategory, String... ignoreProperties) {
		return super.update(wikiCategory, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public void delete(WikiCategory wikiCategory) {
		super.delete(wikiCategory);
	}

	/**
	 * 设置值
	 * 
	 * @param wikiCategory
	 *            文章分类
	 */
	private void setValue(WikiCategory wikiCategory) {
		if (wikiCategory == null) {
			return;
		}
		WikiCategory parent = wikiCategory.getParent();
		if (parent != null) {
			wikiCategory.setTreePath(parent.getTreePath() + parent.getId() + WikiCategory.TREE_PATH_SEPARATOR);
		} else {
			wikiCategory.setTreePath(WikiCategory.TREE_PATH_SEPARATOR);
		}
		wikiCategory.setGrade(wikiCategory.getParentIds().length);
	}

}