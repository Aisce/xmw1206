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
import net.shopxx.entity.Store;
import net.shopxx.service.StoreService;
import net.shopxx.util.FreeMarkerUtils;

/**
 * 模板指令 - 优秀厂家
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Component
public class StoreFineListDirective extends BaseDirective {


	/**
	 * 变量名称
	 */
	private static final String VARIABLE_NAME = "store_fine";
	/**
	 * "类型"参数名称
	 */
	private static final String TYPE_PARAMETER_NAME = "status";

	@Inject
	private StoreService storeService;

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
		System.out.println("CANSHU"+params);
		Store.Status status = FreeMarkerUtils.getParameter(TYPE_PARAMETER_NAME, Store.Status.class, params);
		Integer count = getCount(params);
		Pageable pageable=new Pageable(null,count);

		Page<Store> findPage = storeService.findPage(null, status, true, null, null, pageable);
		List<Store> store_fine = findPage.getContent();
		System.out.println(store_fine.toString());
		setLocalVariable(VARIABLE_NAME, store_fine, env, body);
	}

}