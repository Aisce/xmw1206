/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: MjGlZdZAKXqhcOQVgu4U0cxMbqyChC/S
 */
package net.shopxx.controller.shop;

import java.util.HashMap;
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
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Information;
import net.shopxx.service.InformationService;

/**
 * Controller - 新品发布
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopInformationController")
@RequestMapping("/information")
public class InformationController extends BaseController {

	/**
	 * 每页记录数
	 */
	private static final int PAGE_SIZE = 6;
	/**
	 * 注入业务层
	 */
	@Inject
	private InformationService informationService;

	/**
	 * 详情
	 */
	@GetMapping("/detail")
	public String detail(Long informationId, ModelMap model) {
		Information information = informationService.find(informationId);
		model.addAttribute("information", information);
		return "shop/information/detail";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Information entity,Integer pageNumber, ModelMap model) {
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		Page<Information> findPage = informationService.findPage(entity,pageable);
		//获取优秀产品推荐
		model.addAttribute("page",findPage);
		return "shop/information/list";
	}

	/**
	 * 列表
	 *//*
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@JsonView(BaseEntity.BaseView.class)
	public ResponseEntity<?> list(Integer pageNumber) {
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		Page<NewLaunch> findPage = adNewReleaseService.findPage(pageable);
		return ResponseEntity.ok(findPage.getContent());
	}*/

	/**
	 * 搜索
	 */
	@GetMapping("/search")
	public String search(String keyword, Integer pageNumber, ModelMap model) {
		if (StringUtils.isEmpty(keyword)) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		Page<Information> search = informationService.search(keyword, pageable);
		model.addAttribute("articleKeyword", keyword);
		model.addAttribute("page", search);
		return "shop/article/search";
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
		return ResponseEntity.ok(informationService.search(keyword, pageable).getContent());
	}

	/**
	 * 点击数
	 */
	@GetMapping("/hits/{articleId}")
	public ResponseEntity<?> hits(@PathVariable Long articleId) {
		if (articleId == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}

		Map<String, Object> data = new HashMap<>();
		data.put("hits", informationService.viewHits(articleId));
		return ResponseEntity.ok(data);
	}

}