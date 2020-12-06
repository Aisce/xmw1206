/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PhnP8PErf+mmgdn29g/Gy0DQHCxXlg0e
 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.MechanismArticle;
import net.shopxx.entity.Member;
import net.shopxx.entity.User;

/**
 * Dao - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface MechanismArticleDao extends BaseDao<MechanismArticle, Long> {

	List<MechanismArticle> search(MechanismArticle.Type type);

}