<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("business.groupBuyingPromotionPlugin.list")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/business/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/business/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				
				var $end = $("a.end");
				
				// 结束
				$end.click(function() {
					var $element = $(this);
					
					bootbox.confirm("${message("business.groupBuyingPromotionPlugin.endGroupBuyingConfirm")}", function(result) {
						if (result == null || !result) {
							return;
						}
						$.ajax({
							url: "${base}/business/group_buying_promotion/end",
							type: "POST",
							data: {
								promotionId: $element.data("id")
							},
							dataType: "json",
							cache: false,
							success: function() {
								location.reload(true);
							}
						});
					});
				});
			
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="business">
	[#include "/business/include/main_header.ftl" /]
	[#include "/business/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li>
					<a href="${base}/business/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("business.groupBuyingPromotionPlugin.list")}</li>
			</ol>
			<form action="${base}/business/group_buying_promotion/list" method="get">
				<input name="pageSize" type="hidden" value="${page.pageSize}">
				<input name="searchProperty" type="hidden" value="${page.searchProperty}">
				<input name="orderProperty" type="hidden" value="${page.orderProperty}">
				<input name="orderDirection" type="hidden" value="${page.orderDirection}">
				<input name="promotionPluginId" type="hidden" value="${promotionPlugin.id}">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-12 col-sm-9">
								<div class="btn-group">
									<a class="btn btn-default" href="${base}${promotionPlugin.addUrl}?promotionPluginId=${promotionPlugin.id}" data-redirect-url="${base}/business/group_buying_promotion/list?promotionPluginId=${promotionPlugin.id}">
										<i class="iconfont icon-add"></i>
										${message("common.add")}
									</a>
									<button class="btn btn-default" type="button" data-action="delete" disabled>
										<i class="iconfont icon-close"></i>
										${message("common.delete")}
									</button>
									[#if !currentStore.isSelf()]
										<a class="btn btn-default" href="${base}/business/promotion_plugin/buy?promotionPluginId=${promotionPlugin.id}">
											<i class="iconfont icon-cart"></i>
											${message("business." + promotionPlugin.id + ".buy")}
										</a>
									[/#if]
									<button class="btn btn-default" type="button" data-action="refresh">
										<i class="iconfont icon-refresh"></i>
										${message("common.refresh")}
									</button>
									<div class="btn-group">
										<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
											${message("common.pageSize")}
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li[#if page.pageSize == 10] class="active"[/#if] data-page-size="10">
												<a href="javascript:;">10</a>
											</li>
											<li[#if page.pageSize == 20] class="active"[/#if] data-page-size="20">
												<a href="javascript:;">20</a>
											</li>
											<li[#if page.pageSize == 50] class="active"[/#if] data-page-size="50">
												<a href="javascript:;">50</a>
											</li>
											<li[#if page.pageSize == 100] class="active"[/#if] data-page-size="100">
												<a href="javascript:;">100</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-xs-12 col-sm-3">
								<div id="search" class="input-group">
									<div class="input-group-btn">
										<button class="btn btn-default" type="button" data-toggle="dropdown">
											[#switch page.searchProperty]
												[#default]
													<span>${message("Promotion.name")}</span>
											[/#switch]
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li[#if !page.searchProperty?? || page.searchProperty == "name"] class="active"[/#if] data-search-property="name">
												<a href="javascript:;">${message("Promotion.name")}</a>
											</li>
										</ul>
									</div>
									<input name="searchValue" class="form-control" type="text" value="${page.searchValue}" placeholder="${message("common.search")}" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search">
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<i class="iconfont icon-search"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>
											<div class="checkbox">
												<input type="checkbox" data-toggle="checkAll">
												<label></label>
											</div>
										</th>
										<th>
											<a href="javascript:;" data-order-property="name">
												${message("Promotion.name")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="beginDate">
												${message("Promotion.beginDate")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="endDate">
												${message("Promotion.endDate")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>${message("GroupBuying.groupSize")}</th>
										<th>${message("Promotion.products")}</th>
										<th>${message("GroupBuying.status")}</th>
										<th>
											<a href="javascript:;" data-order-property="isEnabled">
												${message("Promotion.isEnabled")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="order">
												${message("common.order")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>${message("common.action")}</th>
									</tr>
								</thead>
								[#if page.content?has_content]
									<tbody>
										[#list page.content as promotion]
											<tr>
												<td>
													<div class="checkbox">
														<input name="ids" type="checkbox" value="${promotion.id}">
														<label></label>
													</div>
												</td>
												<td>${promotion.name}</td>
												<td>
													[#if promotion.beginDate??]
														<span title="${promotion.beginDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${promotion.beginDate}</span>
													[#else]
														-
													[/#if]
												</td>
												<td>
													[#if promotion.endDate??]
														<span title="${promotion.endDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${promotion.endDate}</span>
													[#else]
														-
													[/#if]
												</td>
												<td>
													[#if promotion.promotionDefaultAttribute.groupBuying.groupSize??]
														${promotion.promotionDefaultAttribute.groupBuying.groupSize}
													[#else]
														-
													[/#if]
												</td>
												<td>
													[#if promotion.products?has_content]
														[#list promotion.products as product]
															<a href="${product.path}">${product.name}</a>
															[#break]
														[/#list]
													[#else]
														-
													[/#if]
												</td>
												<td>
													[#assign groupBuying = promotion.promotionDefaultAttribute.groupBuying /]
													[#if !groupBuying.hasEnded()]
														<span class="text-orange">${message("GroupBuying.Status." + groupBuying.status)}</span>
													[#elseif groupBuying.groupEnded]
														<span class="text-green">${message("GroupBuying.groupEnded")}</span>
													[#elseif groupBuying.groupFailure]
														<span class="text-red">${message("GroupBuying.groupFailure")}</span>
													[/#if]
												</td>
												<td>
													[#if promotion.isEnabled]
														<i class="text-green iconfont icon-check"></i>
													[#else]
														<i class="text-red iconfont icon-close"></i>
													[/#if]
												</td>
												<td>${promotion.order}</td>
												<td>
													<a class="btn btn-default btn-xs btn-icon" href="${base}${promotionPlugin.editUrl}?promotionId=${promotion.id}" title="${message("common.edit")}" data-toggle="tooltip" data-redirect-url>
														<i class="iconfont icon-write"></i>
													</a>
													<a class="btn btn-default btn-xs btn-icon" href="${base}${promotion.path}" title="${message("common.view")}" data-toggle="tooltip" target="_blank">
														<i class="iconfont icon-search"></i>
													</a>
													<a class="btn btn-default btn-xs btn-icon" href="${base}/business/order/list?groupBuyingId=${promotion.promotionDefaultAttribute.groupBuying.id}" title="${message("business.groupBuyingPromotionPlugin.orderList")}" data-toggle="tooltip">
														<i class="iconfont icon-form"></i>
													</a>
													[#if !promotion.promotionDefaultAttribute.groupBuying.hasEnded()]
														<a class="end btn btn-default btn-xs btn-icon" href="javascript:;" title="${message("business.groupBuyingPromotionPlugin.end")}" data-toggle="tooltip" data-id="${promotion.id}">
															<i class="iconfont icon-time"></i>
														</a>
													[/#if]
												</td>
											</tr>
										[/#list]
									</tbody>
								[/#if]
							</table>
							[#if !page.content?has_content]
								<p class="no-result">${message("common.noResult")}</p>
							[/#if]
						</div>
					</div>
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
						[#if totalPages > 1]
							<div class="panel-footer text-right">
								[#include "/business/include/pagination.ftl" /]
							</div>
						[/#if]
					[/@pagination]
				</div>
			</form>
		</div>
	</main>
</body>
</html>