/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 4MlbAT+/MMKtv/Z+8k1NKc/fvQJhiCWq
 */
package net.shopxx.controller.admin;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.service.PluginService;

/**
 * Controller - 登录插件
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminLoginPluginController")
@RequestMapping("/admin/login_plugin")
public class LoginPluginController extends BaseController {

	@Inject
	private PluginService pluginService;

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(ModelMap model) {
		model.addAttribute("loginPlugins", pluginService.getLoginPlugins());
		return "admin/login_plugin/list";
	}

}