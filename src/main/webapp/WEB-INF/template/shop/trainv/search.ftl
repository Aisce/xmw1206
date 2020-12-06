<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="sponsor" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "TRAINV_SEARCH"]
		[#if seo.resolveKeywords()?has_content]
			<meta name="keywords" content="${seo.resolveKeywords()}">
		[/#if]
		[#if seo.resolveDescription()?has_content]
			<meta name="description" content="${seo.resolveDescription()}">
		[/#if]
		<title>${seo.resolveTitle()}[#if showPowered] - 北京芯梦国际科技有限公司[/#if]</title>
	[/@seo]
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/article.css" rel="stylesheet">
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
<body class="shop trainv-list">
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					[#include "/shop/include/hot_trainv.ftl" /]
					[#include "/shop/include/trainv_search.ftl" /]
				</div>
				<div class="col-xs-10">
					<ol class="breadcrumb">
						<li>
							<a href="${base}/">
								<i class="iconfont icon-homefill"></i>
								${message("common.breadcrumb.index")}
							</a>
						</li>
						<li class="active">${message("shop.trainv.searchPath", trainvKeyword)}</li>
					</ol>
					<div class="list panel panel-default">
						<div class="panel-body">
							[#if page.content?has_content]
								<ul>
									[#list page.content as trainv]
										<li>
											<h4>
												<a href="${base}${trainv.path}" title="${trainv.subject}">${abbreviate(trainv.subject, 80, "...")}</a>
												[#if trainv.sponsor?has_content]
													<span class="small">${trainv.sponsor}</span>
												[/#if]
												<span class="small" title="${trainv.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${trainv.createdDate}</span>
											</h4>
											<p>${abbreviate(trainv.text, 220, "...")}</p>
										</li>
									[/#list]
								</ul>
							[#else]
								<div class="no-result">
									[#noautoesc]${message("shop.trainv.noSearchResult", trainvKeyword?html)}[/#noautoesc]
								</div>
							[/#if]
						</div>
						[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "${base}/trainv/search?keyword=" + trainvKeyword + "[#if {pageNumber} > 1]&pageNumber={pageNumber}[/#if]"]
							[#if totalPages > 1]
								<div class="panel-footer text-right">
									[#include "/shop/include/pagination.ftl" /]
								</div>
							[/#if]
						[/@pagination]
					</div>
				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>