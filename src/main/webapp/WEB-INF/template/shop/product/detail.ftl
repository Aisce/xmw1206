[#assign defaultSku = product.defaultSku /]
[#assign productCategory = product.productCategory /]
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	[@seo type = "PRODUCT_DETAIL"]
		[#if seo.resolveKeywords()?has_content]
			<meta name="keywords" content="${seo.resolveKeywords()}">
		[/#if]
		[#if seo.resolveDescription()?has_content]
			<meta name="description" content="${seo.resolveDescription()}">
		[/#if]
		<title>${seo.resolveTitle()}[#if showPowered] - 北京芯梦国际科技有限公司[/#if]</title>
	[/@seo]
	<link rel="stylesheet" href="${base}/resources/common/css/pictureViewer.css">
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-spinner.css" rel="stylesheet">
	<link href="${base}/resources/common/css/jquery.jqzoom.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/product.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/jquery.mousewheel.min.js"></script>
	<script src="${base}/resources/common/js/pictureViewer.js"></script>
	<script src="${base}/resources/common/js/jquery.migrate.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.countdown.js"></script>
	<script src="${base}/resources/common/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/common/js/jquery.fly.js"></script>
	<script src="${base}/resources/common/js/jquery.qrcode.js"></script>
	<script src="${base}/resources/common/js/jquery.jqzoom.js"></script>
	<script src="${base}/resources/common/js/jquery.spinner.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/jquery.base64.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/shop/js/base.js"></script>
	<script id="compareProductItemTemplate" type="text/template">
		<li>
			<input name="productIds" type="hidden" value="<%-compareProduct.id%>">
			<div class="media">
				<div class="media-left media-middle">
					<a href="${base}<%-compareProduct.path%>" target="_blank">
						<img class="media-object img-thumbnail" src="<%-compareProduct.thumbnail != null ? compareProduct.thumbnail : "${setting.defaultThumbnailProductImage}"%>" alt="<%-compareProduct.name%>">
					</a>
				</div>
				<div class="media-body media-middle">
					<h5 class="media-heading text-overflow">
						<a href="${base}<%-compareProduct.path%>" title="<%-compareProduct.name%>" target="_blank"><%-compareProduct.name%></a>
					</h5>
					[#if false]
						<strong class="text-red"><%-$.currency(compareProduct.price, true)%></strong>
					[/#if]
					<a class="delete-compare btn btn-default btn-xs btn-icon" href="javascript:;" title="${message("common.delete")}" data-product-id="<%-compareProduct.id%>">
						<i class="iconfont icon-close"></i>
					</a>
				</div>
			</div>
		</li>
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $printModal = $("#printModal");
				var $print = $("#sqyp");
				
				var $addCompare = $("#add-compare");
				var compareProductItemTemplate = _.template($("#compareProductItemTemplate").html());
				var compareProductIdsLocalStorageKey = "compareProductIds";
				var $compareForm = $("#compareForm");
				var $compareBar = $("#compareBar");
				var $compareBody = $("#compareBar .compare-bar-body ul");
				var $compare = $("#compareBar a.compare");
				var $clearCompareBar = $("#compareBar a.clear-compare-bar");
				
				var $rform = $("#rform");
				var $productNotifyForm = $("#productNotifyForm");
				var $productNotifyModal = $("#productNotifyModal");
				var $productNotifyEmail = $("#productNotifyForm input[name='email']");
				var $zoom = $("#zoom");
				var $thumbnailProductImageItem = $("#productImage .thumbnail-product-image .item a");
				var $time = $("#time");
				var $countdown = $("#countdown");
				var $groupSize = $("#groupSize");
				var $progress = $("#progress");
				var $participantProgressBar = $("#participantProgressBar");
				var $price = $("#price");
				var $groupBuyingPrice = $("#groupBuyingPrice");
				var $marketPrice = $("#marketPrice");
				var $rewardPoint = $("#rewardPoint");
				var $exchangePoint = $("#exchangePoint");
				var $participants = $("#participants");
				var $specification = $("#specification");
				var $specificationItem = $("#specification dd");
				var $specificationValue = $("#specification dd a");
				var $quantity = $("#quantity");
				var $buy = $("#buy");
				var $group = $("#group");
				var $addCart = $("#addCart");
				var $exchange = $("#exchange");
				var $addProductNotify = $("#addProductNotify");
				var $actionTips = $("#actionTips");
				var $topbar = $("#topbar");
				var skuId = ${defaultSku.id};
				var skuData = {};
				var historyProductIdsLocalStorageKey = "historyProductIds";
				var percentage;
				
				[#if product.hasSpecification()]
					[#list product.skus as sku]
						skuData["${sku.specificationValueIds?join(",")}"] = {
							id: ${sku.id},
							price: ${sku.price},
							[#if product.groupBuying??]
								groupBuyingPrice: ${product.getGroupBuyingPrice(sku)},
							[/#if]
							marketPrice: ${sku.marketPrice},
							rewardPoint: ${sku.rewardPoint},
							exchangePoint: ${sku.exchangePoint},
							isOutOfStock: ${sku.isOutOfStock?string("true", "false")}
						};
					[/#list]
					
					// 锁定规格值
					lockSpecificationValue();
				[/#if]
				
				// 打印
				$print.click(function() {
					var $element = $(this);
					
					var productId = $element.data("product-id");
					$("#productId").val(productId);
					$printModal.modal();
				});
				
				// 对比栏
				var compareProductIdsLocalStorage = localStorage.getItem(compareProductIdsLocalStorageKey);
				var compareProductIds = compareProductIdsLocalStorage != null ? JSON.parse(compareProductIdsLocalStorage) : [];
				
				if (compareProductIds.length > 0) {
					$.ajax({
						url: "${base}/product/compare_bar",
						type: "GET",
						data: {
							productIds: compareProductIds
						},
						dataType: "json",
						cache: true,
						success: function(data) {
							$.each(data, function(i, item) {
								$compareBody.append(compareProductItemTemplate({
									compareProduct: item
								}));
							});
							$compareBar.velocity("fadeIn");
						}
					});
				}
				
				// 添加对比项
				$addCompare.click(function() {
					var $element = $(this);
					var productId = $element.data("product-id");
					
					//比对对比栏中的数据大分类
					if(compareProductIds.length>0){
					
					var date="";
					
						//比对数据第一条数据的大分类和当前数据的大分类是否相等
						var compareId = compareProductIds[0];
						$.ajax({
							url: "${base}/product/isSimilar",
							type: "GET",
							data: {
								productId: productId,
								compareId: compareId
							},
							dataType: "json",
							cache: false,
							async: false,
							success: function(data) {
								console.log(data);
								date = data;
								if(data == "no"){
									return false;
								}
							}
						});
						if(date == "no"){
							$.bootstrapGrowl("同一大类才能对比", {
								type: "warning"
							});
							return false;
						}
					}
					
					if ($.inArray(productId, compareProductIds) >= 0) {
						$.bootstrapGrowl("${message("shop.product.alreadyAddCompare")}", {
							type: "warning"
						});
						return false;
					}
					if (compareProductIds.length >= 4) {
						$.bootstrapGrowl("${message("shop.product.addCompareNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
					$.ajax({
						url: "${base}/product/add_compare",
						type: "GET",
						data: {
							productId: productId
						},
						dataType: "json",
						cache: false,
						success: function(data) {
							if ($compareBar.is(":hidden")) {
								$compareBar.velocity("fadeIn");
							}
							$compareBody.append(compareProductItemTemplate({
								compareProduct: data
							}));
							compareProductIds.push(productId);
							localStorage.setItem(compareProductIdsLocalStorageKey, JSON.stringify(compareProductIds));
						}
					});
					return false;
				});
				
				// 删除对比项
				$compareBar.on("click", "a.delete-compare", function() {
					var $element = $(this);
					var productId = $element.data("product-id");
					
					$element.closest("li").velocity("fadeOut").remove();
					compareProductIds = $.grep(compareProductIds, function(compareProductId, i) {
						return compareProductId != productId;
					});
					if (compareProductIds.length === 0) {
						$compareBar.velocity("fadeOut");
						localStorage.removeItem(compareProductIdsLocalStorageKey);
					} else {
						localStorage.setItem(compareProductIdsLocalStorageKey, JSON.stringify(compareProductIds));
					}
					return false;
				});
				
				// 开始对比
				$compare.click(function() {
					if (compareProductIds.length < 2) {
						$.bootstrapGrowl("${message("shop.product.compareNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
					$compareForm.submit();
					return false;
				});
				
				// 清空对比栏
				$clearCompareBar.click(function() {
					compareProductIds = [];
					localStorage.removeItem(compareProductIdsLocalStorageKey);
					$compareBar.find("li:not(.action)").remove().end().velocity("fadeOut");
					return false;
				});
				
				
				// 浏览记录
				var historyProductIdsLocalStorage = localStorage.getItem(historyProductIdsLocalStorageKey);
				var historyProductIds = historyProductIdsLocalStorage != null ? JSON.parse(historyProductIdsLocalStorage) : [];
				
				historyProductIds = $.grep(historyProductIds, function(historyProductId, i) {
					return historyProductId != ${product.id};
				});
				historyProductIds.unshift(${product.id});
				historyProductIds = historyProductIds.slice(0, 10);
				localStorage.setItem(historyProductIdsLocalStorageKey, JSON.stringify(historyProductIds));
				
				// 到货通知
				$productNotifyModal.on("show.bs.modal", function(event) {
					if ($.trim($productNotifyEmail.val()) === "") {
						$.ajax({
							url: "${base}/product_notify/email",
							type: "GET",
							dataType: "json",
							cache: false,
							success: function(data) {
								$productNotifyEmail.val(data.email);
							}
						});
					}
				});
				
				// 商品图片放大镜
				$zoom.jqzoom({
					zoomWidth: 378,
					zoomHeight: 378,
					title: false,
					preloadText: null,
					preloadImages: false
				});
				
				// 商品缩略图
				$thumbnailProductImageItem.hover(function() {
					$(this).click();
				});
				
				[#if product.groupBuying??]
					// 团购倒计时
					$countdown.countdown("${product.groupBuying.endDate?string("yyyy-MM-dd HH:mm:ss")}", function(event) {
						var $element = $(this);
						
						$element.find("span").html(event.strftime("%D${message("shop.product.date")} %H${message("shop.product.hours")}%M${message("shop.product.minutes")}%S${message("shop.product.seconds")}"));
					}).on("finish.countdown", function() {
						var $element = $(this);
						
						$element.html("${message("shop.product.ended")}");
						$time.addClass("disabled");
						$specificationItem.find("a").addClass("disabled");
						$group.prop("disabled", true);
					});
				[/#if]
				
				// 规格值选择
				$specificationValue.click(function() {
					var $element = $(this);
					
					if ($element.hasClass("disabled")) {
						return false;
					}
					$element.toggleClass("active").siblings().removeClass("active");
					lockSpecificationValue();
					return false;
				});
				
				// 锁定规格值
				function lockSpecificationValue() {
					var activeSpecificationValueIds = $specificationItem.map(function() {
						var $active = $(this).find("a.active");
						return $active.length > 0 ? $active.data("specification-item-entry-id") : [null];
					}).get();
					$specificationItem.each(function(i) {
						$(this).find("a").each(function(j) {
							var $element = $(this);
							var specificationValueIds = activeSpecificationValueIds.slice(0);
							specificationValueIds[i] = $element.data("specification-item-entry-id");
							if (isValid(specificationValueIds)) {
								$element.removeClass("disabled");
							} else {
								$element.addClass("disabled");
							}
						});
					});
					var sku = skuData[activeSpecificationValueIds.join(",")];
					if (sku != null) {
						skuId = sku.id;
						$specification.removeClass("warning");
						$price.text($.currency(sku.price, true));
						$groupBuyingPrice.text($.currency(sku.groupBuyingPrice, true));
						$marketPrice.text($.currency(sku.marketPrice, true));
						$rewardPoint.text(sku.rewardPoint);
						$exchangePoint.text(sku.exchangePoint);
						if (sku.isOutOfStock) {
							$buy.add($group).add($addCart).add($exchange).prop("disabled", true);
							$addProductNotify.show();
							$actionTips.text("${message("shop.product.skuLowStock")}").fadeIn();
						} else {
							$buy.add($group).add($addCart).add($exchange).prop("disabled", false);
							$addProductNotify.hide();
							$actionTips.empty().fadeOut();
						}
					} else {
						skuId = null;
						$specification.addClass("warning");
						$buy.add($group).add($addCart).add($exchange).prop("disabled", true);
						$addProductNotify.hide();
						$actionTips.text("${message("shop.product.specificationRequired")}").fadeIn();
					}
				}
				
				// 判断规格值ID是否有效
				function isValid(specificationValueIds) {
					for (var key in skuData) {
						var ids = key.split(",");
						if (match(specificationValueIds, ids)) {
							return true;
						}
					}
					return false;
				}
				
				// 判断数组是否配比
				function match(array1, array2) {
					if (array1.length != array2.length) {
						return false;
					}
					for (var i = 0; i < array1.length; i ++) {
						if (array1[i] != null && array2[i] != null && array1[i] != array2[i]) {
							return false;
						}
					}
					return true;
				}
				
				// 立即购买
				$buy.checkout({
					skuId: function() {
						return skuId;
					},
					quantity: function() {
						return $quantity.val();
					}
				});
				
				[#if product.groupBuying??]
					// 立即参团
					$group.click(function () {
						$.get("${base}/order/check_group_buying", {
							skuId: skuId,
							groupBuyingId: "${product.groupBuying.id}",
							quantity: $quantity.val()
						}).done(function() {
							location.href = URI("${base}/order/checkout").setSearch({
								skuId: skuId,
								groupBuyingId: "${product.groupBuying.id}",
								quantity: $quantity.val()
							}).toString();
						});
					});
				[/#if]
				
				// 加入购物车
				$addCart.addCart({
					skuId: function() {
						return skuId;
					},
					quantity: function() {
						return $quantity.val();
					},
					cartTarget: "#mainSidebarCart",
					productImageTarget: "#productImage .medium-product-image img"
				});
				
				// 积分兑换
				$exchange.checkout({
					skuId: function() {
						return skuId;
					},
					quantity: function() {
						return $quantity.val();
					}
				});
				
				// 顶部栏
				$topbar.affix({
					offset: {
						top: function() {
							return $topbar.parent().offset().top;
						}
					}
				});
				
				// 到货通知表单验证
				$productNotifyForm.validate({
					rules: {
						email: {
							required: true,
							email: true
						}
					},
					submitHandler: function(form) {
						$.ajax({
							url: $productNotifyForm.attr("action"),
							type: $productNotifyForm.attr("method"),
							data: {
								skuId: skuId,
								email: $productNotifyEmail.val()
							},
							dataType: "json",
							cache: false,
							success: function(data) {
								$.bootstrapGrowl("申请成功");
								$productNotifyModal.modal("hide");
							}
						});
					}
				});
				
				//样片索取
				$rform.validate({
					rules: {
						
					},
					submitHandler: function(form) {
						$.ajax({
							url: $rform.attr("action"),
							type: $rform.attr("method"),
							data: $rform.serialize(),
							dataType: "json",
							success: function(data) {
								$.bootstrapGrowl(data.message);
								$printModal.modal("hide");
							}
						});
					}
				});
				
				[#if product.groupBuying??]
					// 已参团人数
					$.get("${base}/product/participants/${product.groupBuying.id}").done(function(groupSize) {
						percentage = (100/${product.groupBuying.groupSize} * groupSize).toFixed(2) + "%";
						$participants.text(groupSize);
						if (groupSize >= ${product.groupBuying.groupSize}) {
							$groupSize.add($progress).hide();
						} else {
							$participantProgressBar.css({
								width: percentage,
								backgroundColor: "#dd0000"
							});
						}
					});
				[/#if]
				
				function jy(){
					var sampleNumber = $("#sampleNumber").val();
					
					if(sampleNumber <=0 || sampleNumber > 2){
						$.bootstrapGrowl("只能输入1或2");
						return false;
					}
				}
				
				// 点击数
				$.get("${base}/product/hits/${product.id}");

// 切换标签
$(".nav li").each(function(index,obj){
	$(obj).click(()=>{
		$(".tableVal").hide();
		$(".tableVal").eq(index).show();
	});
});
$(".tableVal:eq(0)").show();

				
			});
			$().ready(function(){
				$('.image-list').on('click', '.largeImage', function () {
					var this_ = $(this);
					var imagesArr = [];
					$(".largeImage").each((index,obj)=>{
						imagesArr.push($(obj).attr("src"))
					})
					console.log(imagesArr)
					$.pictureViewer({
						images: imagesArr, //需要查看的图片，数据类型为数组
						initImageIndex: this_.index() + 1, //初始查看第几张图片，默认1
						scrollSwitch: true //是否使用鼠标滚轮切换图片，默认false
					});
				});
				
				$(".zoomPad").css({
					"position": "relative",
					"height": "100%",
					"width": "100%",
				})
			})
			</script>
		[/#escape]
	[/#noautoesc]
<style type='text/css'>
.product-detail .summary dl dt,.product-detail .summary dl dd{
line-height:50px;
}
.product-detail .quantity{
height:30px
}
.nav>li>a:hover, .nav>li>a:focus{
background-color:white;
}
.product-detail .quantity,.product-detail .action{
display: inline-block;
    vertical-align: middle;
margin:0;
padding:0 15px;
}
.product-detail .quantity dl dt,.product-detail .quantity dl dd{
float: initial;
    display: inline-block;
}
.product-detail .quantity dl dt{
width: initial;
}
.product-detail .quantity dl dd{
margin-left:0
}
.action .btn-new{
height: 40px;
    width: 120px;
    line-height: 40px;
    padding: 0;
    margin: 0 10px;
    background: white;
    border: 1px solid gainsboro;
    border-radius: 4px;
    cursor: pointer;
}
.orange{
color:white;
background:#F7A621 !important;
}
.blue{
color:white;
background:#1E8BCC !important;
}
.product-detail .product-image .medium-product-image{
height: 250px;
}
.featured-product .featured-product-heading h4{
color: #1E8BCC;
-webkit-text-fill-color:initial;
background-image:initial;
font-weight:bold;
}
.featured-product .featured-product-heading{
border-bottom: 1px solid #eeeeee;
}
.tableVal{
width:100%;
margin-top: 20px;
}
.tableVal td td,.tableVal td th{
text-align:center;
}  
.tableVal tr td:first-child{
	width: 13%;
    text-align: center;
    background: #F8F8F8;
    border: 1px solid #eee;
    padding: 10px 0;
} 
.tableVal>tbody>tr>td:last-child{
padding: 10px;
    border: 1px solid #eee;
}
.tab0,.tab1,.tab2{
display:none;
}
.tab2 .pdf{
display: inline-block;
    margin: 4px;
}
.tab1 .pdf .icon,.tab2 .pdf .icon{
width:20px;
height:20px;
margin:0 4px;
}
.tab2 .showimg{
width:40px;
height:40px;
margin-right:10px;
}
.ipt .form-control{
	display:inline-block;
}
.ipt>span{
	display:inline-block;
	width:15%;
	margin-right:2%;
}
</style>
</head>
<body class="shop product-detail" data-spy="scroll" data-target="#topbar">
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<div class="container">
			<form id="rform" action="${base}/product/applySample" method="post">
				<div id="printModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<input type="hidden" id="productId" name="productId"/>
						<input type="hidden" id="flag" name="flag" value="0"/>
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">索取样片</h5>
							</div>
							<div class="modal-body ipt">
								<span>申请人：</span>
								<input id="applyUser" name="applyUser" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-body ipt">
								<span>申请单位：</span>
								<input id="applyCompany" name="applyCompany" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-body ipt">
								<span>应用产品：</span>
								<input id="applicationProduct" name="applicationProduct" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-body ipt">
								<span>应用背景：</span>
								<input id="applicationBackground" name="applicationBackground" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-body ipt">
								<span>样品数量：</span>
								<input id="sampleNumber" name="sampleNumber" class="form-control" type="text" maxlength="200" style="width: 60%;" onchange="jy()">
							</div>
							<div class="modal-body ipt">
								<span>地址：</span>
								<input id="address" name="address" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-body ipt">
								<span>联系电话：</span>
								<input id="phone" name="phone" class="form-control" type="text" maxlength="200" style="width: 60%;">
							</div>
							<div class="modal-footer">
								<button id="printButton" class="btn btn-primary" type="submit">提交申请</button>
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			<form id="compareForm" action="${base}/product/compare" method="get" class="product-list">
				<div id="compareBar" class="compare-bar">
					<div class="compare-bar-heading">
						<h5>${message("shop.product.compareBar")}</h5>
					</div>
					<div class="compare-bar-body clearfix">
						<ul class="pull-left clearfix"></ul>
						<div class="action">
							<a class="compare btn btn-primary" href="javascript:;">${message("shop.product.beginCompare")}</a>
							<a class="clear-compare-bar" href="javascript:;">${message("shop.product.clearCompareBar")}</a>
						</div>
					</div>
				</div>
			</form>
			<form id="productNotifyForm" class="form-horizontal" action="${base}/product_notify/save" method="post">
				<div id="productNotifyModal" class="product-notify-modal modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">${message("shop.product.addProductNotify")}</h5>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label class="col-xs-3 control-label item-required">${message("shop.product.productNotifyEmail")}:</label>
									<div class="col-xs-8">
										<input name="email" class="form-control" type="text" maxlength="200">
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="submit">${message("common.ok")}</button>
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			<ol class="breadcrumb">
				<li>
					<a href="${base}/">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				[@product_category_parent_list productCategoryId = productCategory.id]
					[#list productCategories as productCategory]
						<li>
							<a href="${base}${productCategory.path}">${productCategory.name}</a>
						</li>
					[/#list]
				[/@product_category_parent_list]
				<li class="active">
					<a href="${base}${productCategory.path}">${productCategory.name}</a>
				</li>
			</ol>
			<div class="row">
				<div class="col-xs-3" style="width:20%">
					<div id="productImage" class="product-image">
						<div class="medium-product-image">
							[#if product.productImages?has_content]
								<a id="zoom" href="${product.productImages[0].large}" rel="gallery">
									<img src="${product.productImages[0].medium}" alt="${product.name}" style='position: absolute;top: 50%;transform: translate(-50%,-50%);left: 50%;'>
								</a>
							[#else]
								<a id="zoom" href="${setting.defaultLargeProductImage}" rel="gallery">
									<img src="${setting.defaultMediumProductImage}" alt="${product.name}" style='position: absolute;top: 50%;transform: translate(-50%,-50%);left: 50%;'>
								</a>
							[/#if]
						</div>
						 <div class="thumbnail-product-image carousel slide" data-ride="carousel" data-interval="false" data-wrap="false">
							<ul class="carousel-inner">
								[#if product.productImages?has_content]
									[#list product.productImages?chunk(5) as row]
										<li class="item[#if row_index == 0] active[/#if]">
											[#list row as productImage]
												<a[#if row_index == 0 && productImage_index == 0] class="zoomThumbActive"[/#if] href="javascript:;" rel="{gallery: 'gallery', smallimage: '${productImage.medium}', largeimage: '${productImage.large}'}">
													<img src="${productImage.thumbnail}" alt="${product.name}">
												</a>
											[/#list]
										</li>
									[/#list]
								[#else]
									<li class="item active">
										<a class="zoomThumbActive" href="javascript:;" rel="{gallery: 'gallery', smallimage: '${setting.defaultMediumProductImage}', largeimage: '${setting.defaultLargeProductImage}'}">
											<img src="${setting.defaultThumbnailProductImage}" alt="${product.name}">
										</a>
									</li>
								[/#if]
							</ul>
							<a class="carousel-control left" href="#productImage .carousel" data-slide="prev">
								<i class="iconfont icon-back"></i>
							</a>
							<a class="carousel-control right" href="#productImage .carousel" data-slide="next">
								<i class="iconfont icon-right"></i>
							</a>
						</div> 
					</div>
					<!-- <div class="product-action clearfix">
						<div class="bdsharebuttonbox">
							<a class="bds_qzone" data-cmd="qzone" href="#"></a>
							<a class="bds_tsina" data-cmd="tsina"></a>
							<a class="bds_tqq" data-cmd="tqq"></a>
							<a class="bds_weixin" data-cmd="weixin"></a>
							<a class="bds_renren" data-cmd="renren"></a>
							<a class="bds_more" data-cmd="more"></a>
						</div>
						<a class="add-product-favorite" href="javascript:;" data-action="addProductFavorite" data-product-id="${product.id}">
							<i class="iconfont icon-like"></i>
							${message("shop.product.addProductFavorite")}
						</a>
					</div> -->
				</div>
				[#if product.isverify && product.isbzverify]
					<img class="lazy-load img-responsive" src="${product.jcstore.image}" style="z-index:2;z-index: 2;position: absolute;right: 566px;top: 268px;">
					<img class="lazy-load img-responsive" src="${product.bzstore.image}" style="z-index:2;z-index: 2;position: absolute;right: 600px;top: 268px;">
				[#elseif product.isbzverify]
					<img class="lazy-load img-responsive" src="${product.bzstore.image}" style="z-index:2;z-index: 2;position: absolute;right: 600px;top: 268px;">
				[#elseif product.isverify]
					<img class="lazy-load img-responsive" src="${product.jcstore.image}" style="z-index:2;z-index: 2;position: absolute;right: 600px;top: 268px;">
				[/#if]
				<div class="col-xs-7" style="width:59%">
					<div class="name">
						<h4>${product.name}</h4>
						[#if product.caption?has_content]
							<strong>${product.caption}</strong>
						[/#if]
					</div>
					[#if product.groupBuying??]
						<div id="time" class="time clearfix[#if product.groupBuying.hasEnded()] disabled[/#if]">
							<div class="pull-left">
								<i class="iconfont icon-time pull-left"></i>
								<span>${message("shop.product.timeLimit")}</span>
							</div>
							<div class="pull-right">
								[#if product.groupBuying.hasEnded()]
									<span>${message("shop.product.ended")}</span>
								[#else]
									<div id="countdown">
										${message("shop.product.fromEnd")}
										<span></span>
									</div>
								[/#if]
							</div>
						</div>
					[/#if]
					<div class="summary">
						<dl class="dl-horizontal clearfix">
							<dt>${message("Product.sn")}:</dt>
							<dd>${product.sn}</dd>
							<dt>${message("Product.cpxh")}:</dt>
							<dd>${product.cpxh}</dd>
							[#if product.jrgwParams?has_content]
								<dt>${message("Product.jrgw")}:</dt>
								<dd>
								[#list product.jrgwParams as row]
									${row.name}(${row.value1}) 
								[/#list]								
								</dd>
							[/#if]
							<!--注释价格START [#if false]
							[#if product.type != "GENERAL"]
								<dt>${message("Product.type")}:</dt>
								<dd>${message("Product.Type." + product.type)}</dd>
							[/#if]
							[#if product.type == "GENERAL"]
								[#if product.groupBuying??]
									<dt>${message("Product.groupBuyingPrice")}:</dt>
									<dd>
										<strong id="groupBuyingPrice">${currency(product.groupBuyingPrice, true)}</strong>
									</dd>
									<dt>${message("Sku.price")}:</dt>
									<dd>
										<del id="price">${currency(defaultSku.price, true)}</del>
									</dd>
								[#else]
									<dt>${message("Sku.price")}:</dt>
									<dd>
										<strong id="price">${currency(defaultSku.price, true)}</strong>
									</dd>
									[#if setting.isShowMarketPrice]
										<dt>${message("Sku.marketPrice")}:</dt>
										<dd>
											<del id="marketPrice">${currency(defaultSku.marketPrice, true)}</del>
										</dd>
									[/#if]
								[/#if]
								[#if product.validPromotions?has_content]
									<dt>${message("Product.promotions")}:</dt>
									<dd>
										[#list product.validPromotions as promotion]
											<a class="label label-default" href="${base}${promotion.path}" target="_blank">${promotion.name}</a>
										[/#list]
									</dd>
								[/#if]
								[#if defaultSku.rewardPoint > 0]
									<dt>${message("Sku.rewardPoint")}:</dt>
									<dd id="rewardPoint">${defaultSku.rewardPoint}</dd>
								[/#if]
							[#else]
								[#if product.type == "EXCHANGE"]
									<dt>${message("Sku.exchangePoint")}:</dt>
									<dd>
										<strong id="exchangePoint">${defaultSku.exchangePoint}</strong>
									</dd>
								[/#if]
								[#if setting.isShowMarketPrice]
									<dt>${message("Sku.marketPrice")}:</dt>
									<dd id="marketPrice">${currency(defaultSku.marketPrice, true)}</dd>
								[/#if]
							[/#if]
							[/#if] 注释价格END-->
						</dl>
						<!--注释销量START [#if false]
						<ul class="clearfix">
							<li>
								${message("Product.monthSales")}:
								<strong>${product.monthSales}</strong>
							</li>
							<li>
								${message("Product.scoreCount")}:
								<strong>${product.scoreCount}</strong>
							</li>
							<li>
								${message("Product.score")}:
								<strong>${product.score?string("0.0")}</strong>
							</li>
							[#if product.groupBuying??]
								<li>
									${message("shop.product.participants")}
									<strong id="participants"></strong>
									<span id="groupSize">/ ${product.groupBuying.groupSize}</span>
									<div id="progress" class="progress">
										<div id="participantProgressBar" class="progress-bar"></div>
									</div>
								</li>
							[/#if]
						</ul>
						 [/#if]注释销量END-->
					</div>
					[#if product.type == "GENERAL" || product.type == "EXCHANGE"]
						[#if product.hasSpecification()]
							[#assign defaultSpecificationValueIds = defaultSku.specificationValueIds /]
							<div id="specification" class="specification">
								<dl class="dl-horizontal clearfix">
									[#list product.specificationItems as specificationItem]
										<dt>
											<span title="${specificationItem.name}">${abbreviate(specificationItem.name, 8)}:</span>
										</dt>
										<dd>
											[#list specificationItem.entries as entry]
												[#if entry.isSelected]
													<a[#if defaultSpecificationValueIds[specificationItem_index] == entry.id] class="active"[/#if] href="javascript:;" data-specification-item-entry-id="${entry.id}">${entry.value}</a>
												[/#if]
											[/#list]
										</dd>
									[/#list]
								</dl>
							</div>
						[/#if]
						<div class="quantity">
							<dl class="dl-horizontal clearfix">
								<dt>${message("shop.product.quantity")}:</dt>
								<dd>
									<div class="spinner input-group input-group-sm" data-trigger="spinner">
										<input id="quantity" class="form-control" type="text" maxlength="5" data-rule="quantity" data-min="1" data-max="10000">
										<span class="input-group-addon">
											<a class="spin-up" href="javascript:;" data-spin="up">
												<i class="fa fa-caret-up"></i>
											</a>
											<a class="spin-down" href="javascript:;" data-spin="down">
												<i class="fa fa-caret-down"></i>
											</a>
										</span>
									</div>
									<span class="unit">${product.unit!message("shop.product.defaultUnit")}</span>
								</dd>
							</dl>
						</div>
						<div class="action">
							<!-- [#if product.groupBuying??]
								<button id="buy" class="btn btn-default btn-lg" type="button"[#if defaultSku.isOutOfStock] disabled[/#if]>${message("shop.product.original")}</button>
								<button id="group" class="btn btn-default btn-lg" type="button"[#if defaultSku.isOutOfStock] disabled[/#if]>${message("shop.product.group")}</button>
							[#elseif product.type == "GENERAL"]
								<button id="buy" class="btn btn-default btn-lg" type="button"[#if defaultSku.isOutOfStock] disabled[/#if]>${message("shop.product.buy")}</button>
								<button id="addCart" class="btn btn-primary btn-lg" type="button"[#if defaultSku.isOutOfStock] disabled[/#if]>
									<i class="iconfont icon-cart"></i>
									${message("shop.product.addCart")}
								</button>
							[#elseif product.type == "EXCHANGE"]
								<button id="exchange" class="btn btn-primary btn-lg" type="button"[#if defaultSku.isOutOfStock] disabled[/#if]>
									<i class="iconfont icon-present"></i>
									${message("shop.product.exchange")}
								</button>
							[/#if]
							<button id="addProductNotify" class="btn btn-primary btn-lg[#if !defaultSku.isOutOfStock] hidden-element[/#if]" type="button" data-toggle="modal" data-target="#productNotifyModal">
								<i class="iconfont icon-mail"></i>
								${message("shop.product.addProductNotify")}
							</button>
							[#if defaultSku.isOutOfStock]
								<span id="actionTips" class="text-orange">${message("shop.product.skuLowStock")}</span>
							[#else]
								<span id="actionTips" class="text-orange hidden-element"></span>
							[/#if] -->

							<!-- 新增按钮 -->
							[#if currentUser == null]
								<button class='btn-new orange' onclick="javascript: top.location.href ='${base}/member/login'">加入BOM清单</button>
								<button class='btn-new' onclick="javascript: top.location.href ='${base}/member/login'" >加入收藏</button>
								<button class='btn-new' onclick="javascript: top.location.href ='${base}/member/login'">加入对比</button>
								<button class='btn-new blue' onclick="javascript: top.location.href ='${base}/member/login'">索取样片</button>
								
								<!--<button class='btn-new blue' id="sqyp" data-product-id="${product.id}">索取样片</button>-->
							[#elseif currentUser.attestationFlag == 'REAL']
								<button id="addCart" class='btn-new orange'>加入BOM清单</button>
								<button class='btn-new' data-action="addProductFavorite" data-product-id="${product.id}">加入收藏</button>
								<button class='btn-new' id="add-compare" data-product-id="${product.id}">加入对比</button>
								<button class='btn-new blue' id="sqyp" data-product-id="${product.id}">索取样片</button>
							[#else]
								<button class='btn-new orange' onclick="javascript:top.location.href='${base}/member/realname/edit'">加入BOM清单</button>
								<button class='btn-new' onclick="javascript:top.location.href='${base}/member/realname/edit'">加入收藏</button>
								<button class='btn-new' onclick="javascript:top.location.href='${base}/member/realname/edit'">加入对比</button>
								<button class='btn-new blue' onclick="javascript:top.location.href='${base}/member/realname/edit'">索取样片</button>
							[/#if]
						</div>
					[/#if]
				</div>
				<div class="col-xs-2" style='width:20%'>
					<div class="store">
						<div class="store-heading" style="text-align:center">
							<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${product.store.id}" target="_blank" style="display: inline-block;width: 100px;height: 100px;position: relative;">
								<img style="position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%);" class="img-responsive center-block" src="${product.store.logo!setting.defaultStoreLogo}" alt="${product.store.name}">
							</a>
							<h5>
								<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${product.store.id}" target="_blank">${abbreviate(product.store.name, 50, "...")}</a>
								[#if product.store.type == "SELF"]
									<span class="label label-primary">${message("Store.Type.SELF")}</span>
								[/#if]
							</h5>
						</div>

<!-- 店铺介绍 -->
<div class='store-introduce' title="${product.store.introduction}" style='-webkit-box-orient: vertical;display: -webkit-box;-webkit-line-clamp: 3;overflow: hidden;'>
厂家简介：${product.store.introduction}
</div>
<!--
						[@instant_message_list storeId = product.store.id]
							[#if product.store.address?has_content || product.store.phone?has_content || instantMessages?has_content]
								<div class="store-body">
									[#if product.store.address?has_content || product.store.phone?has_content]
										<dl class="dl-horizontal clearfix">
											[#if product.store.address?has_content]
												<dt>${message("Store.address")}:</dt>
												<dd>${product.store.address}</dd>
											[/#if]
											[#if product.store.phone?has_content]
												<dt>${message("Store.phone")}:</dt>
												<dd>${product.store.phone}</dd>
											[/#if]
										</dl>
									[/#if]
									[#if instantMessages?has_content]
										<p>
											[#list instantMessages as instantMessage]
												[#if instantMessage.type == "QQ"]
													<a href="http://wpa.qq.com/msgrd?v=3&uin=${instantMessage.account}&menu=yes" title="${instantMessage.name}" target="_blank">
														<img src="${base}/resources/shop/images/instant_message_qq.png" alt="${instantMessage.name}">
													</a>
												[#elseif instantMessage.type == "ALI_TALK"]
													<a href="http://amos.alicdn.com/getcid.aw?v=2&uid=${instantMessage.account}&site=cntaobao&s=2&groupid=0&charset=utf-8" title="${instantMessage.name}" target="_blank">
														<img src="${base}/resources/shop/images/instant_message_wangwang.png" alt="${instantMessage.name}">
													</a>
												[/#if]
											[/#list]
										</p>
									[/#if]
								</div>
							[/#if]
						[/@instant_message_list]-->
						<div class="store-footer">
							[#if currentUser == null]
								<a class="btn btn-default" href="${base}/member/login" target="_blank">${message("shop.product.viewStore")}</a>
								<a class="btn btn-default" href="${base}/member/login" data-action="addStoreFavorite" data-store-id="${product.store.id}">${message("shop.product.addStoreFavorite")}</a>
							[#else]
								<a class="btn btn-default" href="${base}/product/list?storeProductCategoryId=-1&storeId=${product.store.id}" target="_blank">${message("shop.product.viewStore")}</a>
								<a class="btn btn-default" href="javascript:;" data-action="addStoreFavorite" data-store-id="${product.store.id}">${message("shop.product.addStoreFavorite")}</a>
							[/#if]
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-2">
					[#include "/shop/include/resemble_product.ftl" /]
				</div>
				<div class="col-xs-10">
					
					[#if product.introduction?has_content || product.parameterValues?has_content || setting.isReviewEnabled || setting.isConsultationEnabled]
						<div class="topbar-wrapper">
							<div id="topbar" class="topbar">
								<ul class="nav">
									<!-- [#if product.introduction?has_content]
										<li>
											<a href="#introductionAnchor">${message("shop.product.introduction")}</a>
										</li>
									[/#if]
									[#if product.parameterValues?has_content]
										<li>
											<a href="#parameterAnchor">${message("shop.product.parameter")}</a>
										</li>
									[/#if]
									[#if setting.isReviewEnabled]
										<li>
											<a href="#reviewAnchor">${message("shop.product.review")}</a>
										</li>
									[/#if]
									[#if setting.isConsultationEnabled]
										<li>
											<a href="#consultationAnchor">${message("shop.product.consultation")}</a>
										</li>
									[/#if] -->

									[#if product.introduction?has_content]	
										<li>
											<a href="#introduction">产品介绍</a>
										</li>
									[/#if]
									[#if currentUser.id != null]
										<li>
											<a href="#zyjszb">主要技术指标</a>
										</li>
										[#if currentUser.attestationFlag == 'REAL']
											<li>
												<a href="#appdata">应用数据</a>
											</li>
										[/#if]
									[/#if]
								</ul>
							</div>
						</div>
					[/#if]
					<!--注释简介START [#if false]
					[#if product.introduction?has_content]
						<div class="introduction">
							<span id="introductionAnchor" class="introduction-anchor"></span>
							<div class="introduction-heading">
								<h4>${message("shop.product.introduction")}</h4>
							</div>
							<div class="introduction-body">
								[#noautoesc]
									${product.introduction}
								[/#noautoesc]
							</div>
						</div>
					[/#if]
					
					[#if product.parameterValues?has_content]
						<div class="parameter">
							<span id="parameterAnchor" class="parameter-anchor"></span>
							<div class="parameter-heading">
								<h4>${message("shop.product.parameter")}</h4>
							</div>
							<div class="parameter-body">
								<table>
									[#list product.parameterValues as parameterValue]
										<tr>
											<th class="group" colspan="2">${parameterValue.group}</th>
										</tr>
										[#list parameterValue.entries as entry]
											<tr>
												<th>${entry.name}</th>
												<td>${entry.value}</td>
											</tr>
										[/#list]
									[/#list]
								</table>
							</div>
						</div>
					[/#if]
					[#if setting.isReviewEnabled]
						<div class="review">
							<span id="reviewAnchor" class="review-anchor"></span>
							<div class="review-heading">
								<h4>${message("shop.product.review")}</h4>
							</div>
							<div class="review-body">
								[#if product.scoreCount > 0]
									<div class="score media">
										<div class="media-left media-middle">
											<h5>${message("Product.score")}</h5>
											<strong>${product.score?string("0.0")}</strong>
											<p>
												[#list 1..5 as score]
													<i class="iconfont[#if score <= product.score] icon-favorfill[#else] icon-favor[/#if]"></i>
												[/#list]
											</p>
										</div>
										<div class="media-body media-middle">
											<div class="graph">
												<div class="graph-scroller">
													<em style="left: ${(product.score * 20)?string("0.0")}%;">
														${product.score?string("0.0")}
														<span class="caret"></span>
													</em>
												</div>
												<ul class="graph-description">
													<li>${message("shop.product.graph1")}</li>
													<li>${message("shop.product.graph2")}</li>
													<li>${message("shop.product.graph3")}</li>
													<li>${message("shop.product.graph4")}</li>
													<li>${message("shop.product.graph5")}</li>
												</ul>
											</div>
										</div>
										<div class="media-right media-middle">
											<p>${message("Product.scoreCount")}: ${product.scoreCount}</p>
											<a href="${base}/review/detail/${product.id}">[${message("shop.product.viewReview")}]</a>
										</div>
									</div>
									[@review_list productId = product.id count = 5]
										[#if reviews?has_content]
											<ul class="review-list media-list">
												[#list reviews as review]
													<li class="media">
														<div class="media-left">
															<strong>${review.member.username}</strong>
															<span title="${review.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${review.createdDate?string("yyyy-MM-dd")}</span>
															[#if review.specifications?has_content]
																<span>[${review.specifications?join(", ")}]</span>
															[/#if]
														</div>
														<div class="media-body">
															<p>
																[#list 1..(review.score?number)!0 as i]
																	<i class="iconfont icon-favorfill"></i>
																[/#list]
																[#list 0..(5 - review.score) as d]
																	[#if d != 0]
																		<i class="iconfont icon-favor"></i>
																	[#else]
																		
																	[/#if]
																[/#list]
															</p>
															<p>${review.content}</p>
															[#if review.replyReviews?has_content]
																<ul class="reply-list">
																	[#list review.replyReviews as replyReview]
																		<li>
																			<strong>${replyReview.store.name}:</strong>
																			<p>${replyReview.content}</p>
																			<span title="${replyReview.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${replyReview.createdDate?string("yyyy-MM-dd")}</span>
																		</li>
																	[/#list]
																</ul>
															[/#if]
														</div>
													</li>
												[/#list]
											</ul>
										[/#if]
									[/@review_list]
								[#else]
									<p class="no-result">${message("shop.product.noReview")}</p>
								[/#if]
							</div>
						</div>
					[/#if]
					[#if setting.isConsultationEnabled]
						<div class="consultation">
							<span id="consultationAnchor" class="consultation-anchor"></span>
							<div class="consultation-heading">
								<h4>${message("shop.product.consultation")}</h4>
							</div>
							<div class="consultation-body">
								[@consultation_list productId = product.id count = 5]
									[#if consultations?has_content]
										<ul class="consultation-list media-list">
											[#list consultations as consultation]
												<li class="media">
													<div class="media-left">
														<strong>${consultation.member.username}</strong>
														<span title="${consultation.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${consultation.createdDate?string("yyyy-MM-dd")}</span>
													</div>
													<div class="media-body media-middle">
														<p>${consultation.content}</p>
														[#if consultation.replyConsultations?has_content]
															<ul class="reply-list">
																[#list consultation.replyConsultations as replyConsultation]
																	<li>
																		<strong>${replyConsultation.store.name}:</strong>
																		<p>${replyConsultation.content}</p>
																		<span title="${replyConsultation.createdDate?string("yyyy-MM-dd HH:mm:ss")}">${replyConsultation.createdDate?string("yyyy-MM-dd")}</span>
																	</li>
																[/#list]
															</ul>
														[/#if]
													</div>
												</li>
											[/#list]
										</ul>
									[#else]
										<p class="no-result">${message("shop.product.noConsultation")}</p>
									[/#if]
								[/@consultation_list]
							</div>
							<div class="consultation-footer">
								<a href="${base}/consultation/add/${product.id}">[${message("shop.product.addConsultation")}]</a>
								<a href="${base}/consultation/detail/${product.id}">[${message("shop.product.viewConsultation")}]</a>
							</div>
						</div>
					[/#if]
					[/#if] 注释简介END -->
[#if product.introduction?has_content]			
	<div class='tableVal tab0'>
	[#noautoesc]
		${product.introduction}
	[/#noautoesc]
	</div>
[/#if]
<!--技術指標表单-->
[#if currentUser.id!=null]
	<table class='tableVal tab1'>
	
	[#if product.fzxs?has_content]
		<tr>
			<td>${message("Product.fzxs")}</td>
			<td>${product.fzxs}</td>
		</tr>
	[/#if]
	
	[#if product.gnms?has_content]
		<tr>
			<td>${message("Product.gnms")}</td>
			<td>${product.gnms}</td>
		</tr>
	[/#if]

	[#if product.dxncsParams?has_content]
	<tr>
		<td>${message("Product.dxncs")}</td>
		<td>
			<table style='width:100%;'>
				<tr>
					<th>参数名</th>
					<th>最小值</th>
					<th>额定值</th>
					<th>最大值</th>
					<th>单位</th>
				</tr>
				[#list product.dxncsParams as row]
					<tr>
						<th>${row.name}</th>
						<td>${row.min}</td>
						<td>${row.typ}</td>
						<td>${row.max}</td>
						<td>${row.unit}</td>
					</tr>
				[/#list]
			</table>
		</td>
	</tr>
	[/#if]

	[#if product.zldj?has_content]
		<tr>
			<td>${message("Product.zldj")}</td>
			<td>${product.zldj}</td>
		</tr>
	[/#if]

	[#if product.gzwd?has_content]
		<tr>
			<td>${message("Product.gzwd")}</td>
			<td>${product.gzwd}</td>
		</tr>
	[/#if]
	
	[#if product.zcwd?has_content]
		<tr>
			<td>${message("Product.zcwd")}</td>
			<td>${product.zcwd}</td>
		</tr>
	[/#if]

	[#if product.esd?has_content]
		<tr>
			<td>${message("Product.esd")}</td>
			<td>${product.esd}</td>
		</tr>
	[/#if]

	[#if product.qthjzbParams?has_content]
		<tr>
			<td>${message("Product.qthjzb")}</td>
			<td>
				<table style='width:100%;'>
					<tr>
						<th></th>
						<th>指标</th>
						<th>单位</th>
					</tr>
					[#list product.qthjzbParams as row]
						<tr>
							<th>${row.name}</th>
							<td>${row.value1}</td>
							<td>${row.unit}</td>
						</tr>
					[/#list]
				</table>
			</td>
		</tr>
	[/#if]
	[#if product.sytygf?has_content]
	<tr>
		<td>${message("Product.sytygf")}</td>
		<td>
			[#if currentUser == null]
				<a class='pdf' href="${base}/member/login" target="_blank">
				<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
					${message("Product.sytygf")}.pdf
				</a>
			[#elseif currentUser.attestationFlag == 'REAL']
				<a class='pdf' href="${product.sytygf}" target="_blank">
				<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
					${message("Product.sytygf")}.pdf
				</a>
			[#else]
				<a class='pdf' href="${base}/member/realname/edit" target="_blank">
				<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
					${message("Product.sytygf")}.pdf
				</a>
			[/#if]
		</td>
	</tr>
	[/#if]
	
	[#if product.sytygfm?has_content && currentUser != null]
	<tr>
		<td>${message("Product.sytygfm")}</td>
		<td>${product.sytygfm}</td>
	</tr>
	[/#if]
</table>
	[#if currentUser.attestationFlag == 'REAL']
		<table class='tableVal tab2'>
		[#if product.cpsc?has_content]
		<tr>
			<td>${message("Product.cpsc")}</td>
			<td>
				<a class='pdf' href="${product.cpsc}" target="_blank">
					<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
					${message("Product.cpsc")}.pdf
				</a>
			</td>
		</tr>
		[/#if]
		<tr>
			<td>${message("Product.dxwwyqj")}</td>
			<td>
				[#if arrayList??]
					[#list arrayList as split]
						<p>split</p>
					[/#list]
				[/#if]
			</td>
		</tr>
		
		[#if product.dxyydlImages?has_content]
		<tr>
		<td>${message("Product.dxyydl")}</td>
		<td class="image-list">
			[#list product.dxyydlImages as row]
				[#list row as dxyydlImage]
					<img src="${dxyydlImage.source}" alt="${dxyydlImage.name}" class='showimg'>
				[/#list]
			[/#list]
		</td>
		</tr>
		[/#if]
		
		[#if product.jgfxjj?has_content]
		<tr>
		<td>${message("Product.jgfxjj")}</td>
		<td>
		${product.jgfxjj}
		</td>
		</tr>
		[/#if]
		
		[#if product.jgfxbg?has_content]
		<tr>
		<td>${message("Product.jgfxbg")}</td>
		<td>
			<a class='pdf' href="${product.jgfxbg}" target="_blank">
				<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
				${message("Product.jgfxbg")}.pdf
			</a>
		</td>
		</tr>
		[/#if]
		
		[#if product.kkxsyjj?has_content]
		<tr>
			<td>${message("Product.kkxsyjj")}</td>
			<td>${product.kkxsyjj}</td>
		</tr>
		[/#if]
		
		[#if product.kkxsybgFiles?has_content]
		<tr>
		<td>${message("Product.kkxsybg")}</td>
		<td>
			[#list product.kkxsybgFiles as row]
				[#list row as kkxsybgFile]
						<a class='pdf' href="${kkxsybgFile.source}" target="_blank">
						<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
						${message("Product.kkxsybg")}${row_index+1}.pdf
						</a>
				[/#list]
			[/#list]
		</td>
		</tr>
		[/#if]
		
		[#if product.jdjyjj?has_content]
		<tr>
			<td>${message("Product.jdjyjj")}</td>
			<td>${product.jdjyjj}</td>
		</tr>
		[/#if]
		
		[#if product.jdjybg?has_content]
		<tr>
			<td>${message("Product.jdjybg")}</td>
			<td>
				<a class='pdf' href="${product.jdjybg}" target="_blank">
					<img class='icon' src='${base}/resources/shop/images/pdf.png'/>
					${message("Product.jdjybg")}.pdf
				</a>
			</td>
		</tr>
		[/#if]
		
		[#if product.cpgf?has_content]
		<tr>
			<td>${message("Product.cpgf")}</td>
			<td>${product.cpgf}</td>
		</tr>
		[/#if]
		
		[#if product.csjdzdParams?has_content]
		<tr>
			<td>
				${message("Product.csjdzd")}
			</td>
			<td>
				<table style='width:100%;'>
					[#list product.csjdzdParams as row]
						<tr>
							<th>${row.name}</th>
							<td>${row.value1}</td>
						</tr>
					[/#list]
				</table>
			</td>
		</tr>
		[/#if]
		
		[#if product.tjgzcsParams?has_content]
		<tr>
			<td>${message("Product.tjgzcs")}</td>
			<td>
				<table style='width:100%;'>
					[#list product.tjgzcsParams as row]
						<tr>
							<th>${row.name}</th>
							<td>${row.value1}</td>
						</tr>
					[/#list]
				</table>
			</td>
		</tr>
		[/#if]
		
		[#if product.yyly?has_content]
		<tr>
			<td>${message("Product.yyly")}</td>
			<td>${product.yyly}</td>
		</tr>
		[/#if]
		
		[#if product.yyzysx?has_content]
		<tr>
			<td>${message("Product.yyzysx")}</td>
			<td>${product.yyzysx}</td>
		</tr>
		[/#if]
		
		</table>
	[/#if]
[/#if]

				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
				window._bd_share_config = {
					common: {
						bdUrl: $.generateSpreadUrl()
					},
					share: [
						{
							bdSize: 16
						}
					]
				};
				with(document)0[(getElementsByTagName("head")[0]||body).appendChild(createElement("script")).src="${base}/static/api/js/share.js?cdnversion="+~(-new Date()/36e5)];
			</script>
		[/#escape]
	[/#noautoesc]
</body>
</html>