/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 5ebTBe0Uawf/yUBagQ8zhSw5DLVv1ZxA
 */
package net.shopxx.service.impl;

import java.awt.image.BufferedImage;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.code.kaptcha.Producer;

import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.shopxx.service.CaptchaService;

/**
 * Service - 验证码
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Service
public class CaptchaServiceImpl implements CaptchaService {

	/**
	 * "验证码"缓存名称
	 */
	private static final String CAPTCHA_CACHE_NAME = "captcha";
	
	/**
	 * 手机号验证码 缓存名称
	 */
	private static final String MOBILE_CODE_CACHE_NAME = "mobilecode";

	@Inject
	private Producer captchaProducer;
	@Inject
	private CacheManager cacheManager;

	@Override
	public BufferedImage createImage(String captchaId) {
		Assert.hasText(captchaId, "[Assertion failed] - captchaId must have text; it must not be null, empty, or blank");

		String captcha = captchaProducer.createText();
		Ehcache cache = cacheManager.getEhcache(CAPTCHA_CACHE_NAME);
		cache.put(new Element(captchaId, captcha));
		return captchaProducer.createImage(captcha);
	}
	
	@Override
	public void createMobilecode(String captchaId, int mobilecode) {
		Assert.hasText(captchaId, "[Assertion failed] - captchaId must have text; it must not be null, empty, or blank");
		Ehcache cache = cacheManager.getEhcache(MOBILE_CODE_CACHE_NAME);
		cache.put(new Element(captchaId, mobilecode));
	}

	@Override
	public boolean isValid(String captchaId, String captcha) {
		if (StringUtils.isEmpty(captchaId) || StringUtils.isEmpty(captcha)) {
			return false;
		}

		Ehcache cache = cacheManager.getEhcache(CAPTCHA_CACHE_NAME);
		Element element = cache.get(captchaId);
		if (element != null) {
			String value = String.valueOf(element.getObjectValue());
			cache.remove(captchaId);
			return StringUtils.equalsIgnoreCase(captcha, value);
		}
		return false;
	}
	
	@Override
	public boolean isValidMobilecode(String captchaId, String mobilecode) {
		if (StringUtils.isEmpty(captchaId) || StringUtils.isEmpty(mobilecode)) {
			return false;
		}

		Ehcache cache = cacheManager.getEhcache(MOBILE_CODE_CACHE_NAME);
		Element element = cache.get(captchaId);
		if (element != null) {
			String value = String.valueOf(element.getObjectValue());
			cache.remove(captchaId);
			return StringUtils.equalsIgnoreCase(mobilecode, value);
		}
		return false;
	}

}