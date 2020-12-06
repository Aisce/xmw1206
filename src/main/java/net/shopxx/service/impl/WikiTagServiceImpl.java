/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: TMXXwYPL8Kg4qeDQvA9m7FIrV4DfiGCp
 */
package net.shopxx.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.dao.WikiTagDao;
import net.shopxx.entity.WikiTag;
import net.shopxx.service.WikiTagService;

/**
 * Service - 文章标签
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class WikiTagServiceImpl extends BaseServiceImpl<WikiTag, Long> implements WikiTagService {

	@Inject
	private WikiTagDao wikiTagDao;

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "wikiTag", condition = "#useCache")
	public List<WikiTag> findList(Integer count, List<Filter> filters, List<Order> orders, boolean useCache) {
		return wikiTagDao.findList(null, count, filters, orders);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public WikiTag save(WikiTag wikiTag) {
		return super.save(wikiTag);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public WikiTag update(WikiTag wikiTag) {
		return super.update(wikiTag);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public WikiTag update(WikiTag wikiTag, String... ignoreProperties) {
		return super.update(wikiTag, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = "wikiTag", allEntries = true)
	public void delete(WikiTag wikiTag) {
		super.delete(wikiTag);
	}

}