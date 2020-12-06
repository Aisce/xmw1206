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
		<title>[#if articleCategory.seoTitle?has_content]${articleCategory.seoTitle}[#else]${seo.resolveTitle()}[/#if][#if showPowered] - 北京芯梦国际科技有限公司[/#if]</title>
	[/@seo]
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/reset.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/listContent.css" rel="stylesheet">
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
	<script src="${base}/resources/shop/js/base.js"></script>
	<script src="${base}/resources/mobile/shop/js/base.js"></script>
</style>
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
					<h5>新品发布</h5>
				</div>
			</div>
		</div>
	</header>
	<main>
		<div class="container" style="height: 640px;">
			<div id="listContent" style="margin-top: 0px;">
			<div class="list" style="width: 100%;">
			<form action="${base}/new_launch/list" method="get" id="rform">
				<div class="search">
					<span style="width: 25%;">
						<img src="${base}/resources/shop/images/search.png"/>
						<input name="name" id="name" type="text" placeholder="请输入主题" />
					</span>
					<span style="width: 25%;">
						<img src="${base}/resources/shop/images/search.png"/>
						<input type="text" name="creatUser" id="creatUser" placeholder="请输入发布者" />
					</span>
					<button class="searchBtn" style="width: 17%;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">搜索</button>
					<button class="resetBtn" style="width: 17%;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">重置</button>
				</div>
			</form>
				[#if page.content?has_content]
				<ul>
					[#list page.content as newLaunch]
						<a href="${base}/new_launch/detail?launchId=${newLaunch.id}" style="text-decoration: none;">
							<li>
								<div>
									<span>主题：${newLaunch.name}</span>
									<span>发布者：${newLaunch.creatUser}</span>
									<span>${newLaunch.creatTime}</span>
								</div>
								<div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;font-size: 14px;">
									<span>内容简介：</span>
									[#noautoesc]
										${newLaunch.synopsis}
									[/#noautoesc]
								</div>
							</li>
						</a>
					[/#list]
					
				</ul>
				[/#if]
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "${base}/new_launch/list[#if {pageNumber} > 1]?pageNumber={pageNumber}[/#if]"]
						[#if totalPages > 1]
							<div class="panel-footer text-right">
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