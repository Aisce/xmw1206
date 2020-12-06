/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: GueuG/rWQ6Hp0roZwfsqcg2MDHOWaxT1
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

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.MechanismArticle;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.MechanismStore.Type;
import net.shopxx.service.MechanismArticleService;
import net.shopxx.service.MechanismStoreService;

/**
 * Controller - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminMechanismArticleController")
@RequestMapping("/admin/mechanism_article")
public class MechanismArticleController extends BaseController {

	@Inject
	private MechanismArticleService mechanismArticleService;

	/**
	 * 查看
	 */
	@GetMapping("/view")
	public String view(Long id, ModelMap model) {
		MechanismArticle find = mechanismArticleService.find(id);
		model.addAttribute("store", find);
		return "admin/mechanism_article/view";
	}

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		net.shopxx.entity.MechanismArticle.Type[] values = MechanismArticle.Type.values();
		model.addAttribute("types", values);
		return "admin/mechanism_article/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(MechanismArticle mechanismArticle) {
		if (!isValid(mechanismArticle, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		mechanismArticleService.save(mechanismArticle);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("store", mechanismArticleService.find(id));
		model.addAttribute("types", MechanismStore.Type.values());
		return "admin/mechanism_article/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(MechanismArticle mechanismArticle,Long id) {
		MechanismArticle find = mechanismArticleService.find(id);
		find.setContent(mechanismArticle.getContent());
		if (!isValid(find, BaseEntity.Update.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		mechanismArticleService.update(find);
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(MechanismArticle.Type type, Boolean isFine, Boolean isEnabled, Boolean hasExpired, Pageable pageable, ModelMap model) {
		model.addAttribute("type", type);
		model.addAttribute("page", mechanismArticleService.findPage(pageable));
		return "admin/mechanism_article/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		if (ids != null) {
			mechanismArticleService.delete(ids);
		}
		return Results.OK;
	}
}