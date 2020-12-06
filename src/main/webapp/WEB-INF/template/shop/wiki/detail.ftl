<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "WIKI_DETAIL"]
		[#if wiki.seoKeywords?has_content]
			<meta name="keywords" content="${wiki.seoKeywords}">
		[#elseif seo.resolveKeywords()?has_content]
			<meta name="keywords" content="${seo.resolveKeywords()}">
		[/#if]
		[#if wiki.seoDescription?has_content]
			<meta name="description" content="${wiki.seoDescription}">
		[#elseif seo.resolveDescription()?has_content]
			<meta name="description" content="${seo.resolveDescription()}">
		[/#if]
		<title>[#if wiki.seoTitle?has_content]${wiki.seoTitle}[#else]${seo.resolveTitle()}[/#if][#if showPowered] - 北京芯梦国际科技有限公司[/#if]</title>
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
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $hits = $("#hits");
				
				// 点击数
				$.get("${base}/wiki/hits/${wiki.id}").done(function(data) {
					$hits.text(data.hits);
				});
			
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="shop article-detail">
	[#assign wikiCategory = wiki.wikiCategory /]
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					[#include "/shop/include/hot_wiki_category.ftl" /]
					[#include "/shop/include/hot_wiki.ftl" /]
					[#include "/shop/include/wiki_search.ftl" /]
				</div>
				<div class="col-xs-10">
					<ol class="breadcrumb">
						<li>
							<a href="${base}/">
								<i class="iconfont icon-homefill"></i>
								${message("common.breadcrumb.index")}
							</a>
						</li>
						[@wiki_category_parent_list wikiCategoryId = wikiCategory.id]
							[#list wikiCategories as wikiCategory]
								<li>
									<a href="${base}${wikiCategory.path}">${wikiCategory.name}</a>
								</li>
							[/#list]
						[/@wiki_category_parent_list]
						<li class="active">
							<a href="${base}${wikiCategory.path}">${wikiCategory.name}</a>
						</li>
					</ol>
					<div class="article-content panel panel-default">
						<div class="panel-heading">
							<h4>${wiki.title}</h4>
							<span>${wiki.createdDate?string("yyyy-MM-dd HH:mm:ss")}</span>
							<span>${message("shop.wiki.author")}: ${wiki.author!"-"}</span>
							<span>
								<i class="iconfont icon-attentionfill"></i>
								<span id="hits">${wiki.hits}</span>
							</span>
						</div>
						<div class="panel-body">
							[#noautoesc]
								${wiki.getPageContent(pageNumber)}
							[/#noautoesc]
						</div>
						[@pagination pageNumber = pageNumber totalPages = wiki.totalPages pattern = "${base}/wiki/detail/" + wiki.id + "_{pageNumber}"]
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