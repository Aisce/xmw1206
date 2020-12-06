<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
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
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/jquery.bxslider.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/index.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.scrolltofixed.js"></script>
	<script src="${base}/resources/common/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/common/js/jquery.bxslider.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/jquery.base64.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/jweixin.miniProgram.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/mobile/shop/js/base.js"></script>
	<script id="memberInfoTemplate" type="text/template">
		<a href="${base}/member/index">
			<i class="iconfont icon-people"></i>
		</a>
	</script>
	
	
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {

				var $searchPlaceholder = $("#searchPlaceholder");
				var $memberInfo = $("#memberInfo");
				var $search = $("#search");
				var $searchCollapse = $("#searchCollapse");
				var $searchForm = $("#searchForm");
				var $searchType = $("#searchForm [data-search-type]");
				var $keyword = $("#searchForm [name='keyword']");
				var $mainSlider = $("#mainSlider");
				var memberInfoTemplate = _.template($("#memberInfoTemplate").html());

				// 会员信息
				$memberInfo.html(memberInfoTemplate({
					currentUser: $.getCurrentUser()
				}));

				// 搜索
				$searchPlaceholder.click(function() {
                    $search.velocity("transition.slideDownBigIn", 400);
				});
				
				// 搜索
				$searchCollapse.click(function() {
                    $search.velocity("transition.slideUpBigOut", 400);
				});
				
				// 搜索
				$searchForm.submit(function() {
					if ($.trim($keyword.val()) === "") {
						return false;
					}
				});

				// 搜索类型
				$searchType.click(function() {
					var $element = $(this);
					var searchType = $element.data("search-type");
					
					$element.closest("div.input-group").find("[data-toggle='dropdown'] span:not(.caret)").text($element.text());
					
					switch (searchType) {
						case "product":
							$searchForm.attr("action", "${base}/product/search");
							break;
						case "store":
							$searchForm.attr("action", "${base}/store/search");
							break;
					}
				});

				// 主轮播广告
				$mainSlider.bxSlider({
					auto: true,
					controls: false
				});

                // TitleNView搜索
				$.setCurrentWebviewStyle("titleNView.searchInput.placeholder", "${message("shop.product.search")}");

			});
			</script>
		[/#escape]
	[/#noautoesc]
	<style type='text/css'>
		.main-content{
		    font-size: 0;
		}
		.main-content>.val{
			display: inline-block;
		    width: calc(100% - 8px);
		    height: 400px;
		    border: 1px solid #d3d3d3;
		    box-shadow: 0 0 4px gainsboro;
		    vertical-align: top;
		    box-sizing:border-box;
		}
		.main-content>.val:nth-child(2n){
			margin-left: 0%;
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
		.main-content>.val.imgContent>ul>li>a>div:first-child{
			margin-bottom: 4px;
			display:inline-block;
			width:40px;
			margin-right：10px;
		}
		.main-content>.val.imgContent>ul>li>a>div:first-child img{
			width:100%;
		}
		.main-content>.val>ul>li>a>div:first-child>span{
			display:inline-block;
			width:33%;
			font-size:14px;
			overflow:hidden;
			text-overflow:ellipsis;
			white-space:nowrap;
		}
		.main-content>.val>ul>li>a>div:last-child{
			color:gray;
			overflow:hidden;
			text-overflow:ellipsis;
			white-space:nowrap;
			font-size:14px;
		}
		.main-content>.val.imgContent>ul>li>a>div:last-child{
			color:gray;
			overflow:hidden;
			text-overflow:ellipsis;
			white-space:nowrap;
			font-size:14px;
			display:inline-block;
			width:calc(100% - 50px);
			vertical-align:middle;
		}
		.main-content>.val>ul>li>a>div:last-child>span{
			color:black;
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
		    width: 125%;
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
		.slider-content{
			position: relative;
		    margin-top: 0px;
    		left: -8px;
		    height: 160px;
		    width: 100%;
		    padding: 8px 8px 0 8px;
		    box-sizing: border-box;
		}
		.slider-content>div:first-child{
			background: #4289c700;
		    font-size: 16px;
    		color: #4289C7;
		    padding: 4px 10px;
		    box-sizing: border-box;
		    height: 26px;
		    line-height: 18px;
		    margin-bottom: 7px;
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
			width: 25%;
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
		.footer-change>div:first-child{
			background: #4289c700;
		    font-size: 16px;
    		color: #4289C7;
		    padding: 4px 10px;
		    box-sizing: border-box;
		    height: 26px;
		    line-height: 18px;
		    margin-bottom: 7px;
		}
	</style>
</head>
<body class="shop index">
	<header class="html5plus-hidden">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-2">
					<i id="searchIcon" class="iconfont icon-similar"></i>
				</div>
				<div class="col-xs-8">
					<div id="searchPlaceholder" class="search-placeholder">
						${message("shop.index.productSearchKeywordPlaceholder")}
						<i class="iconfont icon-search"></i>
					</div>
				</div>
				<div class="col-xs-2">
					<div id="memberInfo" class="member-info"></div>
				</div>
			</div>
			<div id="search" class="search">
				<div class="row">
					<div class="col-xs-1">
						<i id="searchCollapse" class="iconfont icon-fold"></i>
					</div>
					<div class="col-xs-10">
						<form id="searchForm" action="${base}/product/search" method="get">
							<div class="input-group">
								<div class="input-group-btn">
									<button class="btn btn-default" type="button" data-toggle="dropdown">
										<span>${message("shop.index.product")}</span>
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li data-search-type="product">
											<a href="javascript:;">${message("shop.index.product")}</a>
										</li>
										<li data-search-type="store">
											<a href="javascript:;">${message("shop.index.store")}</a>
										</li>
									</ul>
								</div>
								<input name="keyword" class="form-control" type="text" placeholder="${message("shop.index.productSearchSubmit")}" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search">
								<div class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<i class="iconfont icon-search"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				[#if setting.hotSearches?has_content]
					<dl class="hot-search clearfix">
						<dt>${message("shop.index.hotSearch")}</dt>
						[#list setting.hotSearches as hotSearch]
							<dd>
								<a href="${base}/product/search?keyword=${hotSearch?url}">${hotSearch}</a>
							</dd>
						[/#list]
					</dl>
				[/#if]
			</div>
		</div>
	</header>
	<main>
		<div class="container-fluid">
			[@ad_position id = 18]
				[#if adPosition??]
					[#noautoesc]${adPosition.resolveTemplate()}[/#noautoesc]
				[/#if]
			[/@ad_position]
			[@navigation_list navigationGroupId = 4 count = 10]
				[#if navigations?has_content]
					<nav class="clearfix">
						[#list navigations as navigation]
							<a href="${navigation.url}" style="width: 20%;">
								[#switch navigation_index]
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
									[#case 5]
										<i class="iconfont icon-evaluate"></i>
										[#break /]
									[#case 6]
										<i class="iconfont icon-favor"></i>
										[#break /]
									[#case 7]
										<i class="iconfont icon-like"></i>
										[#break /]
									[#default]
										<i class="iconfont icon-goodsfavor"></i>
								[/#switch]
								<span >${navigation.name}</span>
								
							</a>
						[/#list]
					</nav>
				[/#if]
			[/@navigation_list]
				<div class="slider-content">
					<div>优秀产品推荐</div>
						<ul class='col-xs-2 index-slider' >
							<li>
								[@product_list count = 5 isFine = true]
									[#list products as product]
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
								[/@product_list]
							</li>
						</ul>
					</div>
				</div>
			<!--四块内容-->
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
		<div class='footer-change'>
			<div>优秀厂家展示</div>
			<ul>
				[@store_fine_list count = 4 status = "SUCCESS" isFine = true]
					[#list store_fine as fine]
						<li>
							<a href="/store/${fine.id}" target="_blank"><img src="${fine.logo}"/>
							<div title="${fine.name}">${fine.name}</div></a>
						</li>
					[/#list]
				[/@store_fine_list]
			</ul>
	    </div>		
			<!--******************************************************************-->
			
			[#if false]
				[@ad_position id = 19]
					[#if adPosition??]
						[#noautoesc]${adPosition.resolveTemplate()}[/#noautoesc]
					[/#if]
				[/@ad_position]
				[@ad_position id = 20]
					[#if adPosition??]
						[#noautoesc]${adPosition.resolveTemplate()}[/#noautoesc]
					[/#if]
				[/@ad_position]
				[@product_category_root_list count = 5]
					[#list productCategories as productCategory]
						[@product_list productCategoryId = productCategory.id productTagId = 1 count = 6]
							[#if products?has_content]
								<div class="featured-product">
									<div class="featured-product-heading">
										<h5>${productCategory.name}</h5>
									</div>
									<div class="featured-product-body">
										<ul class="clearfix">
											[#list products as product]
												<li>
													<a href="${base}${product.path}">
														<img class="lazy-load img-responsive center-block" src="${base}/resources/common/images/transparent.png" alt="${product.name}" data-original="${product.thumbnail!setting.defaultThumbnailProductImage}">
													</a>
													<a href="${base}${product.path}">
														<h5 class="text-overflow" title="${product.name}">${product.name}</h5>
														[#if product.caption?has_content]
															<h6 class="text-overflow" title="${product.caption}">${product.caption}</h6>
														[/#if]
													</a>
												</li>
											[/#list]
										</ul>
									</div>
								</div>
							[/#if]
						[/@product_list]
					[/#list]
				[/@product_category_root_list]
			[/#if]
		</div>
	</main>
	<footer class="adaptation-sty footer-default html5plus-hidden" data-spy="scrollToFixed" data-bottom="0">
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