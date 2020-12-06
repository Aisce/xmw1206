/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: gc92W77mf1pEWQ9wsGF2KQr/YmFjm1be
 */
package net.shopxx.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.dao.StoreCategoryDao;
import net.shopxx.entity.StoreCategory;
import net.shopxx.service.StoreCategoryService;

/**
 * Service - 店铺分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class StoreCategoryServiceImpl extends BaseServiceImpl<StoreCategory, Long> implements StoreCategoryService {

	@Inject
	private StoreCategoryDao storeCategoryDao;

	@Override
	@Transactional(readOnly = true)
	public boolean nameExists(String name) {
		return storeCategoryDao.exists("name", name, true);
	}
	@Override
	@Transactional(readOnly = true)
	public boolean codeExists(String code) {
		return storeCategoryDao.exists("category_code", code, true);
	}

}