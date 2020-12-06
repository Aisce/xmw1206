/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: MjGlZdZAKXqhcOQVgu4U0cxMbqyChC/S
 */
package net.shopxx.controller.shop;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.NewLaunch;
import net.shopxx.entity.Product;
import net.shopxx.service.ProductService;

/**
 * Controller - 索取样品
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopSampleController")
@RequestMapping("/sample")
public class SampleController extends BaseController {

	/**
	 * 每页记录数
	 */
	private static final int PAGE_SIZE = 6;
	/**
	 * 注入业务层
	 */
	@Inject
	private ProductService productService;


	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(NewLaunch launch,Integer pageNumber, ModelMap model) {
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		Page<Product> findPage = productService.findPage(pageable, true,true,true);
		model.addAttribute("page",findPage);
		return "shop/sample/list";
	}
}