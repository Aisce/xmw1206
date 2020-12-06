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
	<link href="${base}/resources/shop/css/reset.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/listContent.css" rel="stylesheet">
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
</head>
<body class="shop article-list">
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
				</div>
				<div class="col-xs-10" style="width: 68.333333%;">
					<ol class="breadcrumb">
						<li>
							<a href="${base}/">
								<i class="iconfont icon-homefill"></i>
								${message("common.breadcrumb.index")}
							</a>
						</li>
						<li class="active">培训信息</li>
					</ol>
				</div>
			</div>
			<div id="listContent" style="margin-top: 0px;">
			<div class="left" style="margin-top: -50.5px;">
				[#include "/shop/include/product_fine_list.ftl" /]
			</div>
			<div class="list">
			<form action="${base}/new_trainv/list" method="get" id="rform">
				<div class="search">
					<span>
						<img src="${base}/resources/shop/images/search.png"/>
						<input type="text" name="subject" placeholder="请输入主题" />
					</span>
					<span>
						<img src="${base}/resources/shop/images/search.png"/>
						<input type="text" name="sponsor" placeholder="请输入发布者" />
					</span>
					<button class="searchBtn" style="width: 67px;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">搜索</button>
					<button class="resetBtn" style="width: 67px;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">重置</button>
				</div>
			</form>
				[#if page.content?has_content]
				<ul>
					[#list page.content as trainv]
						<a href="${base}/new_trainv/detail?trainvId=${trainv.id}" style="text-decoration: none;">
							<li>
								<div>
									<span>主题：${trainv.subject}</span>
									<span>主办方：${trainv.sponsor}</span>
									<span>培训时间${trainv.pxStartDate}</span>
								</div>
								<div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;font-size: 14px;">
									<span>内容简介：</span>
									[#noautoesc]
										${trainv.synopsis}
									[/#noautoesc]
								</div>
							</li>
						</a>
					[/#list]
				</ul>
				[/#if]
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "${base}/new_trainv/list[#if {pageNumber} > 1]?pageNumber={pageNumber}[/#if]"]
						[#if totalPages > 1]
							<div class="panel-footer text-right">
								[#include "/shop/include/pagination.ftl" /]
							</div>
						[/#if]
				[/@pagination]
			</div>
			<div class="right" style="margin-top: -50.5px;">
				[#include "/shop/include/store_fine_list.ftl" /]
			</div>
		</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>