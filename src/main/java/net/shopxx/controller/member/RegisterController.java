/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: He7VLWw0zGhinTeoUj55OwyqgLeeVx8X
 */
package net.shopxx.controller.member;

import net.shopxx.Results;
import net.shopxx.Setting;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Member;
import net.shopxx.entity.MemberAttribute;
import net.shopxx.entity.SocialUser;
import net.shopxx.security.UserAuthenticationToken;
import net.shopxx.service.*;
import net.shopxx.util.SpringUtils;
import net.shopxx.util.SystemUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.regex.Pattern;

/**
 * Controller - 会员注册
 *
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("memberRegisterController")
@RequestMapping("/member/register")
public class RegisterController extends BaseController {

	/**
	 * E-mail身份配比
	 */
	private static final Pattern EMAIL_PRINCIPAL_PATTERN = Pattern.compile(".*@.*");

	/**
	 * 手机身份配比
	 */
	private static final Pattern MOBILE_PRINCIPAL_PATTERN = Pattern.compile("\\d+");

	@Inject
	private PluginService pluginService;
	@Inject
	private UserService userService;
	@Inject
	private MemberService memberService;
	@Inject
	private DistributorService distributorService;
	@Inject
	private MemberRankService memberRankService;
	@Inject
	private MemberAttributeService memberAttributeService;
	@Inject
	private SocialUserService socialUserService;
	@Inject
	private CaptchaService captchaService;
	@Inject
	private SmsService smsService;

	/**
	 * 检查用户名是否存在
	 */
	@GetMapping("/check_username")
	public @ResponseBody
	boolean checkUsername(String username) {
		return StringUtils.isNotEmpty(username) && !memberService.usernameExists(username);
	}

	/**
	 * 检查E-mail是否存在
	 */
	@GetMapping("/check_email")
	public @ResponseBody
	boolean checkEmail(String email) {
		return StringUtils.isNotEmpty(email) && !memberService.emailExists(email);
	}

	/**
	 * 检查手机是否存在
	 */
	@GetMapping("/check_mobile")
	public @ResponseBody
	boolean checkMobile(String mobile) {
		return StringUtils.isNotEmpty(mobile) && !memberService.mobileExists(mobile);
	}

	/**
	 * 注册页面
	 */
	@GetMapping
	public String index(Long socialUserId, String uniqueId, HttpServletRequest request, ModelMap model) {
		if (socialUserId != null && StringUtils.isNotEmpty(uniqueId)) {
			SocialUser socialUser = socialUserService.find(socialUserId);
			if (socialUser == null || socialUser.getUser() != null || !StringUtils.equals(socialUser.getUniqueId(), uniqueId)) {
				return UNPROCESSABLE_ENTITY_VIEW;
			}
			model.addAttribute("socialUserId", socialUserId);
			model.addAttribute("uniqueId", uniqueId);
		}
		model.addAttribute("genders", Member.Gender.values());
		model.addAttribute("loginPlugins", pluginService.getActiveLoginPlugins(request));
		return "member/register/index";
	}
	
	@GetMapping("/success")
	public String success(){
		return "member/register/success";
	}

	/**
	 * 注册提交
	 */
	@PostMapping("/submit")
	public ResponseEntity<?> submit(String username, String password, String email, String mobile, String mobilecodeId, String mobilecode, String spreadMemberUsername, String attributeValue0, String attributeValue1, String attributeValue2, HttpServletRequest request) {
		Setting setting = SystemUtils.getSetting();
		if (!ArrayUtils.contains(setting.getAllowedRegisterTypes(), Setting.RegisterType.MEMBER)) {
			return Results.unprocessableEntity("member.register.disabled");
		}
		if (!isValid(Member.class, "username", username, BaseEntity.Save.class) || !isValid(Member.class, "password", password, BaseEntity.Save.class) || !isValid(Member.class, "email", email, BaseEntity.Save.class) || !isValid(Member.class, "mobile", mobile, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (memberService.usernameExists(username)) {
			return Results.unprocessableEntity("member.register.usernameExist");
		}
		if (memberService.emailExists(email)) {
			return Results.unprocessableEntity("member.register.emailExist");
		}
		if (memberService.mobileExists(mobile)) {
			return Results.unprocessableEntity("member.register.mobileExist");
		}
		
		if (!captchaService.isValidMobilecode(mobilecodeId, mobilecode)) {
			return Results.unprocessableEntity("member.register.mobileCodeError");
		}

		Member member = new Member();
		member.removeAttributeValue();
		for (MemberAttribute memberAttribute : memberAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("memberAttribute_" + memberAttribute.getId());
			if (!memberAttributeService.isValid(memberAttribute, values)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			Object memberAttributeValue = memberAttributeService.toMemberAttributeValue(memberAttribute, values);
			member.setAttributeValue(memberAttribute, memberAttributeValue);
		}

		member.setUsername(username);
		member.setPassword(password);
		member.setEmail(email);
		member.setAttributeValue0(attributeValue0);
		member.setAttributeValue1(attributeValue1);
		member.setAttributeValue2(attributeValue2);
		member.setMobile(mobile);
		member.setPoint(0L);
		member.setBalance(BigDecimal.ZERO);
		member.setFrozenAmount(BigDecimal.ZERO);
		member.setAmount(BigDecimal.ZERO);
		member.setIsEnabled(true);
		member.setIsLocked(false);
		member.setLockDate(null);
		member.setLastLoginIp(request.getRemoteAddr());
		member.setLastLoginDate(new Date());
		member.setSafeKey(null);
		member.setMemberRank(memberRankService.findDefault());
		member.setDistributor(null);
		member.setCart(null);
		member.setOrders(null);
		member.setPaymentTransactions(null);
		member.setMemberDepositLogs(null);
		member.setCouponCodes(null);
		member.setReceivers(null);
		member.setReviews(null);
		member.setConsultations(null);
		member.setProductFavorites(null);
		member.setProductNotifies(null);
		member.setSocialUsers(null);
		member.setPointLogs(null);
		userService.register(member);
		userService.login(new UserAuthenticationToken(Member.class, username, password, false, request.getRemoteAddr()));

		if(StringUtils.isNotBlank(spreadMemberUsername)){ // 推广验证
			Member spreadMember = null;
			if (EMAIL_PRINCIPAL_PATTERN.matcher(spreadMemberUsername).matches()) {
				spreadMember = memberService.findByEmail(spreadMemberUsername);
			} else if (MOBILE_PRINCIPAL_PATTERN.matcher(spreadMemberUsername).matches()) {
				spreadMember = memberService.findByMobile(spreadMemberUsername);
			} else {
				spreadMember = memberService.findByUsername(spreadMemberUsername);
			}
			if (spreadMember != null) {
				distributorService.create(member, spreadMember);
			}
		}
		return Results.OK;
	}
	
	@PostMapping("/send_mobile_code")
	public ResponseEntity<?> sendMobileCode(String mobile, String mobilecodeId, String captchaId, String captcha, HttpServletRequest request) {
		if(!isValid(Member.class, "mobile", mobile)){
			return Results.unprocessableEntity("member.register.mobileError");
		}
		if (memberService.mobileExists(mobile)) {
			return Results.unprocessableEntity("member.register.mobileExist");
		}

		if (!captchaService.isValid(captchaId, captcha)) {
			return Results.unprocessableEntity("common.message.ncorrectCaptcha");
		}
		
		int mobilecode = (int) ((Math.random() * 9 + 1) * 10000);
		
		System.out.println("发送验证码：" + mobilecode);

		// 发送验证码
		smsService.send(mobile, SpringUtils.getMessage("member.register.mobileSendContent", mobilecode + ""));
		
		// 存储验证码
		captchaService.createMobilecode(mobilecodeId, mobilecode);

		return Results.OK;
	}

}