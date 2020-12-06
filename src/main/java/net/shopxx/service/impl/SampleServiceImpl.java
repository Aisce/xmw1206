/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: EGRmnqd4Q7IwC13A1a88ErLRvbOM/ZqJ
 */
package net.shopxx.service.impl;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.SampleDao;
import net.shopxx.entity.Member;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;
import net.shopxx.service.SampleService;

/**
 * Service - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class SampleServiceImpl extends BaseServiceImpl<Sample, Long> implements SampleService {

	@PersistenceContext
	private EntityManager entityManager;
	@Inject
	private SampleDao sampleDao;
	

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public Sample save(Sample sample) {
		return super.save(sample);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public Sample update(Sample sample) {
		return super.update(sample);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "article", "articleCategory" }, allEntries = true)
	public Sample update(Sample sample, String... ignoreProperties) {
		return super.update(sample, ignoreProperties);
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
	public void delete(Sample sample) {
		super.delete(sample);
	}

	@Override
	public Page<Sample> findPage(Pageable pageable, Member currentUser,Store store) {
		// TODO Auto-generated method stub
		return sampleDao.findPage(pageable, currentUser,store);
	}

}