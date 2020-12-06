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
import net.shopxx.entity.Member;
import net.shopxx.entity.Trainv;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.TrainvService;

/**
 * Controller - 芯梦培训
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("NewTrainvController")
@RequestMapping("/new_trainv")
public class NewTrainvController extends BaseController {

	/**
	 * 每页记录数
	 */
	private static final int PAGE_SIZE = 6;
	/**
	 * 注入业务层
	 */
	@Inject
	private TrainvService trainvService;

	/**
	 * 详情
	 */
	@GetMapping("/detail")
	public String detail(Long trainvId,ModelMap model,@CurrentUser Member currentUser) {
		Trainv trainv = trainvService.find(trainvId);
		model.addAttribute("trainv", trainv);
		model.addAttribute("currentUser", currentUser);
		return "shop/new_trainv/detail";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Trainv entity,Integer pageNumber, ModelMap model) {
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		Page<Trainv> findPage = trainvService.findPage(entity,pageable);
		model.addAttribute("page",findPage);
		return "shop/new_trainv/list";
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
		Page<Trainv> search = trainvService.search(keyword, pageable);
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
		return ResponseEntity.ok(trainvService.search(keyword, pageable).getContent());
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
		data.put("hits", trainvService.viewHits(articleId));
		return ResponseEntity.ok(data);
	}

}