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
	<link href="${base}/resources/shop/new_trainv/detail.less" type="text/css" rel="stylesheet/less">
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
<script type="text/javascript">
	window.onload = function(){
		var i = new Date(${trainv.pxStartDate})
		var j = new Date(${trainv.pxEndDate})
		
		var e = new Date(i).getTime() - new Date(j).getTime();
		$("#spanid").val(e)
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
						<li>
							<a href="${base}/new_trainv/list">
								${message("shop.trainv.name")}
							</a>
						</li>
						<li class="active">${trainv.subject}</li>
					</ol>
				</div>
			</div>
			<div id="listContent" style="margin-top: 0px;">
			<div class="left" style="margin-top: -50.5px;">
				[#include "/shop/include/product_fine_list.ftl" /]
			</div>
			<div class="list">
				<div id="needForm">
					<h3 style="margin-top: -19px;">培训信息</h3>
					<div class="mainInfo">
						<div class="infoTitle">【${message("shop.trainv.xuqiugaikuang")}】</div>
						<div class="main">
							<div>
								<span>
									${message("shop.trainv.sponsor")}
									<input disabled type="text" value="${trainv.sponsor}"/>	
								</span>
								<span>
									${message("shop.trainv.time")}
									<input disabled type="text" value="${trainv.pxStartDate}"/>	
								</span>
							</div>
							<div>
								<span>
									${message("shop.trainv.huiqi")}
									<input disabled id="spanid" type="text" value=""/>	
								</span>
								<span>
									${message("shop.trainv.address")}
									<input disabled type="text" value="${trainv.address}"/>	
								</span>
							</div>
							<div>
								<span>
									${message("shop.information.seoDescription")}
									<textarea type="text" rows="10" cols="100">${trainv.synopsis}</textarea>
								</span>
							</div>
							
						</div>
					</div>
					<div class="detailedInfo">
						<div class="infoTitle">【${message("shop.trainv.xiangqing")}】</div>
						<div class="detailed">
							<div>
								[#noautoesc]
									${trainv.content}
								[/#noautoesc]
							</div>
							[#if currentUser.attestationFlag == 'REAL']
								<button>（实名用户）我要报名</button>
							[/#if]
						</div>
					</div>
				</div>
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