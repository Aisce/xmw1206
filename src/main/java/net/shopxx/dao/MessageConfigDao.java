/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 4uZkgBKv+y5xSF0NDFo7hk3opJj0rmgQ
 */
package net.shopxx.dao;

import net.shopxx.entity.MessageConfig;

/**
 * Dao - 消息配置
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MessageConfigDao extends BaseDao<MessageConfig, Long> {

	/**
	 * 查找消息配置
	 * 
	 * @param type
	 *            类型
	 * @return 消息配置
	 */
	MessageConfig find(MessageConfig.Type type);

}