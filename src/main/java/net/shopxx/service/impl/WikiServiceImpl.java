/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: EGRmnqd4Q7IwC13A1a88ErLRvbOM/ZqJ
 */
package net.shopxx.service.impl;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.lang.StringUtils;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.hibernate.search.query.dsl.BooleanJunction;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.WikiCategoryDao;
import net.shopxx.dao.WikiDao;
import net.shopxx.dao.WikiTagDao;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.entity.WikiTag;
import net.shopxx.service.WikiService;

/**
 * Service - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class WikiServiceImpl extends BaseServiceImpl<Wiki, Long> implements WikiService {

	@PersistenceContext
	private EntityManager entityManager;

	@Inject
	private CacheManager cacheManager;
	@Inject
	private WikiDao wikiDao;
	@Inject
	private WikiCategoryDao wikiCategoryDao;
	@Inject
	private WikiTagDao wikiTagDao;

	@Override
	@Transactional(readOnly = true)
	public List<Wiki> findList(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		return wikiDao.findList(wikiCategory, wikiTag, isPublication, count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "wiki", condition = "#useCache")
	public List<Wiki> findList(Long wikiCategoryId, Long wikiTagId, Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache) {
		WikiCategory wikiCategory = wikiCategoryDao.find(wikiCategoryId);
		if (wikiCategoryId != null && wikiCategory == null) {
			return Collections.emptyList();
		}
		WikiTag wikiTag = wikiTagDao.find(wikiTagId);
		if (wikiTagId != null && wikiTag == null) {
			return Collections.emptyList();
		}
		return wikiDao.findList(wikiCategory, wikiTag, isPublication, count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	public Page<Wiki> findPage(WikiCategory wikiCategory, WikiTag wikiTag, Boolean isPublication, Pageable pageable) {
		return wikiDao.findPage(wikiCategory, wikiTag, isPublication, pageable);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Page<Wiki> search(String keyword, Pageable pageable) {
		if (StringUtils.isEmpty(keyword)) {
			return Page.emptyPage(pageable);
		}

		if (pageable == null) {
			pageable = new Pageable();
		}

		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder().forEntity(Wiki.class).get();

		Query contentPhraseQuery = queryBuilder.phrase().withSlop(3).onField("content").sentence(keyword).createQuery();
		Query isPublicationPhraseQuery = queryBuilder.phrase().onField("isPublication").sentence("true").createQuery();

		BooleanJunction<?> junction = queryBuilder.bool().must(isPublicationPhraseQuery);
		BooleanJunction<?> subJunction = queryBuilder.bool().should(contentPhraseQuery);
		Query titlePhraseQuery = queryBuilder.phrase().withSlop(3).onField("title").sentence(keyword).createQuery();
		subJunction.should(titlePhraseQuery);
		junction.must(subJunction.createQuery());

		FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(junction.createQuery(), Wiki.class);
		fullTextQuery.setSort(new Sort(new SortField("isTop", SortField.Type.STRING, true), new SortField(null, SortField.Type.SCORE), new SortField("createdDate", SortField.Type.LONG, true)));
		fullTextQuery.setFirstResult((pageable.getPageNumber() - 1) * pageable.getPageSize());
		fullTextQuery.setMaxResults(pageable.getPageSize());
		return new Page<>(fullTextQuery.getResultList(), fullTextQuery.getResultSize(), pageable);
	}

	@Override
	public long viewHits(Long id) {
		Assert.notNull(id, "[Assertion failed] - id is required; it must not be null");

		Ehcache cache = cacheManager.getEhcache(Wiki.HITS_CACHE_NAME);
		cache.acquireWriteLockOnKey(id);
		try {
			Element element = cache.get(id);
			Long hits;
			if (element != null) {
				hits = (Long) element.getObjectValue() + 1;
			} else {
				Wiki wiki = wikiDao.find(id);
				if (wiki == null) {
					return 0L;
				}
				hits = wiki.getHits() + 1;
			}
			cache.put(new Element(id, hits));
			return hits;
		} finally {
			cache.releaseWriteLockOnKey(id);
		}
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public Wiki save(Wiki wiki) {
		return super.save(wiki);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public Wiki update(Wiki wiki) {
		return super.update(wiki);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "wiki", "wikiCategory" }, allEntries = true)
	public Wiki update(Wiki wiki, String... ignoreProperties) {
		return super.update(wiki, ignoreProperties);
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
	public void delete(Wiki wiki) {
		super.delete(wiki);
	}

}