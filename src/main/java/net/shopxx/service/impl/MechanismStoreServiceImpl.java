/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 3GieivI+LGlHJW7qPxCBawaEFGWkbS3y
 */
package net.shopxx.service.impl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.hibernate.search.query.dsl.BooleanJunction;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.MechanismStoreDao;
import net.shopxx.dao.ProductDao;
import net.shopxx.dao.StoreDao;
import net.shopxx.entity.AftersalesSetting;
import net.shopxx.entity.Business;
import net.shopxx.entity.BusinessDepositLog;
import net.shopxx.entity.CategoryApplication;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.MechanismStore.Type;
import net.shopxx.entity.Member;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Store;
import net.shopxx.entity.StorePluginStatus;
import net.shopxx.plugin.MoneyOffPromotionPlugin;
import net.shopxx.plugin.PromotionPlugin;
import net.shopxx.service.AftersalesSettingService;
import net.shopxx.service.BusinessService;
import net.shopxx.service.MailService;
import net.shopxx.service.MechanismStoreService;
import net.shopxx.service.SmsService;
import net.shopxx.service.StorePluginStatusService;
import net.shopxx.service.StoreService;
import net.shopxx.service.UserService;

/**
 * Service - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class MechanismStoreServiceImpl extends BaseServiceImpl<MechanismStore, Long> implements MechanismStoreService {

	@PersistenceContext
	private EntityManager entityManager;

	@Inject
	private MechanismStoreDao mechanismStoreDao;
	@Inject
	private UserService userService;

	@Override
	@Transactional(readOnly = true)
	public boolean nameExists(String name) {
		return mechanismStoreDao.exists("name", name, true);
	}

	@Override
	@Transactional(readOnly = true)
	public boolean nameUnique(Long id, String name) {
		return mechanismStoreDao.unique(id, "name", name, true);
	}


	@Override
	@Transactional(readOnly = true)
	public MechanismStore findByName(String name) {
		return mechanismStoreDao.find("name", name, true);
	}

	@Override
	@Transactional(readOnly = true)
	public List<MechanismStore> findList(MechanismStore.Type type, Boolean isEnabled, Boolean hasExpired, Integer first, Integer count) {
		return mechanismStoreDao.findList(type, isEnabled, hasExpired, first, count);
	}


	@Override
	@Transactional(readOnly = true)
	public Page<MechanismStore> findPage(MechanismStore.Type type,Boolean isEnabled, Boolean hasExpired, Pageable pageable) {
		return mechanismStoreDao.findPage(type,isEnabled, hasExpired, pageable);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Page<MechanismStore> search(String keyword, Pageable pageable) {
		if (StringUtils.isEmpty(keyword)) {
			return Page.emptyPage(pageable);
		}

		if (pageable == null) {
			pageable = new Pageable();
		}

		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder().forEntity(Store.class).get();

		Query statusPhraseQuery = queryBuilder.phrase().onField("status").sentence(String.valueOf(Store.Status.SUCCESS)).createQuery();
		Query isEnabledPhraseQuery = queryBuilder.phrase().onField("isEnabled").sentence("true").createQuery();

		BooleanJunction<?> junction = queryBuilder.bool().must(statusPhraseQuery).must(isEnabledPhraseQuery);
		BooleanJunction<?> subJunction = queryBuilder.bool();
		Query namePhraseQuery = queryBuilder.phrase().withSlop(3).onField("name").sentence(keyword).createQuery();
		Query keywordFuzzyQuery = queryBuilder.keyword().fuzzy().onField("keyword").matching(keyword).createQuery();
		subJunction.should(namePhraseQuery).should(keywordFuzzyQuery);
		junction.must(subJunction.createQuery());

		FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(junction.createQuery(), Store.class);
		fullTextQuery.setSort(new Sort(new SortField(null, SortField.Type.SCORE), new SortField("createdDate", SortField.Type.LONG, true)));
		fullTextQuery.setFirstResult((pageable.getPageNumber() - 1) * pageable.getPageSize());
		fullTextQuery.setMaxResults(pageable.getPageSize());
		return new Page<>(fullTextQuery.getResultList(), fullTextQuery.getResultSize(), pageable);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<MechanismStore> search(String keyword) {
		if (StringUtils.isEmpty(keyword)) {
			return Collections.EMPTY_LIST;
		}

		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder().forEntity(Store.class).get();

		Query statusPhraseQuery = queryBuilder.phrase().onField("status").sentence(String.valueOf(Store.Status.SUCCESS)).createQuery();
		Query isEnabledPhraseQuery = queryBuilder.phrase().onField("isEnabled").sentence("true").createQuery();

		BooleanJunction<?> junction = queryBuilder.bool().must(statusPhraseQuery).must(isEnabledPhraseQuery);
		BooleanJunction<?> subJunction = queryBuilder.bool();
		Query namePhraseQuery = queryBuilder.phrase().withSlop(3).onField("name").sentence(keyword).createQuery();
		Query keywordFuzzyQuery = queryBuilder.keyword().fuzzy().onField("keyword").matching(keyword).createQuery();
		subJunction.should(namePhraseQuery).should(keywordFuzzyQuery);
		junction.must(subJunction.createQuery());

		FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(junction.createQuery(), Store.class);
		fullTextQuery.setSort(new Sort(new SortField(null, SortField.Type.SCORE), new SortField("createdDate", SortField.Type.LONG, true)));
		return fullTextQuery.getResultList();
	}

	@Override
	@Transactional(readOnly = true)
	public MechanismStore getCurrent() {
		Mechanism currentUser = userService.getCurrent(Mechanism.class);
		return currentUser != null ? currentUser.getStore() : null;
	}

	@Override
	@Transactional
	@CacheEvict(value = { "authorization", "product", "productCategory" }, allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "authorization", "product", "productCategory" }, allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "authorization", "product", "productCategory" }, allEntries = true)
	public void delete(MechanismStore store) {
		super.delete(store);
	}

	@Override
	public void review(MechanismStore store, boolean passed, String content) {
		// TODO Auto-generated method stub
	}

	@Override
	public List<MechanismStore> search(String keyword, Integer count, Type type) {
		// TODO Auto-generated method stub
		return mechanismStoreDao.search(keyword, count, type);
	}

	@Override
	public List<MechanismStore> findStoreId(Member member) {
		// TODO Auto-generated method stub
		return mechanismStoreDao.findStoreId(member);
	}

}