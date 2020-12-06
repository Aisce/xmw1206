/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 0+n855TnmZ+sy3EmADd33Ls8Q67YoPsw
 */
package net.shopxx.event;

import net.shopxx.entity.User;

/**
 * Event - 用户登录
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class UserLoggedInEvent extends UserEvent {

	private static final long serialVersionUID = 3087635924598684802L;

	/**
	 * 构造方法
	 * 
	 * @param source
	 *            事件源
	 * @param user
	 *            用户
	 */
	public UserLoggedInEvent(Object source, User user) {
		super(source, user);
	}

}