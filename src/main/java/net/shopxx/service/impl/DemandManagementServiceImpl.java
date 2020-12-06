/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: y43ZCzjg0BYUJCZmISAealFVD6Zvllgc
 */
package net.shopxx.service.impl;

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
import net.shopxx.dao.DemandManagementDao;
import net.shopxx.entity.Article;
import net.shopxx.entity.DemandManagement;
import net.shopxx.service.DemandManagementService;

/**
 * Service - 商品收藏
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class DemandManagementServiceImpl extends BaseServiceImpl<DemandManagement, Long> implements DemandManagementService {
	@PersistenceContext
	private EntityManager entityManager;

	@Inject
	private CacheManager cacheManager;
	@Inject
	private DemandManagementDao demandManagementDao;

	@Override
	@Transactional(readOnly = true)
	public List<DemandManagement> findList(Integer count, List<Filter> filters, List<Order> orders) {
		return demandManagementDao.findList(count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "article", condition = "#useCache")
	public List<DemandManagement> findList(Integer count, List<Filter> filters, List<Order> orders, boolean useCache) {
		return demandManagementDao.findList(count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	public Page<DemandManagement> findPage(Pageable pageable) {
		return demandManagementDao.findPage(pageable);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Page<DemandManagement> search(String keyword, Pageable pageable) {
		if (StringUtils.isEmpty(keyword)) {
			return Page.emptyPage(pageable);
		}

		if (pageable == null) {
			pageable = new Pageable();
		}

		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder().forEntity(Article.class).get();

		Query contentPhraseQuery = queryBuilder.phrase().withSlop(3).onField("content").sentence(keyword).createQuery();
		Query isPublicationPhraseQuery = queryBuilder.phrase().onField("isPublication").sentence("true").createQuery();

		BooleanJunction<?> junction = queryBuilder.bool().must(isPublicationPhraseQuery);
		BooleanJunction<?> subJunction = queryBuilder.bool().should(contentPhraseQuery);
		Query titlePhraseQuery = queryBuilder.phrase().withSlop(3).onField("title").sentence(keyword).createQuery();
		subJunction.should(titlePhraseQuery);
		junction.must(subJunction.createQuery());

		FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(junction.createQuery(), Article.class);
		fullTextQuery.setSort(new Sort(new SortField("isTop", SortField.Type.STRING, true), new SortField(null, SortField.Type.SCORE), new SortField("createdDate", SortField.Type.LONG, true)));
		fullTextQuery.setFirstResult((pageable.getPageNumber() - 1) * pageable.getPageSize());
		fullTextQuery.setMaxResults(pageable.getPageSize());
		return new Page<>(fullTextQuery.getResultList(), fullTextQuery.getResultSize(), pageable);
	}

	@Override
	@Transactional(readOnly = true)
	public long viewHits(Long id) {
		Assert.notNull(id, "[Assertion failed] - id is required; it must not be null");

		Ehcache cache = cacheManager.getEhcache(Article.HITS_CACHE_NAME);
		cache.acquireWriteLockOnKey(id);
		try {
			Element element = cache.get(id);
			Long hits;
			if (element != null) {
				hits = (Long) element.getObjectValue() + 1;
			} else {
				DemandManagement article = demandManagementDao.find(id);
				if (article == null) {
					return 0L;
				}
				hits = 0L;
			}
			cache.put(new Element(id, hits));
			return hits;
		} finally {
			cache.releaseWriteLockOnKey(id);
		}
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public DemandManagement save(DemandManagement article) {
		return super.save(article);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public DemandManagement update(DemandManagement article) {
		return super.update(article);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public DemandManagement update(DemandManagement article, String... ignoreProperties) {
		return super.update(article, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public void delete(DemandManagement article) {
		super.delete(article);
	}

	@Override
	public Page<DemandManagement> findPage(DemandManagement entity, Pageable pageable) {
		// TODO Auto-generated method stub
		return demandManagementDao.findPage(entity, pageable);
	}
}