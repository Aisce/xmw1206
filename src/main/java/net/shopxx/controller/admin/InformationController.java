/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PAanoUCJR1NueFTifcDsR6Uq+nc8nlpI
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
import net.shopxx.entity.Information;
import net.shopxx.service.InformationService;

/**
 * Controller - 芯梦观点
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("AdminInformationController")
@RequestMapping("/admin/information")
public class InformationController extends BaseController {

	@Inject
	private InformationService informationService;

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		return "admin/information/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(Information information) {
		if (!isValid(information)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		information.setHits(0L);
		informationService.save(information);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("information", informationService.find(id));
		return "admin/information/edit";
	}
	
	/**
	 * 查看
	 */
	@GetMapping("/show")
	public String show(Long id, ModelMap model) {
		Information find = informationService.find(id);
		model.addAttribute("information", find);
		return "admin/information/show";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(Information information) {
		if (!isValid(information)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		informationService.update(information, "hits");
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", informationService.findPage(pageable));
		return "admin/information/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		informationService.delete(ids);
		return Results.OK;
	}

}