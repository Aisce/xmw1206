/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: Wnns2PDs0BiWlRDyaMrTutZ2pPbBIGfq
 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Business;
import net.shopxx.entity.UploadLog;

/**
 * Service - 消息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface UploadLogService extends BaseService<UploadLog, Long> {

	/**
	 * 查找
	 * 
	 * @param messageGroup
	 *            消息组
	 * @param user
	 *            用户
	 * @return 消息
	 */
	List<UploadLog> findList(UploadLog uploadLog, Business user);
	public Page<UploadLog> findPage(Pageable pageable,Business user);
	
	/**
	 * 修改
	 * @return 
	 */
	public void modify (UploadLog uploadLog);
	
}