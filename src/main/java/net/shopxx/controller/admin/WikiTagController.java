/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: wrS5bGbggvMIlwbYarcl+cKeV1sfu/kJ
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
import net.shopxx.entity.WikiTag;
import net.shopxx.entity.BaseEntity;
import net.shopxx.service.WikiTagService;

/**
 * Controller - 文章标签
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminWikiTagController")
@RequestMapping("/admin/wiki_tag")
public class WikiTagController extends BaseController {

	@Inject
	private WikiTagService wikiTagService;

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		return "admin/wiki_tag/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(WikiTag wikiTag) {
		if (!isValid(wikiTag, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		wikiTag.setWikis(null);
		wikiTagService.save(wikiTag);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("wikiTag", wikiTagService.find(id));
		return "admin/wiki_tag/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(WikiTag wikiTag) {
		if (!isValid(wikiTag)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		wikiTagService.update(wikiTag, "wikis");
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", wikiTagService.findPage(pageable));
		return "admin/wiki_tag/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		wikiTagService.delete(ids);
		return Results.OK;
	}

}