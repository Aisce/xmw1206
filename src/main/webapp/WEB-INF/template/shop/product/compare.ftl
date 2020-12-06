<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("shop.product.compare")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/product.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/common/js/jquery.qrcode.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
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
				
				var $parameterTr = $("table.parameter tr");
				
				$parameterTr.hover(function() {
					var $element = $(this);
					var parameterValueGroup = $element.data("parameter-value-group");
					var parameterValueEntryName = $element.data("parameter-value-entry-name");
					
					$parameterTr.filter("[data-parameter-value-group='" + parameterValueGroup + "'][data-parameter-value-entry-name='" + parameterValueEntryName + "']").addClass("current");
				}, function() {
					$parameterTr.removeClass("current");
				});
				
			});
			</script>
		[/#escape]
	[/#noautoesc]
	<style type='text/css'>
		.infoTips{
			border:1px solid #eee;
			box-shadow:0 0 2px #eee;
		}
		.infoTips>div{
			line-height: 28px;
			padding: 0 8px;
			border-bottom: 1px solid #eee;
		}
		.product-compare .compare-list .compare-list-item{
			overflow:initial;
		}
		.infoTable{
			width:95%;
		}
		.infoTable th,.infoTable td{
			text-align:center;
			border:1px solid #eee;
			padding:6px 12px;
		}
	</style>
</head>
<body class="shop product-compare">
	[#include "/shop/include/main_header.ftl" /]
	[#include "/shop/include/main_sidebar.ftl" /]
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					[#include "/shop/include/featured_product.ftl" /]
				</div>
				<div class="col-xs-10">
					<ol class="breadcrumb">
						<li>
							<a href="${base}/">
								<i class="iconfont icon-homefill"></i>
								${message("common.breadcrumb.index")}
							</a>
						</li>
						<li class="active">${message("shop.product.compare")}</li>
					</ol>
					<div class="compare-list">
						<!--<ul class="clearfix">
							[#list products as product]
								<li class="compare-list-item">
									<div class="thumbnail">
										<a href="${base}${product.path}" target="_blank">
											<img class="img-responsive center-block" src="${product.thumbnail!setting.defaultThumbnailProductImage}" title="${product.name}" alt="${product.name}">
										</a>
										<div class="caption">
											<p class="text-overflow">
												<a href="${base}${product.path}" titile="${product.name}" target="_blank">${product.name}</a>
											</p>
											[#if false]
												<strong class="text-red">${currency(product.price, true)}</strong>
											[/#if]
											<p>
												<a href="${base}${product.store.path}" title="${product.store.name}" target="_blank">${abbreviate(product.store.name, 15)}</a>
												[#if product.store.type == "SELF"]
													<span class="label label-primary">${message("Store.Type.SELF")}</span>
												[/#if]
											</p>
										</div>
									</div>
									
								</li>
							[/#list]
						</ul>-->
						<table class="infoTable">
								<thead>
									<tr>
										<th colspan="2"></th>
										[#list products as product]
											[#if product.dxncsParams?has_content]
												<th colspan="${product.dxncsParams?size}">
											[#elseif product.csjdzdParams?has_content]
												<th colspan="${product.csjdzdParams?size}">
											[#elseif product.csjdzdParams?has_content]
												<th colspan="${product.csjdzdParams?size}">
											[#else]
												<th>
											[/#if]
											
												<div class="thumbnail">
													<a href="${base}${product.path}" target="_blank">
														<img class="img-responsive center-block" src="${product.thumbnail!setting.defaultThumbnailProductImage}" title="${product.name}" alt="${product.name}">
													</a>
													<div class="caption">
														<p class="text-overflow">
															<a href="${base}${product.path}" titile="${product.name}" target="_blank">${product.name}</a>
														</p>
														[#if false]
															<strong class="text-red">${currency(product.price, true)}</strong>
														[/#if]
														<p>
															<a href="${base}${product.store.path}" title="${product.store.name}" target="_blank">${abbreviate(product.store.name, 15)}</a>
															[#if product.store.type == "SELF"]
																<span class="label label-primary">${message("Store.Type.SELF")}</span>
															[/#if]
														</p>
													</div>
												</div>
											</th>
										[/#list]
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="5">电性能参数</td>
										<td>参数名</td>
										[#list products as product]
											[#if  product.dxncsParams?has_content]
												[#list product.dxncsParams as dxncsParam]
													[#if dxncsParam.name??]
														<td>${dxncsParam.name}</td>
													[#else]
														<td>—</td>
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最小值</td>
										[#list products as product]
											[#if  product.dxncsParams?has_content]
												[#list product.dxncsParams as dxncsParam]
													[#if dxncsParam.min??]
														<td>${dxncsParam.min}</td>
													[#else]
														<td>—</td>
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最大值</td>
										[#list products as product]
											[#if  product.dxncsParams?has_content]
												[#list product.dxncsParams as dxncsParam]
													[#if dxncsParam.max??]
														<td>${dxncsParam.max}</td>
													[#else]
														<td>—</td>
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>额定值</td>
										[#list products as product]
											[#if  product.dxncsParams?has_content]
												[#list product.dxncsParams as dxncsParam]
													[#if dxncsParam.typ??]
														<td>${dxncsParam.typ}</td>
													[#else]
														<td>—</td>
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>单位</td>
										[#list products as product]
											[#if  product.dxncsParams?has_content]
												[#list product.dxncsParams as dxncsParam]
													[#if dxncsParam.unit??]
														<td>${dxncsParam.unit}</td>
													[#else]
														<td>—</td>
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr style="border-top: 2px solid #dddddd;">
										<td rowspan="5">其它环境适应性指标</td>
										<td>参数名</td>
										[#list products as product]
											[#if  product.qthjzbParams?has_content]
												[#list product.qthjzbParams as qthjzbParam]
													[#if qthjzbParam.type == 'QTHJSYXZB']
														<td>最小值</td>
														[#if qthjzbParam.name??]
															<td>${qthjzbParam.name}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最小值</td>
										[#list products as product]
											[#if  product.qthjzbParams?has_content]
												[#list product.qthjzbParams as qthjzbParam]
													[#if qthjzbParam.type == 'QTHJSYXZB']
														[#if qthjzbParam.value2??]
															<td>${qthjzbParam.value2}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最大值</td>
										[#list products as product]
											[#if  product.qthjzbParams?has_content]
												[#list product.qthjzbParams as qthjzbParam]
													[#if qthjzbParam.type == 'QTHJSYXZB']
														[#if qthjzbParam.value3??]
															<td>${qthjzbParam.value3}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>额定值</td>
										[#list products as product]
											[#if  product.qthjzbParams?has_content]
												[#list product.qthjzbParams as qthjzbParam]
													[#if qthjzbParam.type == 'QTHJSYXZB']
														[#if qthjzbParam.value1??]
															<td>${qthjzbParam.value1}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>单位</td>
										[#list products as product]
											[#if  product.qthjzbParams?has_content]
												[#list product.qthjzbParams as qthjzbParam]
													[#if qthjzbParam.type == 'QTHJSYXZB']
														[#if qthjzbParam.unit??]
															<td>${qthjzbParam.unit}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr style="border-top: 2px solid #dddddd;">
										<td rowspan="5">参数绝对最大额定值</td>
										<td>参数名</td>
										[#list products as product]
											[#if  product.csjdzdParams?has_content]
												[#list product.csjdzdParams as csjdzdParam]
													[#if csjdzdParam.type == 'CSJDZDEDZ']
														[#if csjdzdParam.name??]
															<td>${csjdzdParam.name}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最小值</td>
										[#list products as product]
											[#if  product.csjdzdParams?has_content]
												[#list product.csjdzdParams as csjdzdParam]
													[#if csjdzdParam.type == 'CSJDZDEDZ']
														[#if csjdzdParam.value2??]
															<td>${csjdzdParam.value2}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>最大值</td>
										[#list products as product]
											[#if  product.csjdzdParams?has_content]
												[#list product.csjdzdParams as csjdzdParam]
													[#if csjdzdParam.type == 'CSJDZDEDZ']
														[#if csjdzdParam.value3??]
															<td>${csjdzdParam.value3}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>额定值</td>
										[#list products as product]
											[#if  product.csjdzdParams?has_content]
												[#list product.csjdzdParams as csjdzdParam]
													[#if csjdzdParam.type == 'CSJDZDEDZ']
														[#if csjdzdParam.value1??]
															<td>${csjdzdParam.value1}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									<tr>
										<td>单位</td>
										[#list products as product]
											[#if  product.csjdzdParams?has_content]
												[#list product.csjdzdParams as csjdzdParam]
													[#if csjdzdParam.type == 'CSJDZDEDZ']
														[#if csjdzdParam.unit??]
															<td>${csjdzdParam.unit}</td>
														[#else]
															<td>—</td>
														[/#if]
													[/#if]
												[/#list]
											[#else]
												<td>—</td>
											[/#if]
										[/#list]
									</tr>
									
								</tbody>
						</table>
						
					</div>
				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>