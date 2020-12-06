/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: jwg16ATBDZsFcxYpkcuYWhX5l/myqV0S
 */
package net.shopxx.service.impl;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.dao.NavigationDao;
import net.shopxx.dao.NavigationGroupDao;
import net.shopxx.dao.XmNavigationDao;
import net.shopxx.dao.XmNavigationGroupDao;
import net.shopxx.entity.Navigation;
import net.shopxx.entity.NavigationGroup;
import net.shopxx.entity.XmNavigation;
import net.shopxx.entity.XmNavigationGroup;
import net.shopxx.service.NavigationService;
import net.shopxx.service.XmNavigationService;

/**
 * Service - 导航
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class XmNavigationServiceImpl extends BaseServiceImpl<XmNavigation, Long> implements XmNavigationService {

	@Inject
	private XmNavigationDao navigationDao;
	@Inject
	private XmNavigationGroupDao navigationGroupDao;

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "navigation", condition = "#useCache")
	public List<XmNavigation> findList(Long navigationGroupId, Integer count, List<Filter> filters, List<Order> orders, boolean useCache) {
		XmNavigationGroup navigationGroup = navigationGroupDao.find(navigationGroupId);
		if (navigationGroupId != null && navigationGroup == null) {
			return Collections.emptyList();
		}

		return navigationDao.findList(navigationGroup, count, filters, orders);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigation save(XmNavigation navigation) {
		return super.save(navigation);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigation update(XmNavigation navigation) {
		return super.update(navigation);
	}

	@Override
	@Transactional
	@CacheEvict(value = "navigation", allEntries = true)
	public XmNavigation update(XmNavigation navigation, String... ignoreProperties) {
		return super.update(navigation, ignoreProperties);
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
	public void delete(XmNavigation navigation) {
		super.delete(navigation);
	}

}