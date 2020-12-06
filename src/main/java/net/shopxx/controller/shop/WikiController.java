/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: MjGlZdZAKXqhcOQVgu4U0cxMbqyChC/S
 */
package net.shopxx.controller.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.annotation.JsonView;

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Wiki;
import net.shopxx.entity.WikiCategory;
import net.shopxx.entity.BaseEntity;
import net.shopxx.exception.ResourceNotFoundException;
import net.shopxx.service.WikiCategoryService;
import net.shopxx.service.WikiService;

/**
 * Controller - 文章
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopWikiController")
@RequestMapping("/wiki")
public class WikiController extends BaseController {

	/**
	 * 每页记录数
	 */
	private static final int PAGE_SIZE = 20;

	@Inject
	private WikiService wikiService;
	@Inject
	private WikiCategoryService wikiCategoryService;

	/**
	 * 详情
	 */
	@GetMapping("/detail/{wikiId}_{pageNumber}")
	public String detail(@PathVariable Long wikiId, @PathVariable Integer pageNumber, ModelMap model) {
		Wiki wiki = wikiService.find(wikiId);
		if (wiki == null || pageNumber < 1 || pageNumber > wiki.getTotalPages()) {
			throw new ResourceNotFoundException();
		}
		model.addAttribute("wiki", wiki);
		model.addAttribute("pageNumber", pageNumber);
		return "shop/wiki/detail";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list/{wikiCategoryId}")
	public String list(@PathVariable Long wikiCategoryId, Integer pageNumber, ModelMap model) {
		WikiCategory wikiCategory = wikiCategoryService.find(wikiCategoryId);
		if (wikiCategory == null) {
			throw new ResourceNotFoundException();
		}
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		model.addAttribute("wikiCategory", wikiCategory);
		model.addAttribute("page", wikiService.findPage(wikiCategory, null, true, pageable));
		return "shop/wiki/list";
	}
	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Integer pageNumber, ModelMap model) {
		List<WikiCategory> findAll = wikiCategoryService.findAll();
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		model.addAttribute("wikiCategory", findAll);
		model.addAttribute("page", wikiService.findPage(findAll.get(0), null, true, pageable));
		return "shop/wiki/list";
	}

	/**
	 * 列表
	 */
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@JsonView(BaseEntity.BaseView.class)
	public ResponseEntity<?> list(Long wikiCategoryId, Integer pageNumber) {
		WikiCategory wikiCategory = wikiCategoryService.find(wikiCategoryId);
		if (wikiCategory == null) {
			return Results.NOT_FOUND;
		}

		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		return ResponseEntity.ok(wikiService.findPage(wikiCategory, null, true, pageable).getContent());
	}

	/**
	 * 搜索
	 */
	@GetMapping("/search")
	public String search(String keyword, Integer pageNumber, ModelMap model) {
		if (StringUtils.isEmpty(keyword)) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		model.addAttribute("wikiKeyword", keyword);
		model.addAttribute("page", wikiService.search(keyword, pageable));
		return "shop/wiki/search";
	}

	/**
	 * 搜索
	 */
	@GetMapping(path = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@JsonView(BaseEntity.BaseView.class)
	public ResponseEntity<?> search(String keyword, Integer pageNumber) {
		if (StringUtils.isEmpty(keyword)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		return ResponseEntity.ok(wikiService.search(keyword, pageable).getContent());
	}

	/**
	 * 点击数
	 */
	@GetMapping("/hits/{wikiId}")
	public ResponseEntity<?> hits(@PathVariable Long wikiId) {
		if (wikiId == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}

		Map<String, Object> data = new HashMap<>();
		data.put("hits", wikiService.viewHits(wikiId));
		return ResponseEntity.ok(data);
	}

}