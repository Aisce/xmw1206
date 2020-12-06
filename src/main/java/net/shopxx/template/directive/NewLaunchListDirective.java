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
import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.NewLaunch;
import net.shopxx.service.NewLaunchService;

/**
 * 模板指令 - 新品发布列表
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Component
public class NewLaunchListDirective extends BaseDirective {

	/**
	 * 变量名称
	 */
	private static final String VARIABLE_NAME = "adNewReleases";

	@Inject
	private NewLaunchService newLaunchService;

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
		List<Filter> filters = getFilters(params, NewLaunch.class);
		List<Order> orders = getOrders(params);
		boolean useCache = useCache(params);

		List<NewLaunch> adNewReleases = newLaunchService.findList(true, count, filters, orders, useCache);
		setLocalVariable(VARIABLE_NAME, adNewReleases, env, body);
	}

}