/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: wHFnKTLPGAT50rNbhH3P3q3nf/cZzi90
 */
package net.shopxx.controller.admin;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Admin;
import net.shopxx.entity.DemandManagement;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.DemandManagementService;

/**
 * Controller - 新品发布控制层
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminDemandManagementController")
@RequestMapping("/admin/demand_management")
public class DemandManagementController extends BaseController {
	@Inject
	private DemandManagementService adminDemandManagement;
	/**
	 * 
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		//获取分页数据
		Page<DemandManagement> findPage = adminDemandManagement.findPage(pageable);
		model.addAttribute("page", findPage);
		return "admin/demandManagement/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		adminDemandManagement.delete(ids);
		return Results.OK;
	}
	/**
	 * 跳转添加页面
	 */
	@GetMapping("/add")
	public String add(ModelMap model){
		return "admin/demandManagement/add";
		
	}
	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		DemandManagement find = adminDemandManagement.find(id);
		model.addAttribute("DemandManagement", find);
		return "admin/demandManagement/edit";
	}
	/**
	 * 保存
	 * @currentUser 用户信息
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(DemandManagement demandManagement, @CurrentUser Admin currentUser) {
		//获取用户信息
		System.out.println(currentUser.getUsername());
		adminDemandManagement.save(demandManagement);
		return Results.OK;
	}
	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(DemandManagement demandManagement, Long articleCategoryId, Long[] articleTagIds,@CurrentUser Admin currentUser) {
		if (!isValid(demandManagement)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		//以id获取最新信息
		DemandManagement find = adminDemandManagement.find(demandManagement.getId());
		//将实体对象拷贝到查询出的对象中
		
		org.springframework.beans.BeanUtils.copyProperties(demandManagement, find);
		demandManagement.setUpdateDate(new Date());
		//添加修改人
		demandManagement.setUpdateUser(currentUser.getUsername());
		adminDemandManagement.update(find);
		return Results.OK;
	}
	/**
	 * 查看
	 */
	@GetMapping("/show")
	public String show(Long id, ModelMap model) {
		DemandManagement find = adminDemandManagement.find(id);
		model.addAttribute("DemandManagement", find);
		return "admin/demandManagement/show";
	}


	
}