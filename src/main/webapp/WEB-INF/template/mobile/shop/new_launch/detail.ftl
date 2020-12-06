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
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/reset.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/listContent.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/new_launch/detail.less" type="text/css" rel="stylesheet/less">
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
					<h5>新品发布详情</h5>
				</div>
			</div>
		</div>
	</header>
	<main>
		<div class="container">
			<div id="listContent" style="margin-top: 0px;">
			<div class="list">
				<div id="needForm">
					<h3 style="margin-top: 0px;">集成电路新品<a style="margin-left: 10px;" href="${base}${launch.productId.path}">${launch.productId.name}</a></h3>
					<div class="mainInfo">
						<div class="infoTitle">【${message("shop.launch.synopsis")}】</div>
						<div class="main">
							<div>
								<span>
									产品名称
									<input disabled onclick="javascript: top.location.href = '${base}${launch.productId.path}'" type="text" value="${launch.productId.name}"/>	
								</span>
								<span>
									定型时间
									<input disabled type="text" value="${launch.stereotypeTime}"/>	
								</span>
							</div>
							<div>
								<span>
									质量等级
									<input disabled type="text" value="${launch.weight}"/>	
								</span>
								<span>
									生产厂家
									<input disabled type="text" value="${launch.unit}"/>	
								</span>
							</div>
						</div>
					</div>
					<div class="detailedInfo">
						<div class="infoTitle">【${message("shop.launch.notice")}】</div>
						<div class="detailed">
							<div>
								[#noautoesc]
									${launch.introduction}
								[/#noautoesc]
							</div>
						</div>
					</div>
					<div class="urlInfo">
						<div class="infoTitle">【${message("shop.launch.link")}】</div>
						<div class="urlInfos">
							<div>
								<img src="${launch.productId.productImages[0].thumbnail}"/>
							</div>
							<div>
								<div class="title">${launch.productId.name}</div>
								<div>
									<span>产品名称：<a href="${base}${launch.productId.path}" style="">${launch.productId.name}</a></span>
									<span>质量等级：${launch.weight}</span>
								</div>
								<div>
									<span>定型时间：${launch.stereotypeTime}</span>
									<span>生产厂家：${launch.unit}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</main>
	<footer class="adaptation-sty footer-default html5plus-hidden" data-spy="scrollToFixed" data-bottom="0"style="z-index: 100;position: fixed; bottom: 0px;margin-left: 0px;width: 100%;left: 0px;">
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