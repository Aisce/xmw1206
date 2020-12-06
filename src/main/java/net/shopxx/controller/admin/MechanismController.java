/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: l+aQEIjk2VyD6mF1YeXshZWnT/hv3SvK
 */
package net.shopxx.controller.admin;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.audit.Audit;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Business;
import net.shopxx.entity.BusinessAttribute;
import net.shopxx.entity.Mechanism;
import net.shopxx.entity.User;
import net.shopxx.service.BusinessAttributeService;
import net.shopxx.service.MechanismService;
import net.shopxx.service.UserService;

/**
 * Controller - 商家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminMechanismController")
@RequestMapping("/admin/mechanism")
public class MechanismController extends BaseController {

	@Inject
	private MechanismService mechanismService;
	@Inject
	private UserService userService;
	@Inject
	private BusinessAttributeService businessAttributeService;
	
	/**
	 * 检查名称是否唯一
	 */
	@GetMapping("/check_name")
	public @ResponseBody boolean checkName(Long id, String username) {
		return StringUtils.isNotEmpty(username) && mechanismService.nameUnique(id, username);
	}
	@GetMapping("/check_phone")
	public @ResponseBody boolean checkPhone(Long id, String mobile) {
		return StringUtils.isNotEmpty(mobile) && mechanismService.phoneUnique(id, mobile);
	}
	@GetMapping("/check_email")
	public @ResponseBody boolean checkEmail(Long id, String email) {
		return StringUtils.isNotEmpty(email) && mechanismService.emileUnique(id, email);
	}

	/**
	 * 查看
	 */
	@GetMapping("/view")
	public String view(Long id, ModelMap model) {
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		model.addAttribute("mechanism", userService.find(id));
		return "admin/mechanism/view";
	}

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("mechanism", mechanismService.findAll());
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		return "admin/mechanism/add";
	}

	/**
	 * 保存
	 */
	@Audit(action = "auditLog.action.admin.member.save")
	@PostMapping("/save")
	public ResponseEntity<?> save(Mechanism mechanism, HttpServletRequest request) {
		if (!isValid(Mechanism.class, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}

		mechanism.removeAttributeValue();
		for (BusinessAttribute businessAttribute : businessAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("businessAttribute_" + businessAttribute.getId());
			if (!businessAttributeService.isValid(businessAttribute, values)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			Object memberAttributeValue = businessAttributeService.toBusinessAttributeValue(businessAttribute, values);
			mechanism.setAttributeValue(businessAttribute, memberAttributeValue);
		}
		mechanism.setIsLocked(false);
		mechanism.setType(User.Type.MECHANISM);
		mechanism.setLockDate(null);
		mechanism.setLastLoginIp(request.getRemoteAddr());
		mechanism.setLastLoginDate(new Date());
		mechanism.setStore(null);
		mechanismService.save(mechanism);
		if(null!=mechanism.getId()) {
			mechanismService.updateUser(mechanism, "Member");
		}
		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(Long id, ModelMap model) {
		model.addAttribute("businessAttributes", businessAttributeService.findList(true, true));
		model.addAttribute("business", userService.find(id));
		return "admin/mechanism/edit";
	}

	/**
	 * 更新
	 */
	@Audit(action = "auditLog.action.admin.member.update")
	@PostMapping("/update")
	public ResponseEntity<?> update(Mechanism mechanism, Long id, Long businessRankId, Boolean unlock, HttpServletRequest request) {
		if (!isValid(mechanism)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		mechanism.removeAttributeValue();
		for (BusinessAttribute businessAttribute : businessAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("businessAttribute_" + businessAttribute.getId());
			if (!businessAttributeService.isValid(businessAttribute, values)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			Object businessAttributeValue = businessAttributeService.toBusinessAttributeValue(businessAttribute, values);
			mechanism.setAttributeValue(businessAttribute, businessAttributeValue);
		}
		Mechanism find = mechanismService.find(id);
		if (find == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (BooleanUtils.isTrue(find.getIsLocked()) && BooleanUtils.isTrue(unlock)) {
			userService.unlock(mechanism);
			mechanismService.update(mechanism, "username", "encodedPassword", "balance", "frozenAmount", "businessDepositLogs", "businessCashs", "lastLoginIp", "lastLoginDate");
		} else {
			mechanismService.update(mechanism, "username", "encodedPassword", "balance", "frozenAmount", "businessDepositLogs", "businessCashs", "isLocked", "lockDate", "lastLoginIp", "lastLoginDate");
		}
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", mechanismService.findPage(pageable, User.Type.MECHANISM));
		return "admin/mechanism/list";
	}

	/**
	 * 删除
	 */
	@Audit(action = "auditLog.action.admin.member.delete")
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
			Mechanism find = mechanismService.find(id);
				if (find != null && find.getStore() != null) {
					return Results.unprocessableEntity("admin.business.deleteExistDepositNotAllowed", find.getUsername());
				}
			}
			mechanismService.delete(ids);
		}
		return Results.OK;
	}

}