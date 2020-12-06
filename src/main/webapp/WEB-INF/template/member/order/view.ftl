<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("member.order.view")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/member/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/member/js/base.js"></script>
	<style>
		.order-detail .action .btn {
			margin-right: 10px;
		}
		
		.order-detail .action .btn:last-child {
			margin-right: 0;
		}
		
		.order-detail h5 {
			line-height: 30px;
			font-size: 14px;
		}
		
		.order-detail dt {
			line-height: 30px;
		}
		
		.order-detail dd {
			width: 50%;
			line-height: 30px;
			float: left;
		}
		.progress-item td{
			border-top:0!important;
			padding:4px 8px!important;
		}
		.product-item-last:next td{
			border-top:1px solid #ddd;
		}
		
	</style>
	<script id="transitStepTemplate" type="text/template">
		<%if (_.isEmpty(data.transitSteps)) {%>
			<p class="text-gray">${message("common.noResult")}</p>
		<%} else {%>
			<%_.each(data.transitSteps, function(transitStep, i) {%>
				<div class="list-item">
					<p class="text-gray"><%-transitStep.time%></p>
					<p><%-transitStep.context%></p>
				</div>
			<%});%>
		<%}%>
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				
				var $payment = $("#payment");
				var $cancel = $("#cancel");
				var $receive = $("#receive");
				var $transitStep = $("a.transit-step");
				var $transitStepModal = $("#transitStepModal");
				var $transitStepModalBody = $("#transitStepModal div.modal-body");
				var transitStepTemplate = _.template($("#transitStepTemplate").html());
				var $progressShowButton = $("a.progressShowButton");
				
				// 订单支付
				$payment.click(function() {
					$.ajax({
						url: "${base}/member/order/check_lock",
						type: "POST",
						data: {
							orderSn: "${order.sn}"
						},
						dataType: "json",
						cache: false,
						success: function() {
							location.href = URI("${base}/order/payment").setSearch("orderSns", "${order.sn}").toString();
						}
					});
					return false;
				});
				
				// 订单取消
				$cancel.click(function() {
					bootbox.confirm("${message("member.order.cancelConfirm")}", function(result) {
						if (result == null || !result) {
							return;
						}
						
						$.ajax({
							url: "${base}/member/order/cancel?orderSn=${order.sn}",
							type: "POST",
							dataType: "json",
							cache: false,
							success: function() {
								location.reload(true);
							}
						});
					});
					return false;
				});
				
				// 订单收货
				$receive.click(function() {
					bootbox.confirm("${message("member.order.receiveConfirm")}", function(result) {
						if (result == null || !result) {
							return;
						}
						
						$.ajax({
							url: "${base}/member/order/receive?orderSn=${order.sn}",
							type: "POST",
							dataType: "json",
							cache: false,
							success: function() {
								location.reload(true);
							}
						});
					});
					return false;
				});
				
				// 物流动态
				$transitStep.click(function() {
					var $element = $(this);
					
					$.ajax({
						url: "${base}/member/order/transit_step",
						type: "GET",
						data: {
							orderShippingSn: $element.data("order-shipping-sn")
						},
						dataType: "json",
						beforeSend: function() {
							$transitStepModalBody.empty();
							$transitStepModal.modal();
						},
						success: function(data) {
							$transitStepModalBody.html(transitStepTemplate({
								data: data
							}));
						}
					});
					return false;
				});
				
				$progressShowButton.click(function(){
					var productId = $(this).attr("data-id");
					var $productItem = $("tr.product-item-" + productId);
					var $progressItem = $("tr.progress-item-" + productId);
					if($progressItem.length > 0){
						$progressItem.remove();
						return;
					}
					$("tr.progress-item").remove();
					
					$productItem.after('<tr class="progress-item-' + productId + '" colspan="6"><td>加载中...</td></tr>');
					$.ajax({
						url: "${base}/member/order/list_progress",
						type: "POST",
						data: {
							productId: productId,
							orderId:"${order.id}"
						},
						dataType: "json",
						cache: false,
						success: function(data) {
							$progressItem = $("tr.progress-item-" + productId);
							$progressItem.remove();
							
							for(var i = data.length - 1; i >= 0 ; i--){
								var d = new Date(data[i].createDate).format('yyyy-MM-dd');
								$productItem.after('<tr class="progress-item progress-item-' + productId + (i == data.length - 2?" product-item-last":"") + '"><td colspan="6">' + d + '&nbsp;&nbsp;&nbsp;&nbsp;' + data[i].content + '</td></tr>');
							}
						}
					});
				});
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="member">
	[#include "/shop/include/main_header.ftl" /]
	<main>
		<div class="container">
			<div id="transitStepModal" class="modal fade" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button class="close" type="button" data-dismiss="modal">&times;</button>
							<h5 class="modal-title">${message("member.order.transitStep")}</h5>
						</div>
						<div class="modal-body"></div>
						<div class="modal-footer">
							<button class="btn btn-default" type="button" data-dismiss="modal">${message("member.order.close")}</button>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-2">
					[#include "/member/include/main_menu.ftl" /]
				</div>
				<div class="col-xs-10">
					<form action="${base}/member/order/view" method="get">
						<div class="order-detail panel panel-default">
							<div class="panel-heading">${message("member.order.view")}</div>
							<div class="panel-body">
								<div class="list-group">
									<div class="list-group-item clearfix">
										<span class="pull-left">${message("Order.sn")}: ${order.sn}</span>
										<span class="action pull-right">
											[#if false]
												[#if setting.isReviewEnabled && !order.isReviewed && (order.status == "RECEIVED" || order.status == "COMPLETED")]
													<a class="btn btn-default" href="${base}/member/review/add?orderId=${order.id}">${message("member.order.review")}</a>
												[/#if]
												[#if order.type == "GENERAL" && (order.status == "RECEIVED" || order.status == "COMPLETED")]
													<a class="btn btn-default" href="${base}/member/aftersales/apply?orderId=${order.id}">${message("member.order.aftersalesApply")}</a>
												[/#if]
												[#if order.paymentMethod?? && order.amountPayable > 0 && (!order.groupBuying?? || !order.groupBuying.hasEnded())]
													<a id="payment" class="btn btn-primary" href="javascript:;">${message("member.order.payment")}</a>
												[/#if]
												[#if !order.hasExpired() && ((order.status == "PENDING_PAYMENT" && (!order.groupBuying?? || !order.groupBuying.hasEnded() || order.groupBuying.groupEnded || order.amountPaid <= 0)) || (order.status == "PENDING_REVIEW" && (!order.groupBuying?? || order.groupBuying.status == "GROUP_SUCCESSED")))]
													<a id="cancel" class="btn btn-default" href="javascript:;">${message("member.order.cancel")}</a>
												[/#if]
												[#if !order.hasExpired() && order.status == "SHIPPED"]
													<a id="receive" class="btn btn-default" href="javascript:;">${message("member.order.receive")}</a>
												[/#if]
											[/#if]
											<a class="btn btn-default" href="${base}/order/impotBOM?orderId=${order.id}">下载</a>
											<a id="cancel" class="btn btn-default" href="javascript:;">终止</a>
										</span>
									</div>
									<div class="list-group-item">
										[#if order.hasExpired()]
											<h5 class="text-gray-dark">${message("member.order.hasExpired")}</h5>
										[#else]
											[#if order.status == "PENDING_PAYMENT"]
												[#if order.groupBuying?? && order.amountPaid <= 0 && order.groupBuying.hasEnded()]
													<h5 class="text-orange">${message("GroupBuying.groupEnded")}</h5>
												[#elseif order.groupBuying?? && order.amountPaid > 0 && order.groupBuying.groupEnded]
													<h5 class="text-orange">${message("GroupBuying.groupEnded")}</h5>
												[#elseif order.groupBuying?? && order.amountPaid > 0 && order.groupBuying.groupFailure]
													<h5 class="text-red">${message("GroupBuying.groupFailure")}</h5>
												[#else]
													<h5 class="text-orange">${message("Order.Status." + order.status)}</h5>
												[/#if]
											[#elseif order.status == "PENDING_REVIEW"]
												[#if order.groupBuying?? && order.groupBuying.status == "PENDING_GROUP_SUCCESS" && !order.groupBuying.hasEnded()]
													<h5 class="text-orange">${message("GroupBuying.Status.PENDING_GROUP_SUCCESS")}</h5>
												[#elseif order.groupBuying?? && order.groupBuying.groupFailure]
													<h5 class="text-red">${message("GroupBuying.groupFailure")}</h5>
												[#else]
													<h5 class="text-orange">${message("Order.Status." + order.status)}</h5>
												[/#if]
											[#elseif order.status == "PENDING_SHIPMENT"]
												<h5 class="text-orange">${message("Order.Status." + order.status)}</h5>
											[#elseif order.status == "FAILED" || order.status == "DENIED"]
												<h5 class="text-red">${message("Order.Status." + order.status)}</h5>
											[#elseif order.status == "CANCELED"]
												[#if order.groupBuying??]
													<h5 class="text-red">${message("GroupBuying.groupFailure")}</h5>
												[#else]
													<h5 class="text-gray-dark">${message("Order.Status." + order.status)}</h5>
												[/#if]
											[#else]
												<h5 class="text-green">${message("Order.Status." + order.status)}</h5>
											[/#if]
										[/#if]
										<p>
											[#if order.hasExpired()]
												${message("member.order.hasExpiredTips")}
											[#elseif order.status == "PENDING_PAYMENT"]
												[#if order.groupBuying?? && order.amountPaid <= 0 && order.groupBuying.hasEnded()]
													${message("member.order.groupBuyingEndedTips")}
												[#elseif order.groupBuying?? && order.amountPaid > 0 && order.groupBuying.groupEnded]
													${message("member.order.groupBuyingEndedTips")}
												[#elseif order.groupBuying?? && order.amountPaid > 0 && order.groupBuying.groupFailure]
													${message("member.order.groupBuyingFailureTips")}
												[#else]
													${message("member.order.pendingPaymentTips")}
												[/#if]
											[#elseif order.status == "PENDING_REVIEW"]
												[#if order.groupBuying?? && order.groupBuying.status == "PENDING_GROUP_SUCCESS" && !order.groupBuying.hasEnded()]
													${message("member.order.pendingGroupSuccessTips")}
												[#elseif order.groupBuying?? && order.groupBuying.groupFailure]
													${message("member.order.groupBuyingFailureTips")}
												[#else]
													${message("member.order.pendingReviewTips")}
												[/#if]
											[#elseif order.status == "PENDING_SHIPMENT"]
												${message("member.order.pendingShipmentTips")}
											[#elseif order.status == "SHIPPED"]
												${message("member.order.shippedTips")}
											[#elseif order.status == "RECEIVED"]
												${message("member.order.receivedTips")}
											[#elseif order.status == "COMPLETED"]
												${message("member.order.completedTips")}
											[#elseif order.status == "FAILED"]
												${message("member.order.failedTips")}
											[#elseif order.status == "CANCELED"]
												[#if order.groupBuying??]
													${message("member.order.groupBuyingFailureTips")}
												[#else]
													${message("member.order.canceledTips")}
												[/#if]
											[#elseif order.status == "DENIED"]
												${message("member.order.deniedTips")}
											[/#if]
											[#if order.expire?? && !order.hasExpired()]
												<span class="text-orange">(${message("Order.expire")}: ${order.expire?string("yyyy-MM-dd HH:mm:ss")})</span>
											[/#if]
										</p>
									</div>
									<div class="list-group-item">
										<dl class="clearfix">
											<dt>${message("member.order.info")}</dt>
											<dd>
												${message("common.createdDate")}:
												<span class="text-gray-darker">${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</span>
											</dd>
											[#if false]
												[#if order.paymentMethodName??]
													<dd>
														${message("Order.paymentMethod")}:
														<span class="text-gray-darker">${order.paymentMethodName}</span>
													</dd>
												[/#if]
												[#if order.shippingMethodName??]
													<dd>
														${message("Order.shippingMethod")}:
														<span class="text-gray-darker">${order.shippingMethodName}</span>
													</dd>
												[/#if]
												<dd>
													${message("Order.price")}:
													<span class="text-gray-darker">${currency(order.price, true, true)}</span>
												</dd>
											[/#if]
											[#if order.memo?has_content]
												<dd>
													${message("Order.memo")}:
													<span class="text-gray-darker">${order.memo}</span>
												</dd>
											[/#if]
										</dl>
									</div>
									[#if order.invoice??]
										<div class="list-group-item">
											<dl class="clearfix">
												<dt>${message("member.order.invoiceInfo")}</dt>
												<dd>
													${message("Invoice.title")}:
													<span class="text-gray-darker">${order.invoice.title}</span>
												</dd>
												<dd>
													${message("Invoice.taxNumber")}:
													<span class="text-gray-darker">${order.invoice.taxNumber}</span>
												</dd>
												<dd>
													${message("Order.tax")}:
													<span class="text-gray-darker">${currency(order.tax, true, true)}</span>
												</dd>
											</dl>
										</div>
									[/#if]
									[#if order.isDelivery]
										<div class="list-group-item">
											<dl class="clearfix">
												<dt>${message("member.order.receiveInfo")}</dt>
												<dd>
													${message("Order.consignee")}:
													<span class="text-gray-darker">${order.consignee}</span>
												</dd>
												<dd>
													${message("Order.zipCode")}:
													<span class="text-gray-darker">${order.zipCode}</span>
												</dd>
												<dd>
													${message("Order.address")}:
													<span class="text-gray-darker">${order.areaName}${order.address}</span>
												</dd>
												<dd>
													${message("Order.phone")}:
													<span class="text-gray-darker">${order.phone}</span>
												</dd>
											</dl>
										</div>
									[/#if]
									[#if order.orderShippings?has_content]
										<div class="list-group-item">
											<dl class="clearfix">
												<dt>${message("member.order.transitStepInfo")}</dt>
												[#list order.orderShippings as orderShipping]
													<dd>
														${message("OrderShipping.deliveryCorp")}:
														[#if orderShipping.deliveryCorpUrl??]
															<a href="${orderShipping.deliveryCorpUrl}" target="_blank">${orderShipping.deliveryCorp}</a>
														[#else]
															${orderShipping.deliveryCorp!"-"}
														[/#if]
													</dd>
													<dd>
														${message("OrderShipping.trackingNo")}:
														${orderShipping.trackingNo!"-"}
														[#if isKuaidi100Enabled && orderShipping.deliveryCorpCode?has_content && orderShipping.trackingNo?has_content]
															<a class="transit-step text-orange" href="javascript:;" data-order-shipping-sn="${orderShipping.sn}">[${message("member.order.transitStep")}]</a>
														[/#if]
													</dd>
													<dd>${message("member.order.deliveryDate")}: ${orderShipping.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
													<dd>&nbsp;</dd>
												[/#list]
											</dl>
										</div>
									[/#if]
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>${message("member.order.product")}</th>
											<th>${message("OrderItem.name")}</th>
											[#if false]
												<th>${message("OrderItem.price")}</th>
											[/#if]
											<th>${message("OrderItem.quantity")}</th>
											[#if false]
												<th>${message("OrderItem.subtotal")}</th>
											[/#if]
											<th>${message("OrderProgress.progress")}</th>
										</tr>
									</thead>
									<tbody>
										[#list order.orderItems as orderItem]
											<tr class="product-item-${orderItem.sku.product.id}">
												<td>
													[#if orderItem.sku??]
														<a href="${base}${orderItem.sku.path}" title="${orderItem.name}" target="_blank">
															<img class="img-thumbnail" src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" alt="${orderItem.name}">
														</a>
													[#else]
														<img class="img-thumbnail" src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" alt="${orderItem.name}">
													[/#if]
												</td>
												<td>
													[#if orderItem.sku??]
														<a href="${base}${orderItem.sku.path}" target="_blank">${orderItem.name}</a>
													[#else]
														${orderItem.name}
													[/#if]
													[#if orderItem.specifications?has_content]
														<span class="text-gray">[${orderItem.specifications?join(", ")}]</span>
													[/#if]
													[#if orderItem.type != "GENERAL"]
														<span class="text-red">[${message("Product.Type." + orderItem.type)}]</span>
													[/#if]
												</td>
												[#if false]
													<td>
														[#if orderItem.type == "GENERAL"]
															${currency(orderItem.price, true)}
														[#else]
															-
														[/#if]
													</td>
												[/#if]
												<td>${orderItem.quantity}</td>
												[#if false]
													<td>
														[#if orderItem.type == "GENERAL"]
															${currency(orderItem.subtotal, true)}
														[#else]
															-
														[/#if]
													</td>
												[/#if]
												<td>
													<a class="btn btn-default btn-xs btn-icon progressShowButton" title="${message("business.order.showProgress")}" data-id="${orderItem.sku.product.id}">
														<i class="iconfont icon-search"></i>
													</a>
												</td>
											</tr>
										[/#list]
									</tbody>
								</table>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>