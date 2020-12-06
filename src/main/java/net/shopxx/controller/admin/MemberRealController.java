/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: IKg7Xyfk4XsRExOJ3Nskxmbh9BFLN+sM
 */
package net.shopxx.controller.admin;

import net.shopxx.Filter;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.audit.Audit;
import net.shopxx.entity.Member;
import net.shopxx.entity.Member.RealnameStatus;
import net.shopxx.service.MemberService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List; 

/**
 * Controller - 会员
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("adminMemberRealController")
@RequestMapping("/admin/member_real")
public class MemberRealController extends BaseController {

	@Inject
	private MemberService memberService;

	/**
	 * 审核
	 */
	@GetMapping("/edit")
	public String view(Long id, ModelMap model) {
		Member member = memberService.find(id);
		model.addAttribute("member", member);
		return "admin/member_real/edit";
	}

	/**
	 * 更新
	 */
	@Audit(action = "auditLog.action.admin.member.realname")
	@PostMapping("/update")
	public ResponseEntity<?> update(Member member, String status, String failContent, Long id, HttpServletRequest request) {
		Member pMember = memberService.find(id);
		if(StringUtils.isEmpty(status)){
			return Results.UNPROCESSABLE_ENTITY;
		}
		
		if (pMember == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if(!status.equals(Member.RealnameStatus.FAIL.name()) && !status.equals(Member.RealnameStatus.REAL.name())){
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (status.equals(Member.RealnameStatus.FAIL.name())) {
			if (StringUtils.isEmpty(failContent)) {
				return Results.UNPROCESSABLE_ENTITY;
			} else {
				member.setAttributeValue9(failContent);
			}
		}
		RealnameStatus valueOf = Member.RealnameStatus.valueOf(RealnameStatus.class, status);
		member.setAttestationFlag(valueOf);
		memberService.updateRealnameStatus(member);
		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Pageable pageable, ModelMap model) {
		List<Filter> filters = new ArrayList<>();
		filters.add(new Filter("attestationFlag", Filter.Operator.EQ, Member.RealnameStatus.REALING.ordinal()));
		pageable.setFilters(filters);
		model.addAttribute("page", memberService.findPage(pageable));
		return "admin/member_real/list";
	}
}