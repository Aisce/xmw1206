/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: cW5a5n7XMXcgh0lx4WaOAn9Z8g8wHhyB
 */
package net.shopxx.service;


import java.util.List;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;

/**
 * Service - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MechanismService extends BaseService<Mechanism, Long> {
	public List<Member> search(String keyword, Integer count,User.Type type);
	
	//手动修改角色信息
	public void updateUser(Mechanism mechanism,String str);
	
	//以状态查询列表数据
	public List<Member> findPage(Pageable pageable,User.Type type);

	public boolean nameUnique(Long id, String name);
	public boolean phoneUnique(Long id, String name);
	public boolean emileUnique(Long id, String name);
	
}