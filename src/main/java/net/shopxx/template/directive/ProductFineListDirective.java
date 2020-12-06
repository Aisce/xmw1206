/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: Vp/orWx0KT9rrkEMN6zuCWJ78Ge44JHR
 */
package net.shopxx.template.directive;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Component;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.entity.Product;
import net.shopxx.service.ProductService;

/**
 * 模板指令 - 热门产品列表
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Component
public class ProductFineListDirective extends BaseDirective {

	/**
	 * 变量名称
	 */
	private static final String VARIABLE_NAME = "productFine";

	@Inject
	private ProductService productService;

	/**
	 * 执行
	 * 
	 * @param env
	 *            环境变量
	 * @param params
	 *            参数
	 * @param loopVars
	 *            循环变量
	 * @param body
	 *            模板内容
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Integer count = getCount(params);
		Pageable pageable = new Pageable(null,count);
		Page<Product> findPage = productService.findPage(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, true, null, null, null, null, null, pageable, null);
		List<Product> productFine = findPage.getContent();
		setLocalVariable(VARIABLE_NAME, productFine, env, body);
	}

}