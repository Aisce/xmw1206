/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: rwBbfOvOFzXzlxQPDm1gOCCIj57wu4Zb
 */
package net.shopxx.controller.admin;


import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ctc.wstx.util.StringUtil;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Sample;
import net.shopxx.service.SampleService;

/**
 * Controller - 样片索取
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminSampleController")
@RequestMapping("/admin/sample")
public class SampleController extends BaseController {

	@Inject
	private SampleService sampleService;


	/**
	 * 查看
	 */
	@GetMapping("/view")
	public String view(Long id, ModelMap model) {
		Sample find = sampleService.find(id);
		model.addAttribute("find", find);
		return "admin/sample/view";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		
		if(StringUtils.isNotEmpty(pageable.getSearchValue())) {
			if(!StringUtils.isNotEmpty(pageable.getSearchProperty())) {
				pageable.setSearchProperty("applyCompany");
			}
		}
		
		Page<Sample> findPage = sampleService.findPage(pageable);
		
		model.addAttribute("page", findPage);
		
		return "admin/sample/list";
	}

}