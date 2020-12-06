/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: +xG1fWksx/Pz43zTFboeiMxkDuoCDGHS
 */
package net.shopxx.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.UploadLogDao;
import net.shopxx.entity.Business;
import net.shopxx.entity.UploadLog;
import net.shopxx.service.UploadLogService;

/**
 * Service - 消息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class UploadLogServiceImpl extends BaseServiceImpl<UploadLog, Long> implements UploadLogService {

	@Inject
	private UploadLogDao uploadLogDao;

	@Override
	@Transactional(readOnly = true)
	public List<UploadLog> findList(UploadLog uploadLog, Business user) {
		return uploadLogDao.findList(uploadLog, user);
	}

	@Override
	@Transactional(readOnly = true)
	public Page<UploadLog> findPage(Pageable pageable, Business user) {
		// TODO Auto-generated method stub
		return uploadLogDao.findPage(pageable, user);
	}

	@Override
	@Transactional
	public void modify(UploadLog uploadLog) {
		// TODO Auto-generated method stub
		uploadLogDao.update(uploadLog);
	}
}