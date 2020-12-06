/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: ZQB1xPNAjRr/gFdRh8F2BtzOjNXpjXg/
 */
package net.shopxx.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.CategoryApplication;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.Member;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Store;
import net.shopxx.entity.Store.Status;
import net.shopxx.entity.Store.Type;

/**
 * Dao - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MechanismStoreDao extends BaseDao<MechanismStore, Long> {

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
	 * 查找店铺数量
	 * 
	 * @param type
	 *            类型
	 * @param status
	 *            状态
	 * @param isEnabled
	 *            是否启用
	 * @param hasExpired
	 *            是否过期
	 * @return 店铺数量
	 */
	Long count(MechanismStore.Type type,Boolean isEnabled, Boolean hasExpired);
	public List<MechanismStore> search(String keyword, Integer count,MechanismStore.Type type);
	
	List<MechanismStore> findStoreId(Member member);

}