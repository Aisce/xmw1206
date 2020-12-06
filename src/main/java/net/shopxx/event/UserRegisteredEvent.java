/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 8yPKqvqj9KPkNOJQbUuQp5h7xq2XGJty
 */
package net.shopxx.event;

import net.shopxx.entity.User;

/**
 * Event - 用户注册
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class UserRegisteredEvent extends UserEvent {

	private static final long serialVersionUID = 3930447081075693577L;

	/**
	 * 构造方法
	 * 
	 * @param source
	 *            事件源
	 * @param user
	 *            用户
	 */
	public UserRegisteredEvent(Object source, User user) {
		super(source, user);
	}

}