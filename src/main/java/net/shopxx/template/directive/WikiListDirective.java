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
import net.shopxx.entity.Wiki;
import net.shopxx.service.WikiService;
import net.shopxx.util.FreeMarkerUtils;

/**
 * 模板指令 - 文章列表
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Component
public class WikiListDirective extends BaseDirective {

	/**
	 * "文章分类ID"参数名称
	 */
	private static final String ARTICLE_CATEGORY_ID_PARAMETER_NAME = "wikiCategoryId";

	/**
	 * "文章标签ID"参数名称
	 */
	private static final String ARTICLE_TAG_ID_PARAMETER_NAME = "wikiTagId";

	/**
	 * 变量名称
	 */
	private static final String VARIABLE_NAME = "wikis";

	@Inject
	private WikiService wikiService;

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
		Long wikiCategoryId = FreeMarkerUtils.getParameter(ARTICLE_CATEGORY_ID_PARAMETER_NAME, Long.class, params);
		Long wikiTagId = FreeMarkerUtils.getParameter(ARTICLE_TAG_ID_PARAMETER_NAME, Long.class, params);
		Integer count = getCount(params);
		List<Filter> filters = getFilters(params, Wiki.class);
		List<Order> orders = getOrders(params);
		boolean useCache = useCache(params);

		List<Wiki> wikis = wikiService.findList(wikiCategoryId, wikiTagId, true, count, filters, orders, useCache);
		setLocalVariable(VARIABLE_NAME, wikis, env, body);
	}

}