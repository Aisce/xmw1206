/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 0ztlvrE6uPWc21LdaGRIwPq1wg5V6wWl
 */
package net.shopxx.controller.business;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;
import net.shopxx.security.CurrentStore;
import net.shopxx.service.DeliveryCorpService;
import net.shopxx.service.SampleService;

/**
 * Controller - 商品
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("businessSampleController")
@RequestMapping("/business/sample")
public class SampleController extends BaseController {

	/**
	 * 最大对比商品数
	 */
	public static final Integer MAX_COMPARE_PRODUCT_COUNT = 4;

	/**
	 * 最大浏览记录商品数
	 */
	public static final Integer MAX_HISTORY_PRODUCT_COUNT = 10;
	@Inject
	private SampleService sampleService;
	@Inject
	private DeliveryCorpService deliveryCorpService;

	/**
	 * 列表 以 用户查询列表分页数据
	 */
	@GetMapping("/list")
	public String list(Pageable pageable,ModelMap model,@CurrentStore Store store) {
		Page<Sample> findPage = sampleService.findPage(pageable,null,store);
		model.addAttribute("page", findPage);
		return "business/sample/list";
	}
	/**
	 * 审核
	 */
	@GetMapping("/edit")
	public String view(Long id, ModelMap model) {
		Sample find = sampleService.find(id);
		model.addAttribute("sample", find);
		model.addAttribute("deliveryCorps", deliveryCorpService.findAll());
		return "business/sample/edit";
	}
	/**
	 * 修改
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(Sample sample, Long id, HttpServletRequest request) {
		Sample find = sampleService.find(id);
		
		find.setFlag(sample.getFlag());
		find.setReason(sample.getReason());
		if(StringUtils.isNoneEmpty(sample.getKuaidiCompany())) {
			find.setKuaidiCompany(sample.getKuaidiCompany());
		}
		if(StringUtils.isNoneEmpty(sample.getOrderNubmer())) {
			find.setOrderNubmer(sample.getOrderNubmer());
		}
		sampleService.update(find);
		return Results.OK;
	}
	
}