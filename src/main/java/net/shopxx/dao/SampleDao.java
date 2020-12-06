/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: d5yaR9qn/h44LkOBQ2KHJd26RBx5Rs6U
 */
package net.shopxx.dao;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Member;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;

/**
 * Dao - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface SampleDao extends BaseDao<Sample, Long> {
	Page<Sample> findPage(Pageable pageable,Member currentUser,Store store);
}