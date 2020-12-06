<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "INDEX"]
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
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/jquery.bxslider.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/index.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/common/js/jquery.bxslider.js"></script>
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
				
				var $window = $(window);
				var $topbar = $("#topbar");
				var $topbarProductSearchForm = $("#topbar form");
				var $topbarProductSearchKeyword = $("#topbar input[name='keyword']");
				var $mainSlider = $("#mainSlider");
				var $sideSlider = $("#sideSlider");
				var $featuredProductSlider = $(".featured-product .slider");
				var topbarHidden = true;
				
				// 顶部栏
				$window.scroll(_.throttle(function() {
					if ($window.scrollTop() > 500) {
						if (topbarHidden) {
							topbarHidden = false;
							$topbar.velocity("transition.slideDownIn", {
								duration: 500
							});
						}
					} else {
						if (!topbarHidden) {
							topbarHidden = true;
							$topbar.velocity("transition.slideUpOut", {
								duration: 500
							});
						}
					}
				}, 500));
				
				// 产品搜索
				$topbarProductSearchForm.submit(function() {
					if ($.trim($topbarProductSearchKeyword.val()) === "") {
						return false;
					}
				});
				
				// 主轮播广告
				$mainSlider.bxSlider({
					mode: "fade",
					auto: true,
					controls: false,
				});
				
				// 侧边轮播广告
				$sideSlider.bxSlider({
					pager: false,
					auto: true,
					nextText: "&#xe6a3;",
					prevText: "&#xe679;"
				});
				
				// 推荐产品轮播广告
				$featuredProductSlider.bxSlider({
					pager: false,
					auto: true,
					nextText: "&#xe6a3;",
					prevText: "&#xe679;"
				});
			
$('.index-slider').bxSlider({
controls:true,
auto:false,
pager:false
}); 

$(".bx-prev").html("&lt;");

$(".bx-next").html("&gt;")

			});
			</script>
		[/#escape]
	[/#noautoesc]
        <style type='text/css'>
.ad-product-category-wrapper>.ad>a,.ad-product-category-wrapper>.ad{
display:inline-block;
width:100%;
height:100%;
}
                .ad-product-category-wrapper img{
width:100%;
height:100%; 
                }
.ad-product-category-wrapper{
height:250px !important;
}
.index .featured-product .featured-product-body .product li{
width:25% !important;
}
.index .featured-product .featured-product-body .product li:nth-child(4n+1){
border-left: 1px solid #eeeeee;
}
.index .featured-product .featured-product-body .product li:nth-child(-n+4){
border-top: 1px solid #eeeeee;
}
#mainSlider{
width:920px !important;
height:340px !important;
left:50%;
transform:translateX(-50%);
}
#mainSlider li{
width:100% !important;
height:100% !important;
}
#jiabansb{
position: relative;
    margin-top: -340px;
    right: -1135px;
font-size: 0px;
    padding: 0;
height: 500px;
}
#jiabansb>a{
display: inline-block;
    width: 50%;
    text-align: center;
    border: 1px solid gainsboro;
    box-sizing: border-box;
    height: 166.6px;
    vertical-align: top;
    padding: 30px 18px;
    cursor: pointer;
}
#jiabansb>a>img{
    height: 70px;
}
#jiabansb>a>div{
font-size: 14px;
    margin-top: 20px;
}
.index .main-slider li a{
height:340px
}
.slider-content{
position: relative;
    margin-top: -180px;
    left: 215px;
    height: 160px;
    width: 920px;
    padding: 8px 8px 0 8px;
    box-sizing: border-box;
}
.slider-content>div:first-child{
background: #4289C7;
    color: white;
    padding: 4px 10px;
    box-sizing: border-box;
    height: 26px;
    line-height: 18px;
    margin-bottom: 7px;
}
.index-slider{
height:120px;
}
.index-slider>li{
display:flex;
height:120px;
}
.index-slider>li>div{
height: 120px;
    border: 1px solid gainsboro;
    width: 20%;
    padding: 14px;
    box-sizing: border-box;
    text-align: center;
}
.index-slider>li>div>p{
margin-bottom: 4px;
}
.index-slider>li>div>img{
width: 70px;
    height: 50px;
    margin: 0 auto;
}

.main-content{
    font-size: 0;
}
.main-content>.val{
display: inline-block;
    width: 49%;
    height: 400px;
    border: 1px solid #d3d3d3;
    box-shadow: 0 0 4px gainsboro;
    vertical-align: top;
}
.main-content>.val:nth-child(2n){
margin-left: 2%;
}
.main-content>.val:nth-child(-n+2){
margin-bottom: 2%;
}
.main-content>.val>.title{
border-bottom: 1px solid gainsboro;
    font-size: 16px;
    color: #4289C7;
    line-height: 34px;
    padding: 0 10px;
    font-weight: bold;
}
.main-content>.val>ul{
padding: 16px 14px;
}
.main-content>.val>ul>li{
transition:all .3s
}
.main-content>.val>ul>li:not(:last-child){
margin-bottom:13px;
}
.main-content>.val>ul>li>a{
cursor:pointer;
}
.main-content>.val>ul>li:hover{
color:initial;
transform:scale(1.01);
}
.main-content>.val>ul>li>a:hover{
color:initial;
}
.main-content>.val>ul>li>a>div:first-child{
margin-bottom: 4px;
}
.main-content>.val>ul>li>a>div:first-child>span{
display:inline-block;
width:33%;
font-size:14px;
}
.main-content>.val>ul>li>a>div:last-child{
color:gray;
overflow:hidden;
text-overflow:ellipsis;
white-space:nowrap;
font-size:14px;
}
.main-content>.val>ul>li>a>div:last-child>span{
color:black;
}
.footer-change{
margin-bottom:18px;
}
.footer-change>.title{
margin: 18px 0;
    padding: 10px 14px;
    font-size: 16px;
    border: 1px solid #d3d3d3;
    color: #4289C7;
    font-weight: bold;
}
.footer-change>ul{
display:flex;
justify-content: space-between;
}
.footer-change>ul>li{
width: 10%;
    border: 1px solid #d3d3d3;
    height: 100px;
    position: relative;
}
.footer-change>ul>li a{
display:inline-block;
 width: 100%;
    height: 100%;
}
.footer-change>ul>li img{
    position: absolute;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}
.footer-change>ul>li div{
position: absolute;
    bottom: 0;
    width: 100%;
    background: rgba(0,0,0,.6);
    color: white;
    height: 20px;
    line-height: 20px;
    padding-left: 10px;
font-size: 14px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.imgContent li a>div:first-child{
display: inline-block;
}
.imgContent li a>div:first-child img{
width:40px;
height:40px;
}
.imgContent li a>div:last-child{
display: inline-block;
    vertical-align: middle;
    margin-left: 10px;
    width: calc(100% - 50px);
}
.imgContent li a>div:last-child span{
display:inline-block;
width:33%;
overflow:hidden;
text-overflow:ellipsis;
white-space:nowrap;
}
        </style>
</head>
<body class="shop index">
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<div id="topbar" class="topbar">
			<div class="container">
				<div class="row">
					<div class="col-xs-4">
						<a href="${base}/">
							<img class="logo" src="${setting.logo}" alt="${setting.siteName}">
						</a>
					</div>
					<div class="col-xs-5">
						<div class="product-search">
							<form action="${base}/product/search" method="get">
								<input name="keyword" type="text" placeholder="${message("shop.index.productSearchKeywordPlaceholder")}" autocomplete="off" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search">
								<button type="submit">
									<i class="iconfont icon-search"></i>
									${message("shop.index.productSearchSubmit")}
								</button>
							</form>
						</div>
					</div>
					<div class="col-xs-3">
						<div class="cart">
							<i class="iconfont icon-cart"></i>
							<a href="${base}/cart/list">${message("shop.index.cart")}</a>
							<em>0</em>
						</div>
					</div>
				</div>
			</div>
		</div>
		[@ad_position id = 2]
			[#if adPosition??]
				[#noautoesc]${adPosition.resolveTemplate()}[/#noautoesc]
			[/#if]
		[/@ad_position]
		<div class="container">
                        
                        <div class='row'>
                            <div class='col-xs-2' id='jiabansb'>
                                <a href="${base}/xm_navigation/list"><img src='${base}/resources/shop/images/hydh.png'/><div>芯梦导航</div></a>
								<a href="/wiki/list" target="_blank"><img src='${base}/resources/shop/images/zsk.png'/><div>知识库</div></a>
								<a href="${base}/shop/mechanism_store/list"><img src='${base}/resources/shop/images/bzhjg.png'/><div>标准化机构</div></a>
								<a href="${base}/shop/mechanism_store/check_list"><img src='${base}/resources/shop/images/jcjg.png'/><div>检测机构</div></a>
								<a href="${base}/shop/mechanism_store/purchase_page"><img src='${base}/resources/shop/images/fzcg.png'/><div>辅助采购</div></a>
								<a href="${base}/sample/list"><img src='${base}/resources/shop/images/sqyp.png'/><div>索取样片</div></a>
                            </div>
                       </div>
			<div class="row">
				<div class="col-xs-2">
					[@product_category_root_list count = 10]
						<div class="product-category-menu" style='margin-top:-500px'>
							<ul>
								[#list productCategories as productCategory]
									<li style='padding-bottom: 0;'>
										[#switch productCategory_index]
											[#case 0]
												<i class="iconfont icon-mobile"></i>
												[#break /]
											[#case 1]
												<i class="iconfont icon-camera"></i>
												[#break /]
											[#case 2]
												<i class="iconfont icon-dress"></i>
												[#break /]
											[#case 3]
												<i class="iconfont icon-choiceness"></i>
												[#break /]
											[#case 4]
												<i class="iconfont icon-present"></i>
												[#break /]
											
											[#default]
												<i class="iconfont icon-goodsfavor"></i>
										[/#switch]
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
										[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 2]
											<p style='overflow: hidden;  text-overflow: ellipsis;  white-space: nowrap;'>
												[#list productCategories as productCategory]
													<a href="${base}${productCategory.path}">${productCategory.name}</a>
												[/#list]
											</p>
										[/@product_category_children_list]
										[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 5]
											<div class="product-category-menu-content">
												<div class="row">
													<div class="col-xs-9">
														[@promotion_list productCategoryId = productCategory.id hasEnded = false count = 6]
															[#if promotions?has_content]
																<ul class="promotion clearfix">
																	[#list promotions as promotion]
																		<li>
																			<a href="${base}${promotion.path}" title="${promotion.name}">${promotion.name}</a>
																			<i class="iconfont icon-right"></i>
																		</li>
																	[/#list]
																</ul>
															[/#if]
														[/@promotion_list]
														[#list productCategories as productCategory]
															<dl class="product-category clearfix">
																<dt class="text-overflow">
																	<a href="${base}${productCategory.path}" title="${productCategory.name}">${productCategory.name}</a>
																</dt>
																[@product_category_children_list productCategoryId = productCategory.id recursive = false]
																	[#list productCategories as productCategory]
																		<dd>
																			<a href="${base}${productCategory.path}">${productCategory.name}</a>
																		</dd>
																	[/#list]
																[/@product_category_children_list]
															</dl>
														[/#list]
													</div>
													<div class="col-xs-3">
														[@brand_list productCategoryId = productCategory.id type = "IMAGE" count = 10]
															[#if brands?has_content]
																<ul class="brand clearfix">
																	[#list brands as brand]
																		<li>
																			<a href="${base}${brand.path}" title="${brand.name}">
																				<img class="img-responsive center-block" src="${brand.logo}" alt="${brand.name}">
																			</a>
																		</li>
																	[/#list]
																</ul>
															[/#if]
														[/@brand_list]
														[@promotion_list productCategoryId = productCategory.id hasEnded = false count = 2]
															[#if promotions?has_content]
																<ul class="promotion-image">
																	[#list promotions as promotion]
																		<li>
																			[#if promotion.image?has_content]
																				<a href="${base}${promotion.path}" title="${promotion.name}">
																					<img class="img-responsive center-block" src="${promotion.image}" alt="${promotion.name}">
																				</a>
																			[/#if]
																		</li>
																	[/#list]
																</ul>
															[/#if]
														[/@promotion_list]
													</div>
												</div>
											</div>
										[/@product_category_children_list]
									</li>
								[/#list]
							</ul>
						</div>
					[/@product_category_root_list]
				</div>
				<!-- <div class="col-xs-2 col-xs-offset-8">
					[@article_category_root_list count = 2]
						[#if articleCategories?has_content]
							<div class="article">
								<ul class="nav nav-pills nav-justified">
									[#list articleCategories as articleCategory]
										<li[#if articleCategory_index == 0] class="active"[/#if]>
											<a href="#articleCategory_${articleCategory.id}" data-toggle="tab">${articleCategory.name}</a>
										</li>
									[/#list]
								</ul>
								<div class="tab-content">
									[#list articleCategories as articleCategory]
										<div id="articleCategory_${articleCategory.id}" class="tab-pane fade[#if articleCategory_index == 0] active in[/#if]">
											[@article_list articleCategoryId = articleCategory.id count = 8]
												<ul>
													[#list articles as article]
														<li class="text-overflow">
															<a href="${base}${article.path}" title="${article.title}" target="_blank">${abbreviate(article.title, 40)}</a>
														</li>
													[/#list]
												</ul>
											[/@article_list]
										</div>
									[/#list]
								</div>
							</div>
						[/#if]
					[/@article_category_root_list]
					[@ad_position id = 3]
						[#if adPosition??]
							[#noautoesc]${adPosition.resolveTemplate()}[/#noautoesc]
						[/#if]
					[/@ad_position]
				</div> -->
			</div>

<div class='row' style="position:absolute">
	<div class="slider-content">
		<div>优秀产品推荐</div>
			<ul class='col-xs-2 index-slider' >
				<li>
					[@product_fine count = 5 isFine = true]
						[#list productFine as product]
							[#if product_index != 0 && product_index %5 == 0]
							</li><li>
							[/#if]
							<div>
								<a href="${base}${product.path}" style='height:100%'>
								<p style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>${product.name}</p>
								<p>LS883</p>
								<img style="height: 62.222%; display: block; margin: 0 auto;" src="${product.thumbnail!setting.defaultThumbnailProductImage}">
								</a>
							</div>
						[/#list]
					[/@product_fine]
				</li>
			</ul>
		</div>
	</div>

<!-- 四块内容 -->
	<div class='main-content' style="width: 101.5%;">
		<div class='val imgContent'>
			<div class="title">新品发布<a href="${base}/new_launch/list" style="float: right;">···</a></div>
			<ul>
				[@new_release_list count = 6 useCache = false]
					[#list adNewReleases as adNewRelease]
						<li style="margin-bottom:7px;">
						<a href="${base}/new_launch/detail?launchId=${adNewRelease.id}">
							<div>
								<img src="${adNewRelease.productImages}"> 
							</div>
							<div>
								<div>
									<span>${adNewRelease.typeNorms}</span>
									<span>定型时间：${adNewRelease.stereotypeTime}</span>
								</div>
									
								<div>
									<span>产品名称：${adNewRelease.name}</span>
									<span>质量等级：${adNewRelease.weight}</span>
									<span>生产厂商：${adNewRelease.unit}</span>
								</div>
							</div>
							
						</a>
						</li>
					[/#list]
				[/@new_release_list]
			</ul>
		</div>
		<div class='val'>
			<div class="title">集成电路产品需求 <a href="${base}/demand_management/list" style="float: right;">···</a></div>
			<ul>
				[@demand_management_list count = 6]
					[#list demandManagement as demand_management]
						<li>
							<a href="${base}/demand_management/detail?demandId=${demand_management.id}">
								<div>
									<span>产品：${demand_management.name}</span>
									<span>需方：${demand_management.demandUser}</span>
									<span>${demand_management.createdDate}</span>
								</div>
								
								<div>
									[#if demand_management.synopsis?has_content]
										[#noautoesc]
											<span>需求简介：</span>${demand_management.synopsis}
										[/#noautoesc]
									[/#if]
								</div>
							</a>
						</li>
					[/#list]
				[/@demand_management_list]
			</ul>
		</div>

		<div class='val'>
			<div class="title">培训信息<a href="${base}/new_trainv/list" style="float: right;">···</a></div>
			<ul>
				[@trainv_list count = 6]
					[#list trainvs as trainv]
						<li>
							<a href="${base}/new_trainv/detail?trainvId=${trainv.id}">
								<div>
									<span>主题：${trainv.subject}</span>
									<span>主办方：${trainv.sponsor}</span>
									<span>培训时间：${trainv.pxStartDate}</span>
								</div>
								<div>
									<span>培训内容简介：</span>${trainv.synopsis}
								</div>
							</a>
						</li>
					[/#list]
				[/@trainv_list]
				
			</ul>
		</div>
		<div class='val'>
			<div class="title">芯梦观点<a href="${base}/information/list" style="float: right;">···</a></div>
			<ul>
				[@information_list count = 6]
					[#list information as information]
						<li>
							<a href="${base}/information/detail?informationId=${information.id}">
								<div>
									<span>主题：${information.title}</span>
									<span>发布者：${information.author}</span>
									<span>${information.createdDate}</span>
								</div>
								<div>
									<span>内容简介：</span>${information.seoDescription}
								</div>
							</a>
						</li>
					[/#list]
				[/@information_list]
				
			</ul>
		</div>
	<!--</div>-->

		<div class='footer-change'>
			<div class='title'>优秀厂家展示</div>
			<ul>
				[@store_fine_list count = 9 status = "SUCCESS" isFine = true]
					[#list store_fine as fine]
						<li>
							<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${fine.id}" target="_blank"><img src="${fine.logo}"/>
							<div title="${fine.name}">${fine.name}</div></a>
						</li>
					[/#list]
				[/@store_fine_list]
			</ul>
		</div>
                        
			
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>