/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 56+DVtRTQijTRUv8ccOFQ3vs/r3m5ZbW
 */
package net.shopxx.controller.admin;

import java.util.List;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Results;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.service.WikiCategoryService;

/**
 * Controller - 文章分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminWikiCategoryController")
@RequestMapping("/admin/wiki_category")
public class WikiCategoryController extends BaseController {

	@Inject
	private WikiCategoryService wikiCategoryService;

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("wikiCategoryTree", wikiCategoryService.findTree());
		return "admin/wiki_category/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(WikiCategory wikiCategory, Long parentId) {
		wikiCategory.setParent(wikiCategoryService.find(parentId));
		if (!isValid(wikiCategory)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		wikiCategory.setTreePath(null);
		wikiCategory.setGrade(null);
		wikiCategory.setChildren(null);
		wikiCategory.setWikis(null);
		wikiCategoryService.save(wikiCategory);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		WikiCategory wikiCategory = wikiCategoryService.find(id);
		model.addAttribute("wikiCategoryTree", wikiCategoryService.findTree());
		model.addAttribute("wikiCategory", wikiCategory);
		model.addAttribute("children", wikiCategoryService.findChildren(wikiCategory, true, null));
		return "admin/wiki_category/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(WikiCategory wikiCategory, Long parentId) {
		wikiCategory.setParent(wikiCategoryService.find(parentId));
		if (!isValid(wikiCategory)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (wikiCategory.getParent() != null) {
			WikiCategory parent = wikiCategory.getParent();
			if (parent.equals(wikiCategory)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			List<WikiCategory> children = wikiCategoryService.findChildren(parent, true, null);
			if (children != null && children.contains(parent)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
		}
		wikiCategoryService.update(wikiCategory, "treePath", "grade", "children", "wikis");
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(ModelMap model) {
		model.addAttribute("wikiCategoryTree", wikiCategoryService.findTree());
		return "admin/wiki_category/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long id) {
		WikiCategory wikiCategory = wikiCategoryService.find(id);
		if (wikiCategory == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		Set<WikiCategory> children = wikiCategory.getChildren();
		if (children != null && !children.isEmpty()) {
			return Results.unprocessableEntity("admin.wikiCategory.deleteExistChildrenNotAllowed");
		}
		Set<Wiki> wikis = wikiCategory.getWikis();
		if (wikis != null && !wikis.isEmpty()) {
			return Results.unprocessableEntity("admin.wikiCategory.deleteExistWikiNotAllowed");
		}
		wikiCategoryService.delete(id);
		return Results.OK;
	}

}