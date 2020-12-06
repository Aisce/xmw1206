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
<script type="text/javascript">
	function search(){
		$("#rform").submit();
	}
</script>
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
						<li class="active">产品需求</li>
					</ol>
				</div>
			</div>
			<div id="listContent" style="margin-top: 0px;">
			<div class="left" style="margin-top: -50.5px;">
				[#include "/shop/include/product_fine_list.ftl" /]
			</div>
			<div class="list">
				<form action="${base}/demand_management/list" method="get" id="rform">
					<div class="search">
						<span>
							<img src="${base}/resources/shop/images/search.png"/>
							<input type="text" id="title" name="name" placeholder="请输入主题" />
						</span>
						<span>
							<img src="${base}/resources/shop/images/search.png"/>
							<input type="text" id="demandUser" name="demandUser" placeholder="请输入需求方" />
						</span>
						<button class="searchBtn" onclick="search()" style="width: 67px;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">搜索</button>
						<button class="resetBtn" onclick="reset()" style="width: 67px;height: 26px;vertical-align: middle;text-align: center;line-height: 23px;">重置</button>
					</div>
				</form>
				[#if page.content?has_content]
					<ul>
						[#list page.content as demandManagement]
							<a href="${base}/demand_management/detail?demandId=${demandManagement.id}" style="text-decoration: none;">
								<li>
									<div>
										<span>产品：${demandManagement.name}</span>
										<span>需求类型：
											[#if demandManagement.typeNorms == 0]
												研发
											[#else]
												采购
											[/#if]
										</span>
										<span>需求数量：${demandManagement.number}</span>
										<span>质量等级：${demandManagement.weight}</span>
										<span>需方：${demandManagement.demandUser}</span>
										<span>${demandManagement.createdDate}</span>
									</div>
									<div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;font-size: 14px;">
										<span>内容简介：</span>
										[#noautoesc]
											${demandManagement.synopsis}
										[/#noautoesc]
									</div>
								</li>
							</a>
						[/#list]
						
					</ul>
				[/#if]
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "${base}/demand_management/list[#if {pageNumber} > 1]?pageNumber={pageNumber}[/#if]"]
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