/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: +aj8JE1ybzrw1Q8/0N7xJP027a/LuICl
 */
package net.shopxx.service;

import net.shopxx.entity.Distributor;
import net.shopxx.entity.Member;

/**
 * Service - 分销员
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface DistributorService extends BaseService<Distributor, Long> {

	/**
	 * 创建
	 * 
	 * @param member
	 *            会员
	 */
	void create(Member member);

	/**
	 * 创建
	 * 
	 * @param member
	 *            会员
	 * @param spreadMember
	 *            推广会员
	 */
	void create(Member member, Member spreadMember);

	/**
	 * 修改
	 * 
	 * @param distributor
	 *            分销员
	 * @param spreadMember
	 *            推广会员
	 */
	void modify(Distributor distributor, Member spreadMember);

}