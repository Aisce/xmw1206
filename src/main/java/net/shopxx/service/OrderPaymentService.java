/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 2lkQ1oLAvmvNe6mypoB8e7/IQaBmNBNo
 */
package net.shopxx.service;

import net.shopxx.entity.OrderPayment;

/**
 * Service - 订单支付
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface OrderPaymentService extends BaseService<OrderPayment, Long> {

	/**
	 * 根据编号查找订单支付
	 * 
	 * @param sn
	 *            编号(忽略大小写)
	 * @return 订单支付，若不存在则返回null
	 */
	OrderPayment findBySn(String sn);

}