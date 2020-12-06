/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: Z7KL+jrs53bTZ6q673uQhZmF9TLzsU5D
 */
package net.shopxx.controller.admin;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Navigation;
import net.shopxx.entity.XmNavigation;
import net.shopxx.service.ArticleCategoryService;
import net.shopxx.service.NavigationGroupService;
import net.shopxx.service.NavigationService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.XmNavigationGroupService;
import net.shopxx.service.XmNavigationService;

/**
 * Controller - 导航
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminXmNavigationController")
@RequestMapping("/admin/xm_navigation")
public class XmNavigationController extends BaseController {

	@Inject
	private XmNavigationService navigationService;
	@Inject
	private XmNavigationGroupService navigationGroupService;

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("navigationGroups", navigationGroupService.findAll());
		return "admin/xm_navigation/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(XmNavigation navigation, Long navigationGroupId) {
		navigation.setNavigationGroup(navigationGroupService.find(navigationGroupId));
		if (!isValid(navigation)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		navigationService.save(navigation);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("navigation", navigationService.find(id));
		model.addAttribute("navigationGroups", navigationGroupService.findAll());
		return "admin/xm_navigation/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(XmNavigation navigation, Long navigationGroupId) {
		navigation.setNavigationGroup(navigationGroupService.find(navigationGroupId));
		if (!isValid(navigation)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		navigationService.update(navigation);
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", navigationService.findPage(pageable));
		return "admin/xm_navigation/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		navigationService.delete(ids);
		return Results.OK;
	}

}