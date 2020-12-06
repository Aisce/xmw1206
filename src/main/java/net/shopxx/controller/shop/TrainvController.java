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

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Trainv;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Member;
import net.shopxx.exception.ResourceNotFoundException;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.TrainvService;

/**
 * Controller - 培训
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopTrainvController")
@RequestMapping("/trainv")
public class TrainvController extends BaseController {

	/**
	 * 每页记录数
	 */
	private static final int PAGE_SIZE = 20;

	@Inject
	private TrainvService trainvService;

	/**
	 * 详情
	 */
	@GetMapping("/detail/{trainvId}_{pageNumber}")
	public String detail(@PathVariable Long trainvId, @PathVariable Integer pageNumber, ModelMap model,@CurrentUser Member currentUser) {
		Trainv trainv = trainvService.find(trainvId);
		if (trainv == null || pageNumber < 1 || pageNumber > trainv.getTotalPages()) {
			throw new ResourceNotFoundException();
		}
		model.addAttribute("trainv", trainv);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("currentUser", currentUser);
		return "shop/trainv/detail";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Integer pageNumber, ModelMap model) {
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		model.addAttribute("page", trainvService.findPage(true, pageable));
		return "shop/trainv/list";
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
		model.addAttribute("trainvKeyword", keyword);
		model.addAttribute("page", trainvService.search(keyword, pageable));
		return "shop/trainv/search";
	}

	/**
	 * 点击数
	 */
	@GetMapping("/hits/{trainvId}")
	public ResponseEntity<?> hits(@PathVariable Long trainvId) {
		if (trainvId == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}

		Map<String, Object> data = new HashMap<>();
		data.put("hits", trainvService.viewHits(trainvId));
		return ResponseEntity.ok(data);
	}

}