/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: kkTggkjhgau/Bk406Esg9Aw7u+kZiwjL
 */
package net.shopxx.security;

import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.context.ApplicationEventPublisher;

import net.shopxx.entity.User;
import net.shopxx.event.UserLoggedOutEvent;
import net.shopxx.service.UserService;

/**
 * Security - 注销过滤器
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class LogoutFilter extends org.apache.shiro.web.filter.authc.LogoutFilter {

	@Inject
	private ApplicationEventPublisher applicationEventPublisher;
	@Inject
	private UserService userService;

	/**
	 * 请求前处理
	 * 
	 * @param servletRequest
	 *            ServletRequest
	 * @param servletResponse
	 *            ServletResponse
	 * @return 是否继续执行
	 */
	@Override
	protected boolean preHandle(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
		User currentUser = userService.getCurrent();
		applicationEventPublisher.publishEvent(new UserLoggedOutEvent(this, currentUser));

		return super.preHandle(servletRequest, servletResponse);
	}

}