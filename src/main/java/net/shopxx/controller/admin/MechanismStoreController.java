/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: GueuG/rWQ6Hp0roZwfsqcg2MDHOWaxT1
 */
package net.shopxx.controller.admin;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Business;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.MechanismStore.Type;
import net.shopxx.entity.Member;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Store;
import net.shopxx.entity.User;
import net.shopxx.service.BusinessService;
import net.shopxx.service.MechanismService;
import net.shopxx.service.MechanismStoreService;
import net.shopxx.service.MemberService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.StoreCategoryService;
import net.shopxx.service.StoreRankService;
import net.shopxx.service.StoreService;
import net.shopxx.util.FileDecompressionZip;
import net.shopxx.util.ObjectPropertyUtil;

/**
 * Controller - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminMechanismStoreController")
@RequestMapping("/admin/mechanism_store")
public class MechanismStoreController extends BaseController {

	@Inject
	private MechanismStoreService mechanismStoreService;
	@Inject
	private MechanismService mechanismService;
	@Inject
	private StoreRankService storeRankService;
	@Inject
	private StoreCategoryService storeCategoryService;
	@Inject
	private ProductCategoryService productCategoryService;
	@Inject
	private MemberService memberService;

	/**
	 * 检查名称是否唯一
	 */
	@GetMapping("/check_name")
	public @ResponseBody boolean checkName(Long id, String name) {
		return StringUtils.isNotEmpty(name) && mechanismStoreService.nameUnique(id, name);
	}

	/**
	 * 商家选择
	 */
	@GetMapping("/mechanism_select")
	public ResponseEntity<?> businessSelect(String keyword, Integer count) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (StringUtils.isEmpty(keyword)) {
			return ResponseEntity.ok(data);
		}
		List<Member> search = mechanismService.search(keyword, count,User.Type.MECHANISM);
		for (Member businesse : search) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", businesse.getId());
			item.put("username", businesse.getUsername());
			data.add(item);
		}
		return ResponseEntity.ok(data);
	}
	/**
	 * 查看
	 */
	@GetMapping("/view")
	public String view(Long id, ModelMap model) {
		MechanismStore find = mechanismStoreService.find(id);
		model.addAttribute("store", find);
		return "admin/mechanism_store/view";
	}

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		Type[] values = MechanismStore.Type.values();
		model.addAttribute("types", values);
		return "admin/mechanism_store/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(MechanismStore mechanismStore, Long mechanismId, Long storeRankId, Long storeCategoryId, Long[] productCategoryIds) {
		mechanismStore.setMechanism(memberService.find(mechanismId));
		mechanismStore.setEndDate(new Date());
		if (mechanismStoreService.nameExists(mechanismStore.getName())) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (!isValid(mechanismStore, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		mechanismStoreService.save(mechanismStore);
		mechanismStoreService.review(mechanismStore, true, null);
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("store", mechanismStoreService.find(id));
		model.addAttribute("types", MechanismStore.Type.values());
		return "admin/mechanism_store/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(MechanismStore store, Long id, Long storeRankId, Long storeCategoryId, Long[] productCategoryIds) {
		MechanismStore pStore = mechanismStoreService.find(id);
		pStore.setNumber(store.getNumber());
		pStore.setName(store.getName());
		pStore.setLogo(store.getLogo());
		pStore.setEmail(store.getEmail());
		pStore.setMobile(store.getMobile());
		pStore.setPhone(store.getPhone());
		pStore.setAddress(store.getAddress());
		pStore.setZipCode(store.getZipCode());
		pStore.setIntroduction(store.getIntroduction());
		pStore.setKeyword(store.getKeyword());
		pStore.setIsEnabled(store.getIsEnabled());
		pStore.setContent(store.getContent());
		pStore.setImage(store.getImage());
		pStore.setUrl(store.getUrl());
		pStore.setIsEnabled(store.getIsEnabled());
		pStore.setSorting(store.getSorting());
		
		if (!isValid(pStore, BaseEntity.Update.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		mechanismStoreService.update(pStore);
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(MechanismStore.Type type, Boolean isFine, Boolean isEnabled, Boolean hasExpired, Pageable pageable, ModelMap model) {
		model.addAttribute("type", type);
		model.addAttribute("isFine", isFine);
		model.addAttribute("isEnabled", isEnabled);
		model.addAttribute("hasExpired", hasExpired);
		model.addAttribute("page", mechanismStoreService.findPage(type,isEnabled, hasExpired, pageable));
		return "admin/mechanism_store/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		if (ids != null) {
			mechanismStoreService.delete(ids);
		}
		return Results.OK;
	}

	/**
	 * 审核
	 */
	@GetMapping("/review")
	public String review(Long id, ModelMap model) {
		MechanismStore find = mechanismStoreService.find(id);
		model.addAttribute("store", find);
		return "admin/mechanism_store/review";
	}


	/**
	 * 获取允许发布商品分类上级分类
	 * 
	 * @param store
	 *            店铺
	 * @return 允许发布商品分类上级分类
	 */
	private Set<ProductCategory> getAllowedProductCategoryParents(Store store) {
		Assert.notNull(store, "[Assertion failed] - store is required; it must not be null");

		Set<ProductCategory> result = new HashSet<>();
		List<ProductCategory> allowedProductCategories = productCategoryService.findList(store, null, null, null);
		for (ProductCategory allowedProductCategory : allowedProductCategories) {
			result.addAll(allowedProductCategory.getParents());
		}
		return result;
	}
	/**
	 * 获取检测机构
	 */
	

}