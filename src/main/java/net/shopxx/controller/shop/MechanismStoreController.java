/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: GueuG/rWQ6Hp0roZwfsqcg2MDHOWaxT1
 */
package net.shopxx.controller.shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.MechanismArticle;
import net.shopxx.entity.MechanismStore;
import net.shopxx.service.MechanismArticleService;
import net.shopxx.service.MechanismStoreService;

/**
 * Controller - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopMechanismStoreController")
@RequestMapping("/shop/mechanism_store")
public class MechanismStoreController extends BaseController {

	@Inject
	private MechanismStoreService mechanismStoreService;
	@Inject
	private MechanismArticleService mechanismArticleService;
	/**
	 * 标准化机构列表
	 */
	@GetMapping("/list")
	public String list(MechanismStore.Type type, Boolean isFine, Boolean isEnabled, Boolean hasExpired, Pageable pageable, ModelMap model) {
		Page<MechanismStore> findPage = mechanismStoreService.findPage(type.STANDARDIZATION,isEnabled, hasExpired, pageable);
		//获取所有标准化机构的内容
		List<MechanismArticle> search = mechanismArticleService.search(MechanismArticle.Type.STANDARDIZATION);
		if(search.size()>0) {
			model.addAttribute("search", search.get(0));
		}
		
		model.addAttribute("page", findPage);
		return "shop/mechanism_store/list";
	}
	
	/**
	 * 检测机构列表
	 */
	@GetMapping("/check_list")
	public String checkList(MechanismStore.Type type, Boolean isFine, Boolean isEnabled, Boolean hasExpired, Pageable pageable, ModelMap model) {
		Page<MechanismStore> findPage = mechanismStoreService.findPage(type.CHECK,isEnabled, hasExpired, pageable);
		
		//获取所有标准化机构的内容
		List<MechanismArticle> search = mechanismArticleService.search(MechanismArticle.Type.CHECK);
		if(search.size()>0) {
			model.addAttribute("search", search.get(0));
		}
		
		model.addAttribute("page", findPage);
		return "shop/mechanism_store/check_list";
	}
	
	/**
	 * 	检测机构列表
	 */
	@GetMapping("/checkPage")
	public String checkPage(Long id,ModelMap model,Pageable pageable) {
		MechanismStore find = mechanismStoreService.find(id);
		Page<MechanismStore> findPage = mechanismStoreService.findPage(MechanismStore.Type.CHECK,null, null, pageable);
		model.addAttribute("page", find);
		model.addAttribute("findPage", findPage);
		
		return "shop/mechanism_store/check_page";
	}
	/**
	 * 	检测机构列表
	 */
	@GetMapping("/purchase_page")
	public String purchase(Long id,ModelMap model,Pageable pageable) {
		//获取所有标准化机构的内容
		List<MechanismArticle> search = mechanismArticleService.search(MechanismArticle.Type.PURCHASE);
		if(search.size()>0) {
			model.addAttribute("search", search.get(0));
		}
		return "shop/mechanism_store/purchase_page";
	}
	
	/**
	 * 	检测机构列表
	 */
	@GetMapping("/bzh_page")
	public String bzh_page(Long id,ModelMap model,Pageable pageable) {
		MechanismStore find = mechanismStoreService.find(id);
		Page<MechanismStore> findPage = mechanismStoreService.findPage(MechanismStore.Type.STANDARDIZATION,null, null, pageable);
		model.addAttribute("page", find);
		model.addAttribute("findPage", findPage);
		
		return "shop/mechanism_store/bzh_page";
	}
	
}