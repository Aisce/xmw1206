<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>标准机构认证 - 北京芯梦国际科技有限公司</title>
		<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
		<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/member/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/bootstrap-select.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/member/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
				$().ready(function() {
					var data_id = $("#ids").val();
					var $review = $("button.btn");
					
					$review.click(function() {
						var $element = $(this);
					
						bootbox.prompt({
							title: "${message("common.bootbox.title")}",
							inputType: "select",
							value: "APPROVED",
							inputOptions: [
								{
									text: "${message("business.order.reviewApproved")}",
									value: "APPROVED"
								},
								{
									text: "${message("business.order.reviewFailed")}",
									value: "FAILED"
								}
							],
							callback: function(result) {
								if (result == null) {
									return;
								}
								
								$.ajax({
									url: "${base}/product/shenhe",
									type: "POST",
									data: {
										id: $element.data("id"),
										passed: result === "APPROVED" ? "true" : "false"
									},
									dataType: "json",
									cache: false,
									success: function() {
										location.reload(true);
									}
								});
							}
						}).find("select").selectpicker();
					});
				});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="member order">
	[#include "/shop/include/main_header.ftl" /]
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					[#include "/member/include/main_menu.ftl" /]
				</div>
				<div class="col-xs-10">
						<div id="filterModal" class="modal fade" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button class="close" type="button" data-dismiss="modal">&times;</button>
										<h5 class="modal-title">${message("common.moreOption")}</h5>
									</div>
									<div class="modal-body form-horizontal">
										<div class="form-group">
											<label class="col-xs-3 control-label">${message("Product.promotions")}:</label>
											<div class="col-xs-9 col-sm-7">
												<select name="promotionId" class="selectpicker form-control" data-live-search="true" data-size="10">
													<option value="">${message("common.choose")}</option>
													[#list promotions as promotion]
														<option value="${promotion.id}"[#if promotion.id == promotionId] selected[/#if]>${promotion.name}</option>
													[/#list]
												</select>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button class="btn btn-primary" type="submit">${message("common.ok")}</button>
										<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
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
													<a href="javascript:;" data-order-property="sn">
														${message("Product.sn")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="name">
														${message("Product.name")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="productCategory">
														${message("Product.productCategory")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="price">
														是否认证
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="isMarketable">
														${message("Product.isMarketable")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="isActive">
														${message("Product.isActive")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>
													<a href="javascript:;" data-order-property="createdDate">
														${message("common.createdDate")}
														<i class="iconfont icon-biaotou-kepaixu"></i>
													</a>
												</th>
												<th>${message("common.action")}</th>
											</tr>
										</thead>
										[#if page.content?has_content]
											<tbody>
												[#list page.content as product]
													<input type="hidden" value="{product.id}" id="ids" name="ids"/>
													<tr>
														<td>
															<div class="checkbox">
																<input name="ids" type="checkbox" value="${product.id}">
																<label></label>
															</div>
														</td>
														<td>
															<span class="[#if product.isOutOfStock] text-red[#elseif product.isStockAlert] text-blue[/#if]">${product.sn}</span>
														</td>
														<td>
															${product.name}
															[#if product.type != "GENERAL"]
																<span class="text-red">*</span>
															[/#if]
															[#list product.validPromotions as promotion]
																<span class="promotion text-orange" title="${promotion.name}" data-toggle="tooltip">${promotion.name}</span>
															[/#list]
														</td>
														<td>${product.productCategory.name}</td>
														<td>
															[#if product.isbzverify]
																<i class="text-green iconfont icon-check"></i>
															[#else]
																<i class="text-red iconfont icon-close"></i>
															[/#if]
															
														</td>
														<td>
															[#if product.isMarketable]
																<i class="text-green iconfont icon-check"></i>
															[#else]
																<i class="text-red iconfont icon-close"></i>
															[/#if]
														</td>
														<td>
															[#if product.isActive]
																<i class="text-green iconfont icon-check"></i>
															[#else]
																<i class="text-red iconfont icon-close"></i>
															[/#if]
														</td>
														<td>
															<span title="${product.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${product.createdDate}</span>
														</td>
														<td>
															[#if !product.isbzverify]
																<button class="btn btn-default btn-xs btn-icon" data-id="${product.id}" title="认证"   id = "review${product.id}">
																	<i class="iconfont icon-comment"></i>
																</button>
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
				</div>
			</div>
		</div>
	</main>
</body>
</html>