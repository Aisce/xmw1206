/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: Y/yOZpfcBS8fHH1bp2mt6FDtjFi/W1rk
 */
package net.shopxx.dao.impl;

import javax.persistence.NoResultException;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.dao.StorePluginStatusDao;
import net.shopxx.entity.Store;
import net.shopxx.entity.StorePluginStatus;

/**
 * Dao - 店铺插件状态
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class StorePluginStatusDaoImpl extends BaseDaoImpl<StorePluginStatus, Long> implements StorePluginStatusDao {

	public StorePluginStatus find(Store store, String pluginId) {
		if (store == null || StringUtils.isEmpty(pluginId)) {
			return null;
		}
		try {
			String jpql = "select storePluginStatus from StorePluginStatus storePluginStatus where storePluginStatus.store = :store and storePluginStatus.pluginId = :pluginId";
			return entityManager.createQuery(jpql, StorePluginStatus.class).setParameter("store", store).setParameter("pluginId", pluginId).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}
}