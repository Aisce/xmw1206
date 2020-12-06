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
import net.shopxx.dao.MechanismDao;
import net.shopxx.dao.MemberDao;
import net.shopxx.entity.Business;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;
import net.shopxx.entity.User.Type;
import net.shopxx.service.MechanismService;

/**
 * Service - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class MechanismServiceImpl extends BaseServiceImpl<Mechanism, Long> implements MechanismService {

	/**
	 * E-mail身份配比
	 */
	private static final Pattern EMAIL_PRINCIPAL_PATTERN = Pattern.compile(".*@.*");

	/**
	 * 手机身份配比
	 */
	private static final Pattern MOBILE_PRINCIPAL_PATTERN = Pattern.compile("\\d+");

	@Inject
	private MechanismDao mechanismDao;
	@Inject
	private MemberDao memberDao;

	public List<Member> search(String keyword, Integer count,User.Type type){
		return mechanismDao.search(keyword, count,type);
	}

	@Override
	public void updateUser(Mechanism mechanism, String str) {
		// TODO Auto-generated method stub
		mechanismDao.updateUser(mechanism, str);
	}

	@Override
	public List<Member> findPage(Pageable pageable, Type type) {
		// TODO Auto-generated method stub
		return mechanismDao.findPage(type, pageable);
	}

	@Override
	public boolean nameUnique(Long id, String name) {
		// TODO Auto-generated method stub
		boolean unique = memberDao.unique(id, "username", name, true);
		return unique;
	}
	//手机号比对
	public boolean phoneUnique(Long id, String name) {
		// TODO Auto-generated method stub
		return memberDao.unique(id, "mobile", name, true);
	}
	public boolean emileUnique(Long id, String name) {
		// TODO Auto-generated method stub
		return memberDao.unique(id, "email", name, true);
	}
	

}