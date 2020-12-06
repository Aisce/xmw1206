/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: QGdigbR0tu+f/OMjyetYKqkBnggJ+wh+
 */
package net.shopxx.controller.shop;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Order;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.XmNavigationGroup;
import net.shopxx.service.XmNavigationGroupService;

/**
 * Controller - 友情链接
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopXmNavigationController")
@RequestMapping("/xm_navigation")
public class XmNavigationController extends BaseController {
	
	@Inject
	private XmNavigationGroupService navigationGroupService;
	
	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		
		pageable.setOrderProperty("paixu");
		pageable.setOrderDirection(Order.Direction.ASC);
		
		Page<XmNavigationGroup> findPage = navigationGroupService.findPage(pageable);
		//获取数据结构
		List<XmNavigationGroup> content = findPage.getContent();
		
		model.addAttribute("page", navigationGroupService.findPage(pageable));
		return "shop/xm_navigation/list";
	}
	
}