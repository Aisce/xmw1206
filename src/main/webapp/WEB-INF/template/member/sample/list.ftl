<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("member.order.list")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
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
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/member/js/base.js"></script>
	<script>
	$().ready(function() {
		
		var $progressShowButton = $("a.progressShowButton");
		var $progressShow = $("a.progressShowbtn");
		
		$progressShowButton.click(function(){
			var productId = $(this).attr("data-id");
			var $productItem = $("li.progress-item-" + productId);
			var $progressItem = $("tr.progres-item-" + productId);
			if($progressItem.length > 0){
				$progressItem.remove();
				return;
			}
			$("tr.progress-item").remove();
			
			$productItem.after('<tr class="progres-item-' + productId + '" colspan="6"><td>加载中...</td></tr>');
			$.ajax({
				url: "${base}/member/sample/list_progress",
				type: "POST",
				data: {
					productId: productId,
				},
				dataType: "json",
				cache: false,
				success: function(data) {
					$progressItem = $("tr.progres-item-" + productId);
					$progressItem.remove();
					
						var d = new Date(data.createDate).format('yyyy-MM-dd EE HH:mm:ss');
						$productItem.after('<tr class="progress-item progres-item-' + productId  + '"><td colspan="6">快递公司：&nbsp;&nbsp;&nbsp;&nbsp;' + data.kuaidiCompany + '&nbsp;&nbsp;&nbsp;&nbsp;</td><td colspan="6">快递单号：&nbsp;&nbsp;&nbsp;&nbsp;' + data.orderNubmer + '&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>');
				}
			});
		});
		
		$progressShow.click(function(){
			var productId = $(this).attr("data-id");
			var $productItem = $("li.progress-item-" + productId);
			var $progressItem = $("tr.progres-item-" + productId);
			if($progressItem.length > 0){
				$progressItem.remove();
				return;
			}
			$("tr.progress-item").remove();
			
			$productItem.after('<tr class="progres-item-' + productId + '" colspan="6"><td>加载中...</td></tr>');
			$.ajax({
				url: "${base}/member/sample/progress",
				type: "POST",
				data: {
					productId: productId,
				},
				dataType: "json",
				cache: false,
				success: function(data) {
					$progressItem = $("tr.progres-item-" + productId);
					$progressItem.remove();
					
						var d = new Date(data.createDate).format('yyyy-MM-dd EE HH:mm:ss');
						$productItem.after('<tr class="progress-item progres-item-' + productId  + '"><td colspan="6">不通过原因：&nbsp;&nbsp;&nbsp;&nbsp;' + data.kuaidiCompany + '</td></tr>');
				}
			});
		});
	});
</script>
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
					<form action="${base}/member/order/list" method="get">
						<input name="status" type="hidden" value="${status}">
						<input name="hasExpired" type="hidden" value="${(hasExpired?string("true", "false"))!}">
						<input name="pageNumber" type="hidden" value="${page.pageNumber}">
						<div class="order-list panel panel-default">
							<div class="panel-heading">${message("member.sample.list")}</div>
							<div class="panel-body">
								[#if page.content?has_content]
									<ul class="media-list">
										[#list page.content as sample]
											<li class="media progress-item-${sample.id}">
												<div class="media-left media-middle">
													<ul class="media-list">
														<li class="media">
															<div class="media-left media-middle">
																<a href="${base}${sample.product.path}" target="_blank">
																	<img class="media-object img-thumbnail" src="${sample.product.thumbnail!setting.defaultThumbnailProductImage}" alt="${sample.product.name}">
																</a>
															</div>
															<div class="media-body media-middle">
																<h5 class="media-heading">
																	<a href="${base}${sample.product.path}" title="${sample.product.name}" target="_blank">${sample.product.name}</a>
																</h5>
															</div>
														</li>
													</ul>
												</div>
												<div class="media-body media-middle">
													<ul>
														<li>
															${sample.sampleNumber}
														</li>
														<li>
															<span class="text-gray-dark">
																<i class="iconfont icon-shop"></i>
																${sample.store.name}
															</span>
															<span class="text-gray" title="${sample.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${sample.createdDate}</span>
														</li>
													</ul>
												</div>
												<div class="media-right media-middle">
												
													[#if sample.flag == 0]
														<strong class="text-red pull-left">审核中</strong>
													[#elseif sample.flag == 1]
														<strong class="text-red pull-left">审核通过</strong>
													[#else]
														<strong class="text-red pull-left">审核不通过</strong>
													[/#if]
													[#if sample.flag == 1]
														<a class="btn btn-default btn-xs btn-icon progressShowButton" title="查看快递信息" data-id="${sample.id}">
															<i class="iconfont icon-search"></i>
														</a>
													[#elseif sample.flag == 0]
													[#else]
														<a class="btn btn-default btn-xs btn-icon progressShowbtn" title="查看快递信息" data-id="${sample.id}">
															<i class="iconfont icon-search"></i>
														</a>
													[/#if]
												</div>
											</li>
										[/#list]
									</ul>
								[#else]
									<p class="text-gray">${message("common.noResult")}</p>
								[/#if]
							</div>
							[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
								[#if totalPages > 1]
									<div class="panel-footer text-right clearfix">
										[#include "/member/include/pagination.ftl" /]
									</div>
								[/#if]
							[/@pagination]
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>