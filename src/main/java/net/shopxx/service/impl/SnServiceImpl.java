/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: yNKNxAjr0ka9UtoNa4rUpJ70IH2mWOMS
 */
package net.shopxx.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.dao.SnDao;
import net.shopxx.entity.Sn;
import net.shopxx.service.SnService;

/**
 * Service - 序列号
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class SnServiceImpl implements SnService {

	@Inject
	private SnDao snDao;

	@Override
	@Transactional
	public String generate(Sn.Type type) {
		return snDao.generate(type);
	}

}