<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "ARTICLE_LIST"]
		[#if articleCategory.seoKeywords?has_content]
			<meta name="keywords" content="${articleCategory.seoKeywords}">
		[#elseif seo.resolveKeywords()?has_content]
			<meta name="keywords" content="${seo.resolveKeywords()}">
		[/#if]
		[#if articleCategory.seoDescription?has_content]
			<meta name="description" content="${articleCategory.seoDescription}">
		[#elseif seo.resolveDescription()?has_content]
			<meta name="description" content="${seo.resolveDescription()}">
		[/#if]
		<title>入驻厂家 - 北京芯梦国际科技有限公司</title>
	[/@seo]
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/reset.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/listContent.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/store/list.less" type="text/css" rel="stylesheet/less">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/jquery.qrcode.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/mobile/shop/js/base.js"></script>
	
	<script type="text/javascript">
		if (typeof Object.assign != 'function') {
		  Object.assign = function(target) {
			'use strict';
			if (target == null) {
			  throw new TypeError('Cannot convert undefined or null to object');
			}

			target = Object(target);
			for (var index = 1; index < arguments.length; index++) {
			  var source = arguments[index];
			  if (source != null) {
				for (var key in source) {
				  if (Object.prototype.hasOwnProperty.call(source, key)) {
					target[key] = source[key];
				  }
				}
			  }
			}
			return target;
		  };
		}
	</script>
		<script src="${base}/resources/shop/js/less.js"></script>
</head>

<body class="shop article-list">
	<header class="header-default html5plus-hidden" data-spy="scrollToFixed">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-1">
					<a href="javascript:;" data-action="back">
						<i class="iconfont icon-back"></i>
					</a>
				</div>
				<div class="col-xs-10">
					<h5>入住厂家</h5>
				</div>
			</div>
		</div>
	</header>
	<main>
		<div class="container">
			<div class="list" style="width:100%">
				<div class="content">
					<form id="searchform" style="height:50px;">
						<span style=" margin-left: 176px;">
							<img src="${base}/resources/shop/images/search.png" style="width:20px;"/>
							<input name="name" id="name" type="text" placeholder="名称" />
						</span>
						<input class="searchBtn" type="submit" value="查询"/>
					</form>
					<div id="storeForm">
						<div class="search">
							<ul class="J_valueList" style="width:100%;display:flex;justify-content:space-between;">
								[#list findAll as find]
									<li style="width:calc(100%/${findAll?size});margin-right: 5px; float: left;text-align:center;">
										<a title="${find.name}" href="${base}/store/findAllStore?storeCategoryId=${find.id}"><i></i>${find.name}</a>
									</li>
								[/#list]
							</ul>
						</div>
						
					</div>
					
					<ul class="clearfix">
						[#if page.content?has_content]
							[#list page.content as store]
								<li class="list-item">
									<div class="list-item-body">
										<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${store.id}">
											<img id="productImage1151" class="lazy-load img-responsive center-block" src="${store.logo}">
										</a>
										<p class="text-center">
											<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${store.id}" title="${store.name}">${store.name}</a>
										</p>
									</div>
								</li>
							[/#list]
						[/#if]
					</ul>
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "${base}/sample/list[#if {pageNumber} > 1]?pageNumber={pageNumber}[/#if]"]
						[#if totalPages > 1]
							<div class="panel-footer text-right" style="font-size: 1px;">
								[#include "/shop/include/pagination.ftl" /]
							</div>
						[/#if]
					[/@pagination]
				</div>
			</div>
		</div>
	</main>
	<footer class="adaptation-sty footer-default html5plus-hidden" data-spy="scrollToFixed" data-bottom="0" style="z-index: 100;position: fixed; bottom: 0px;margin-left: 0px;width: 100%;left: 0px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-3">
					<a class="active" href="${base}/">
						<i class="iconfont icon-home center-block"></i>
						<span class="center-block">${message("shop.footer.home")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/product_category">
						<i class="iconfont icon-sort center-block"></i>
						<span class="center-block">${message("shop.footer.productCategory")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/cart/list">
						<i class="iconfont icon-cart center-block"></i>
						<span class="center-block">${message("shop.footer.cart")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/member/index">
						<i class="iconfont icon-people center-block"></i>
						<span class="center-block">${message("shop.footer.member")}</span>
					</a>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>