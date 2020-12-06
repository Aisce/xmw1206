/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: qDRdnb/X4uh9HNWxXM3tnUk0TBVfvC/l
 */
package net.shopxx.service.impl;

import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.MechanismArticleDao;
import net.shopxx.dao.MechanismDao;
import net.shopxx.entity.Business;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.MechanismArticle;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;
import net.shopxx.entity.User.Type;
import net.shopxx.service.MechanismArticleService;
import net.shopxx.service.MechanismService;

/**
 * Service - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class MechanismArticleServiceImpl extends BaseServiceImpl<MechanismArticle, Long> implements MechanismArticleService {


	@Inject
	private MechanismArticleDao mechanismArticleDao;

	public List<MechanismArticle> search(MechanismArticle.Type type){
		return mechanismArticleDao.search(type);
	}

}