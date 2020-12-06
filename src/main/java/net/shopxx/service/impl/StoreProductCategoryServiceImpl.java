/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PLYXeTxxFq+KZykVnh9567LPBOkcI/UX
 */
package net.shopxx.service.impl;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.StoreDao;
import net.shopxx.dao.StoreProductCategoryDao;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Store;
import net.shopxx.entity.StoreProductCategory;
import net.shopxx.security.CurrentStore;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.StoreProductCategoryService;
import net.shopxx.service.StoreService;

/**
 * Service - 店铺商品分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class StoreProductCategoryServiceImpl extends BaseServiceImpl<StoreProductCategory, Long> implements StoreProductCategoryService {

	@Inject
	private StoreProductCategoryDao storeProductCategoryDao;
	@Inject
	private StoreDao storeDao;
	@Inject
	private StoreService storeService;
	@Inject
	private ProductCategoryService productCategoryService;

	@Override
	@Transactional(readOnly = true)
	public List<StoreProductCategory> findRoots(Long storeId) {
		Store store = storeDao.find(storeId);
		if (storeId != null && store == null) {
			return Collections.emptyList();
		}
		return storeProductCategoryDao.findRoots(store, null);
	}

	@Override
	@Transactional(readOnly = true)
	public List<StoreProductCategory> findRoots(Long storeId, Integer count) {
		Store store = storeDao.find(storeId);
		if (storeId != null && store == null) {
			return Collections.emptyList();
		}
		return storeProductCategoryDao.findRoots(store, count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "storeProductCategory", condition = "#useCache")
	public List<StoreProductCategory> findRoots(Long storeId, Integer count, boolean useCache) {
		Store store = storeDao.find(storeId);
		if (storeId != null && store == null) {
			return Collections.emptyList();
		}
		return storeProductCategoryDao.findRoots(store, count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "storeProductCategory", condition = "#useCache")
	public List<StoreProductCategory> findParents(Long storeProductCategoryId, boolean recursive, Integer count, boolean useCache) {
		StoreProductCategory storeProductCategory = storeProductCategoryDao.find(storeProductCategoryId);
		if (storeProductCategoryId != null && storeProductCategory == null) {
			return Collections.emptyList();
		}
		return storeProductCategoryDao.findParents(storeProductCategory, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	public List<StoreProductCategory> findTree(Store store) {
		return storeProductCategoryDao.findChildren(null, store, true, null);
	}

	@Override
	@Transactional(readOnly = true)
	public List<StoreProductCategory> findChildren(StoreProductCategory storeProductCategory, Store store, boolean recursive, Integer count) {
		return storeProductCategoryDao.findChildren(storeProductCategory, store, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	@Cacheable(value = "storeProductCategory", condition = "#useCache")
	public List<StoreProductCategory> findChildren(Long storeProductCategoryId, Long storeId, boolean recursive, Integer count, boolean useCache) {
		StoreProductCategory storeProductCategory = storeProductCategoryDao.find(storeProductCategoryId);
		if (storeProductCategoryId != null && storeProductCategory == null) {
			return Collections.emptyList();
		}
		Store store = storeDao.find(storeId);
		if (storeId == null && store == null) {
			return Collections.emptyList();
		}

		return storeProductCategoryDao.findChildren(storeProductCategory, store, recursive, count);
	}

	@Override
	@Transactional(readOnly = true)
	public Page<StoreProductCategory> findPage(Store store, Pageable pageable) {
		return storeProductCategoryDao.findPage(store, pageable);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public StoreProductCategory save(StoreProductCategory storeProductCategory) {
		Assert.notNull(storeProductCategory, "[Assertion failed] - storeProductCategory is required; it must not be null");

		setValue(storeProductCategory);
		return super.save(storeProductCategory);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public StoreProductCategory update(StoreProductCategory storeProductCategory) {
		Assert.notNull(storeProductCategory, "[Assertion failed] - storeProductCategory is required; it must not be null");

		setValue(storeProductCategory);
		for (StoreProductCategory children : storeProductCategoryDao.findChildren(storeProductCategory, storeService.getCurrent(), true, null)) {
			setValue(children);
		}
		return super.update(storeProductCategory);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public StoreProductCategory update(StoreProductCategory storeProductCategory, String... ignoreProperties) {
		return super.update(storeProductCategory, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "storeProductCategory" }, allEntries = true)
	public void delete(StoreProductCategory storeProductCategory) {
		super.delete(storeProductCategory);
	}

	/**
	 * 设置值
	 * 
	 * @param storeProductCategory
	 *            店铺商品分类
	 */
	private void setValue(StoreProductCategory storeProductCategory) {
		if (storeProductCategory == null) {
			return;
		}
		StoreProductCategory parent = storeProductCategory.getParent();
		if (parent != null) {
			storeProductCategory.setTreePath(parent.getTreePath() + parent.getId() + StoreProductCategory.TREE_PATH_SEPARATOR);
		} else {
			storeProductCategory.setTreePath(StoreProductCategory.TREE_PATH_SEPARATOR);
		}
		storeProductCategory.setGrade(storeProductCategory.getParentIds().length);
	}
	@Override
	@Transactional
	public StoreProductCategory saveStoreProductCategory(ProductCategory productCategory,StoreProductCategory storeProductCategory) {
		
		String idsStr = ","+productCategory.getTreePath()+productCategory.getId()+",,";
		idsStr = StringUtils.substringBetween(idsStr, ",,",",,"); //",1,2,3,"
		
		String[] ids = idsStr.split(",");
		List<ProductCategory> cates = productCategoryService.findInIds(ids);
		StoreProductCategory storeProductCategory1 = null;
		String spPath = ",";
		for (ProductCategory pc : cates) {
			storeProductCategory.setName(pc.getName());
			//StoreProductCategory sPc = storeProductCategoryDao.findNameFirst(pc.getName(), storeProductCategory.getStore().getId());
			List<StoreProductCategory> findname2 = storeProductCategoryDao.findname(storeProductCategory, null, true, null);
			if(findname2.size()<=0) {
				//获取父级id
				storeProductCategory1 = new StoreProductCategory();
				storeProductCategory1.setName(pc.getName());
				storeProductCategory1.setTreePath(spPath);
				storeProductCategory1.setGrade(pc.getGrade());
				storeProductCategory1.setChildren(null);
				storeProductCategory1.setProducts(null);
				storeProductCategory1.setStore(storeProductCategory.getStore());
				storeProductCategory1.setOrder(pc.getOrder());
				if(!spPath.equals(",")) {
					String[] str = spPath.split(",");
					String str1 = str[str.length-1];
					StoreProductCategory find = storeProductCategoryDao.find(Long.parseLong(str1));
					storeProductCategory1.setParent(find);
				}
				storeProductCategoryDao.saveStoreProductCategory(storeProductCategory1);
				spPath += storeProductCategory1.getId()+",";
			}else {
				spPath += findname2.get(0).getId()+",";
			}
		}
		return storeProductCategory1;
	}
	/**
	 *yi 名称查询分类
	 */
	public List<StoreProductCategory> findName(StoreProductCategory storeProductCategory,Store store){
		return storeProductCategoryDao.findname(storeProductCategory, store, true, null);
	}
	

}
