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
		<title>辅助采购 - 北京芯梦国际科技有限公司</title>
	[/@seo]
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/reset.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/listContent.css" rel="stylesheet">
	<link href="${base}/resources/shop/sample/list.less" type="text/css" rel="stylesheet/less">
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
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
				</div>
				<div class="col-xs-10" style="width: 100%;">
					<ol class="breadcrumb">
						<li>
							<a href="${base}/">
								<i class="iconfont icon-homefill"></i>
								${message("common.breadcrumb.index")}
							</a>
						</li>
						<li class="active">索取样片</li>
					</ol>
				</div>
			</div>
			<div class="list">
				<div class="content">
					<div class="head">
						<span>产品类型</span>
						<span>供应厂家</span>
						<span>品牌</span>
						<span>批次号</span>
						<span>产品规范</span>
						<span>参数说明</span>
						<span>最大申请数</span>
						<span>领取</span>
					</div>
					[#if page.content?has_content]
						[#list page.content as sample]
							<div class="body">
								<span>
									<a href="${base}/product/detail/${sample.id}">
									<img src="${sample.productImages[0].thumbnail}" onerror="this.src='${base}/resources/shop/images/default_thumbnail_product_image.png'"/>
									</a>
									<div>
										<a href="${base}/product/detail/${sample.id}"><p style="width: 110px; white-space: nowrap; text-overflow: ellipsis;overflow: hidden;">${sample.name}</p></a>
										<p>${sample.productCategory.name}</p>
									</div>
								</span>
								<span>
									<a>${sample.store.name}</a>
								</span>
								<span>
									${sample.brand.name}
								</span>
								<span>
									${sample.cpxh}
								</span>
								<span>
									<a href="${sample.cpsc}">产品规范</a>
								</span>
								<span>
									<p>封装：${sample.fzxs}</p>
									<p>封装厂家：${sample.store.name}</p>
									<p>包装方式：${sample.fzxs}</p>
								</span>
								<span>2</span>
								<span>
									<button onClick="location.href='${base}/product/detail/${sample.id}'">免费领取</button>
								</span>
							</div>
						[/#list]
					[/#if]
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
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>