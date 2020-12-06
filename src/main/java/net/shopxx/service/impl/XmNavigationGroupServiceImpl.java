/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: EZXShjG2rU+ZyzZZ58P3Hgm6j2IfeGdA
 */
package net.shopxx.service.impl;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.entity.XmNavigationGroup;
import net.shopxx.service.XmNavigationGroupService;

/**
 * Service - 导航组
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class XmNavigationGroupServiceImpl extends BaseServiceImpl<XmNavigationGroup, Long> implements XmNavigationGroupService {

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigationGroup save(XmNavigationGroup navigationGroup) {
		return super.save(navigationGroup);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigationGroup update(XmNavigationGroup navigationGroup) {
		return super.update(navigationGroup);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigationGroup update(XmNavigationGroup navigationGroup, String... ignoreProperties) {
		return super.update(navigationGroup, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public void delete(XmNavigationGroup navigationGroup) {
		super.delete(navigationGroup);
	}

}