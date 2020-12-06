/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: i5wC+Xilt8zbxb76ym18pnhms7Ytw80Z
 */
package net.shopxx.service;

import java.math.BigDecimal;
import java.util.List;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.CategoryApplication;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.Member;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Store;
import net.shopxx.plugin.PromotionPlugin;

/**
 * Service - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MechanismStoreService extends BaseService<MechanismStore, Long> {

	/**
	 * 判断名称是否存在
	 * 
	 * @param name
	 *            名称(忽略大小写)
	 * @return 名称是否存在
	 */
	boolean nameExists(String name);

	/**
	 * 判断名称是否唯一
	 * 
	 * @param id
	 *            ID
	 * @param name
	 *            名称(忽略大小写)
	 * @return 名称是否唯一
	 */
	boolean nameUnique(Long id, String name);

	/**
	 * 根据名称查找店铺
	 * 
	 * @param name
	 *            名称(忽略大小写)
	 * @return 店铺
	 */
	MechanismStore findByName(String name);

	/**
	 * 查找店铺
	 * 
	 * @param type
	 *            类型
	 * @param status
	 *            状态
	 * @param isEnabled
	 *            是否启用
	 * @param hasExpired
	 *            是否过期
	 * @param first
	 *            起始记录
	 * @param count
	 *            数量
	 * @return 店铺
	 */
	List<MechanismStore> findList(MechanismStore.Type type,Boolean isEnabled, Boolean hasExpired, Integer first, Integer count);


	/**
	 * 查找店铺分页
	 * 
	 * @param type
	 *            类型
	 * @param status
	 *            状态
	 * @param isEnabled
	 *            是否启用
	 * @param hasExpired
	 *            是否过期
	 * @param pageable
	 *            分页信息
	 * @return 店铺分页
	 */
	Page<MechanismStore> findPage(MechanismStore.Type type,Boolean isEnabled, Boolean hasExpired, Pageable pageable);

	/**
	 * 搜索店铺分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 店铺分页
	 */
	Page<MechanismStore> search(String keyword, Pageable pageable);
	/**
	 * 搜索店铺分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 店铺分页
	 */
	List<MechanismStore> search(String keyword, Integer count,MechanismStore.Type type);

	/**
	 * 搜索店铺集合
	 * 
	 * @param keyword
	 *            关键词
	 * @return 店铺集合
	 */
	List<MechanismStore> search(String keyword);

	/**
	 * 获取当前登录商家店铺
	 * 
	 * @return 当前登录商家店铺，若不存在则返回null
	 */
	MechanismStore getCurrent();
	
	/**
	 * 审核
	 * 
	 * @param store
	 *            店铺
	 * @param passed
	 *            是否审核成功
	 * @param content
	 *            审核失败内容
	 */
	void review(MechanismStore store, boolean passed, String content);
	
	/**
	 * 以用户id获取机构店铺信息
	 */
	List<MechanismStore> findStoreId(Member member);
}