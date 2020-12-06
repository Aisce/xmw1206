/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: EGRmnqd4Q7IwC13A1a88ErLRvbOM/ZqJ
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
import net.shopxx.dao.InformationDao;
import net.shopxx.entity.Article;
import net.shopxx.entity.Information;
import net.shopxx.service.InformationService;

/**
 * Service - 芯梦观点
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class InformationServiceImpl extends BaseServiceImpl<Information, Long> implements InformationService {

	@PersistenceContext
	private EntityManager entityManager;

	@Inject
	private CacheManager cacheManager;
	@Inject
	private InformationDao informationDao;

	@Override
	@Transactional(readOnly = true)
	public List<Information> findList(Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders) {
		return informationDao.findList(isPublication, count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "article", condition = "#useCache")
	public List<Information> findList( Boolean isPublication, Integer count, List<Filter> filters, List<Order> orders, boolean useCache) {
		return informationDao.findList(isPublication, count, filters, orders);
	}

	@Override
	@Transactional(readOnly = true)
	public Page<Information> findPage(Boolean isPublication, Pageable pageable) {
		return informationDao.findPage(isPublication, pageable);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Page<Information> search(String keyword, Pageable pageable) {
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
				Information information = informationDao.find(id);
				if (information == null) {
					return 0L;
				}
				hits = information.getHits() + 1;
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
	public Information save(Information information) {
		return super.save(information);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public Information update(Information information) {
		return super.update(information);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public Information update(Information information, String... ignoreProperties) {
		return super.update(information, ignoreProperties);
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
	public void delete(Information information) {
		super.delete(information);
	}

	@Override
	public Page<Information> findPage(Information entity, Pageable pageable) {
		// TODO Auto-generated method stub
		return informationDao.findPage(entity, pageable);
	}

}