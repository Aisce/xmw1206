/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 0ztlvrE6uPWc21LdaGRIwPq1wg5V6wWl
 */
package net.shopxx.controller.member;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Business;
import net.shopxx.entity.DeliveryCorp;
import net.shopxx.entity.Member;
import net.shopxx.entity.OrderProgress;
import net.shopxx.entity.Sample;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.DeliveryCorpService;
import net.shopxx.service.SampleService;

/**
 * Controller - 商品
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("memberSampleController")
@RequestMapping("/member/sample")
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
	public String list(Pageable pageable,@CurrentUser Member currentUser,ModelMap model) {
		Page<Sample> findPage = sampleService.findPage(pageable,currentUser,null);
		model.addAttribute("page", findPage);
		return "member/sample/list";
	}
	/**
	 * 以id获取
	 */
	@PostMapping("/list_progress")
	public @ResponseBody Map<String, Object> listProgress(Long productId) {
		
		Map<String, Object> data = new HashMap<>();
		
		if(productId == null || productId <= 0){
			return null;
		}
		Sample find = sampleService.find(productId);
		//以运单id获取快递公司名
		DeliveryCorp find2 = deliveryCorpService.find(Long.parseLong(find.getKuaidiCompany()));
		if(null!=find2) {
			find.setKuaidiCompany(find2.getName());
		}
		data.put("kuaidiCompany", find.getKuaidiCompany());
		data.put("orderNubmer", find.getOrderNubmer());
		return data;
	}
	//获取不通过的原因
	@PostMapping("/progress")
	public @ResponseBody Map<String, Object> progress(Long productId) {
		
		Map<String, Object> data = new HashMap<>();
		
		if(productId == null || productId <= 0){
			return null;
		}
		Sample find = sampleService.find(productId);
		
		data.put("kuaidiCompany", find.getReason());
		return data;
	}
}