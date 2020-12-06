/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: DWrDL9/6cFRIuNenry+lNIaZ1AbpavpD
 */
package net.shopxx.service;


import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Member;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;

/**
 * Service - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface SampleService extends BaseService<Sample, Long> {
	Page<Sample> findPage(Pageable pageable,Member CurrentUser,Store store);
}