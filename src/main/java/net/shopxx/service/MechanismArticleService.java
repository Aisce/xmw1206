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
import net.shopxx.entity.MechanismArticle;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;

/**
 * Service - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MechanismArticleService extends BaseService<MechanismArticle, Long> {
	public List<MechanismArticle> search(MechanismArticle.Type type);
	
}