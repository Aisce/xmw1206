/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: PAanoUCJR1NueFTifcDsR6Uq+nc8nlpI
 */
package net.shopxx.controller.admin;

import java.util.HashSet;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Wiki;
import net.shopxx.service.WikiCategoryService;
import net.shopxx.service.WikiService;
import net.shopxx.service.WikiTagService;

/**
 * Controller - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminWikiController")
@RequestMapping("/admin/wiki")
public class WikiController extends BaseController {

	@Inject
	private WikiService wikiService;
	@Inject
	private WikiCategoryService wikiCategoryService;
	@Inject
	private WikiTagService wikiTagService;

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("wikiCategoryTree", wikiCategoryService.findTree());
		model.addAttribute("wikiTags", wikiTagService.findAll());
		return "admin/wiki/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(Wiki wiki, Long wikiCategoryId, Long[] wikiTagIds) {
		wiki.setWikiCategory(wikiCategoryService.find(wikiCategoryId));
		wiki.setWikiTags(new HashSet<>(wikiTagService.findList(wikiTagIds)));
		if (!isValid(wiki)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		wiki.setHits(0L);
		wikiService.save(wiki);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("wikiCategoryTree", wikiCategoryService.findTree());
		model.addAttribute("wikiTags", wikiTagService.findAll());
		model.addAttribute("wiki", wikiService.find(id));
		return "admin/wiki/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(Wiki wiki, Long wikiCategoryId, Long[] wikiTagIds) {
		wiki.setWikiCategory(wikiCategoryService.find(wikiCategoryId));
		wiki.setWikiTags(new HashSet<>(wikiTagService.findList(wikiTagIds)));
		if (!isValid(wiki)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		wikiService.update(wiki, "hits");
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", wikiService.findPage(pageable));
		return "admin/wiki/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		wikiService.delete(ids);
		return Results.OK;
	}

}