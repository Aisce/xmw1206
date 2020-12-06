/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: wHFnKTLPGAT50rNbhH3P3q3nf/cZzi90
 */
package net.shopxx.controller.admin;

import java.util.ArrayList;
import java.util.Date;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Admin;

import net.shopxx.security.CurrentUser;
import net.shopxx.entity.NewLaunch;
import net.shopxx.entity.Product;
import net.shopxx.service.NewLaunchService;
import net.shopxx.service.ProductService;

/**
 * Controller - 新品发布控制层
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("NewLaunchController")
@RequestMapping("/admin/new_launch")
public class NewLaunchController extends BaseController {
	@Inject
	private NewLaunchService newLaunchService;
	@Inject
	private ProductService productService;
	/**
	 * 跳转新品发布列表页面
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		//获取分页数据
		Page<NewLaunch> findPage = newLaunchService.findPage(pageable);
		model.addAttribute("page", findPage);
		return "admin/new_launch/list";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		newLaunchService.delete(ids);
		return Results.OK;
	}
	/**
	 * 跳转添加页面
	 */
	@GetMapping("/add")
	public String add(ModelMap model){
		//获取所有产品
		List<Product> findAll = productService.findAll();
		model.addAttribute("findAll", findAll);
		return "admin/new_launch/add";
		
	}
	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		NewLaunch find = newLaunchService.find(id);
		model.addAttribute("newLaunch", find);
		return "admin/new_launch/edit";
	}
	/**
	 * 保存
	 * @currentUser 用户信息
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(NewLaunch newLaunch,String img, @CurrentUser Admin currentUser,Long productsId) {
		//以id产品
		Product find = productService.find(productsId);
		//获取用户信息
		System.out.println(currentUser.getUsername());
		newLaunch.setProductImages(img);
		//创建人
		newLaunch.setCreatUser(currentUser.getUsername());
		//创建时间
		newLaunch.setCreatTime(new Date());
		newLaunch.setCreatedDate(new Date());
		newLaunch.setHits(0L);
		newLaunch.setProductId(find);
		newLaunchService.save(newLaunch);
		return Results.OK;
	}
	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(NewLaunch newLaunch, Long productsId,@CurrentUser Admin currentUser) {
		//以id产品
		Product product = productService.find(productsId);
		//以id获取最新信息
		NewLaunch find = newLaunchService.find(newLaunch.getId());
		//将实体对象拷贝到查询出的对象中
		newLaunch.setUpdateTime(new Date());
		//添加修改人
		newLaunch.setUpdateUser(currentUser.getUsername());
		newLaunch.setProductId(product);
		org.springframework.beans.BeanUtils.copyProperties(newLaunch, find);
		
		newLaunchService.update(find);
		return Results.OK;
	}
	/**
	 * 查看
	 */
	@GetMapping("/show")
	public String show(Long id, ModelMap model) {
		NewLaunch find = newLaunchService.find(id);
		model.addAttribute("newLaunch", find);
		model.addAttribute("dxTime", find.getStereotypeTime());
		return "admin/new_launch/show";
	}

	/**
	 * 上架商品
	 */
	@PostMapping("/shelves")
	public ResponseEntity<?> shelves(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
				NewLaunch product = newLaunchService.find(id);
				if (product == null) {
					return Results.UNPROCESSABLE_ENTITY;
				}
			}
			//adnew_launchService.shelves(ids);
		}
		return Results.OK;
	}
	/**
	 * 商家选择
	 */
	@GetMapping("/product_select")
	public ResponseEntity<?> productSelect(String keyword, Integer count,Pageable pageable) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (StringUtils.isEmpty(keyword)) {
			return ResponseEntity.ok(data);
		}
		Page<Product> search = productService.search(keyword, null, null, null, null, null, null, null, null, pageable);
		//获取产品
		List<Product> content = search.getContent();
		if(content.size()>0) {
			for (Product poduct : content) {
				Map<String, Object> item = new HashMap<String, Object>();
				item.put("id", poduct.getId());
				item.put("poductname", poduct.getName());
				data.add(item);
			}
		}
		return ResponseEntity.ok(data);
	}

	
}