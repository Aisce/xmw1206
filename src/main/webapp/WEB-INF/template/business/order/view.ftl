<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("business.order.view")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-datetimepicker.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/business/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/bootstrap-select.js"></script>
	<script src="${base}/resources/common/js/jquery.lSelect.js"></script>
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
		<script src="${base}/resources/common/js/moment.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
		<script src="${base}/resources/common/js/bootstrap-datetimepicker.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/business/js/base.js"></script>
	<style>
		.returns-items-quantity, .shipping-items-quantity {
			width: 50px;
		}
		
		div.modal .table tbody tr td {
			vertical-align: middle;
		}
	</style>
	<script id="transitStepTemplate" type="text/template">
		<%if (_.isEmpty(data.transitSteps)) {%>
			<p class="text-gray">${message("business.order.noResult")}</p>
		<%} else {%>
			<div class="list-group">
				<%_.each(data.transitSteps, function(transitStep, i) {%>
					<div class="list-group-item">
						<p class="text-gray"><%-transitStep.time%></p>
						<p><%-transitStep.context%></p>
					</div>
				<%});%>
			</div>
		<%}%>
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $review = $("button.review");
				var $paymentForm = $("#paymentForm");
				var $amount = $("#paymentForm input[name='amount']");
				var $refundsForm = $("#refundsForm");
				var $refundsMethod = $("#refundsForm select[name='method']");
				var $areaId = $("[name='areaId']");
				var $shippingForm = $("#shippingForm");
				var $shippingItemsQuantity = $("#shippingForm .shipping-items-quantity");
				var $returnsForm = $("#returnsForm");
				var $returnsItemsQuantity = $("#returnsForm .returns-items-quantity");
				var $complete = $("button.complete");
				var $fail = $("button.fail");
				var $transitStep = $("a.transit-step");
				var transitStepTemplate = _.template($("#transitStepTemplate").html());
				var $transitStepModal = $("#transitStepModal");
				var $transitStepModalBody = $("#transitStepModal div.modal-body");
				var $progressTabButton = $("#progressTabButton");
				var isLocked = false;
				
				// 地区选择
				$areaId.lSelect({
					url: "${base}/common/area"
				});
				
				// 检查锁定
				function acquireLock() {
					$.ajax({
						url: "${base}/business/order/acquire_lock",
						type: "POST",
						data: {
							orderId: ${order.id}
						},
						dataType: "json",
						cache: false,
						success: function(data) {
							if (!data) {
								$.bootstrapGrowl("${message("business.order.locked")}", {
									type: "warning"
								});
								$("button.review").add($("#paymentModalButton")).add($("#refundsModalButton")).add($("#shippingModalButton")).add($("#returnsModalButton")).add($("button.complete")).add($("button.fail")).prop("disabled", true);
								isLocked = true;
							}
						}
					});
				}
				
				// 获取订单锁
				acquireLock();
				setInterval(function() {
					if (!isLocked) {
						acquireLock();
					}
				}, 50000);
				
				// 审核
				$review.click(function() {
					var $element = $(this);
					
					bootbox.prompt({
						title: "${message("common.bootbox.title")}",
						inputType: "select",
						value: "APPROVED",
						inputOptions: [
							{
								text: "${message("business.order.reviewApproved")}",
								value: "APPROVED"
							},
							{
								text: "${message("business.order.reviewFailed")}",
								value: "FAILED"
							}
						],
						callback: function(result) {
							if (result == null) {
								return;
							}
							
							$.ajax({
								url: "${base}/business/order/review",
								type: "POST",
								data: {
									orderId: $element.data("id"),
									passed: result === "APPROVED" ? "true" : "false"
								},
								dataType: "json",
								cache: false,
								success: function() {
									location.reload(true);
								}
							});
						}
					}).find("select").selectpicker();
				});
				
				// 收款
				$paymentForm.validate({
					rules: {
						amount: {
							required: true,
							positive: true,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						}
					},
					submitHandler: function(form) {
						if (parseFloat($amount.val()) <= ${order.amountPayable} || confirm("${message("business.order.paymentConfirm")}")) {
							$(form).ajaxSubmit({
								successRedirectUrl: "${base}/business/order/view?orderId=${order.id}"
							});
						}
					}
				});
				
				// 退款
				$refundsForm.validate({
					rules: {
						amount: {
							required: true,
							positive: true,
							max: ${order.amountPaid},
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						}
					},
					submitHandler: function(form) {
						if ($refundsMethod.val() === "DEPOSIT") {
							[#if currentUser.availableBalance < order.refundableAmount]
								$.bootstrapGrowl("${message("business.order.insufficientBalance")}", {
									type: "warning"
								});
								return false;
							[/#if]
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/business/order/view?orderId=${order.id}"
						});
					}
				});
				
				// 发货
				function checkDelivery() {
					var isDelivery = false;
					
					$shippingItemsQuantity.each(function() {
						var $element = $(this);
						
						if ($element.data("is-delivery") && $element.val() > 0) {
							isDelivery = true;
							return false;
						}
					});
					$shippingForm.find(".row :input:not([name='memo'])").prop("disabled", !isDelivery);
				}
				
				checkDelivery();
				
				$shippingItemsQuantity.on("input propertychange change", function(event) {
					if (event.type !== "propertychange" || event.originalEvent.propertyName === "value") {
						checkDelivery()
					}
				});
				
				$.validator.addClassRules({
					"shipping-items-quantity": {
						required: true,
						digits: true
					}
				});
				
				$shippingForm.validate({
					rules: {
						freight: {
							number: true,
							min: 0,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						consignee: "required",
						zipCode: {
							required: true,
							zipCode: true
						},
						areaId: "required",
						address: "required",
						phone: {
							required: true,
							phone: true
						}
					},
					submitHandler: function(form) {
						var total = 0;
					
						$shippingItemsQuantity.each(function() {
							var quantity = $(this).val();
							
							if ($.isNumeric(quantity)) {
								total += parseInt(quantity);
							}
						});
						if (total <= 0) {
							$.bootstrapGrowl("${message("business.order.shippingQuantityPositive")}", {
								type: "warning"
							});
							return false;
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/business/order/view?orderId=${order.id}"
						});
					}
				});
				
				// 退货
				$.validator.addClassRules({
					"returns-items-quantity": {
						required: true,
						digits: true
					}
				});
				
				$returnsForm.validate({
					rules: {
						freight: {
							number: true,
							min: 0,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						zipCode: "zipCode",
						phone: "phone"
					},
					submitHandler: function(form) {
						var total = 0;
					
						$returnsItemsQuantity.each(function() {
							var quantity = $(this).val();
							
							if ($.isNumeric(quantity)) {
								total += parseInt(quantity);
							}
						});
						if (total <= 0) {
							$.bootstrapGrowl("${message("business.order.shippingQuantityPositive")}", {
								type: "warning"
							});
							return false;
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/business/order/view?orderId=${order.id}"
						});
					}
				});
				
				// 完成 失败
				$complete.add($fail).click(function() {
					var $element = $(this);
					var message = $element.hasClass("complete") ? "${message("business.order.completeConfirm")}" : "${message("business.order.failConfirm")}";
					
					bootbox.confirm(message, function(result) {
						if (result == null || !result) {
							return;
						}
						
						$.ajax({
							url: $element.hasClass("complete") ? "${base}/business/order/complete" : "${base}/business/order/fail",
							type: "POST",
							data: {
								orderId: $element.data("id")
							},
							dataType: "json",
							cache: false,
							success: function() {
								location.reload(true);
							}
						});
					});
				});
				
				// 物流动态
				$transitStep.click(function() {
					var $element = $(this);
					
					$.ajax({
						url: "${base}/business/order/transit_step",
						type: "GET",
						data: {
							shippingId: $element.data("shipping-id")
						},
						dataType: "json",
						beforeSend: function() {
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
				
				$progressTabButton.click(function(){
					$.bootstrapGrowl('${message("business.order.showProgressTip")}', {type: "info", delay: 3000});
					$('#orderTab.nav-tabs li:eq(1) a').tab('show');
				});
				var $progressAddModalButton = $("a.progressAddModalButton");
				var $progressShowModalButton = $("a.progressShowModalButton");
				var $progressAddModal = $("#progressAddModal");
				var $progressShowModal = $("#progressShowModal");
				var $productId = $("#productId");
				var $progressForm = $("#progressForm");
				var $progressContent = $("#progressContent");
				$progressAddModalButton.click(function(){
					$productId.val($(this).attr("data-id"));
					var $progressContent = $("#progressAddModal [name=content]");
					var $progressRemark = $("#progressAddModal [name=remark]");
					$progressContent.add($progressRemark).val('');
					///////////
					$("#remark").val(FormatDate());
					$progressAddModal.modal("show");
				});
				
				$progressShowModalButton.click(function(){
					$progressContent.html('<div class="col-xs-12">加载中...</div>');
					$productId.val($(this).attr("data-id"));
					$progressShowModal.modal("show");
					$.ajax({
						url: "${base}/business/order/list_progress",
						type: "POST",
						data: {
							productId: $productId.val(),
							orderId:"${order.id}"
						},
						dataType: "json",
						cache: false,
						success: function(data) {
							$progressContent.empty();
							for(var i = 0; i < data.length; i++){
								var d = new Date(data[i].createDate).format('yyyy-MM-dd EE HH:mm:ss');
								var d1 = data[i].remark
								var h = '<div class="col-xs-4">' + d1 + '</div><div class="col-xs-8">'+data[i].content+'</div>';
								$progressContent.append(h);
							}
						}
					});
				});
				
				$progressForm.ajaxForm({
					success: function(data){
						$.bootstrapGrowl(data.message, {
							type: "info"
						});
						$progressAddModal.modal("hide");
						$progressAddModal.find("button.btn-before-submit").removeClass("btn-before-submit").removeAttr("disabled");
					}
				});
			});
			function FormatDate () {
			    var date = new Date();
			    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
			}
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="business">
	[#include "/business/include/main_header.ftl" /]
	[#include "/business/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			[#if order.status == "PENDING_SHIPMENT"]
				<form id="progressForm" class="form-horizontal" action="${base}/business/order/add_progress" method="post">
					<input name="orderId" type="hidden" value="${order.id}">
					<input id="productId" name="productId" type="hidden" value="">
					<div id="progressAddModal" class="modal fade" tabindex="-1">
						<div class="modal-dialog modal-lg" style="width: 660px;">
							<div class="modal-content">
								<div class="modal-header">
									<button class="close" type="button" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">${message("business.order.editProgress")}</h5>
								</div>
								<div class="modal-body">
									<div class="row" style="margin-left: -210px;">
										<div class="col-xs-12">
											<div class='form-group'>
												<label class="col-xs-4 control-label" for="content">日期:</label>
												<div class="col-xs-8">
													<input type='text' name="remark" id="remark" class="form-control" data-provide="datetimepicker" data-date-format="YYYY-MM-DD"/>
												</div>
											</div>
										</div>
										<div class="col-xs-12">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="content">${message("OrderProgress.content")}:</label>
												<div class="col-xs-8">
													<textarea name="content" class="form-control" rows="8"></textarea>
												</div>
											</div>
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
				<div id="progressShowModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-lg" style="width: 550px;">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">${message("business.order.showProgress")}</h5>
							</div>
							<div class="modal-body">
								<div class="row" id="progressContent"></div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
				</div>
			[/#if]
			[#if currentStore.isSelf()]
				<form id="paymentForm" class="form-horizontal" action="${base}/business/order/payment" method="post">
					<input name="orderId" type="hidden" value="${order.id}">
					<div id="paymentModal" class="modal fade" tabindex="-1">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button class="close" type="button" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">${message("business.order.payment")}</h5>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("Order.sn")}:</dt>
												<dd>${order.sn}</dd>
												<dt>${message("Order.amount")}:</dt>
												<dd>${currency(order.amount, true, true)}</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("common.createdDate")}:</dt>
												<dd>${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
												<dt>${message("Order.amountPayable")}:</dt>
												<dd>
													<span class="text-red">${currency(order.amountPayable, true, true)}</span>
												</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="paymentBank">${message("OrderPayment.bank")}:</label>
												<div class="col-xs-8">
													<input id="paymentBank" name="bank" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="paymentAccount">${message("OrderPayment.account")}:</label>
												<div class="col-xs-8">
													<input id="paymentAccount" name="account" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="paymentAmount">${message("OrderPayment.amount")}:</label>
												<div class="col-xs-8">
													<input id="paymentAmount" name="amount" class="form-control" type="text"[#if order.amountPayable > 0] value="${order.amountPayable}"[/#if] maxlength="16">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="paymentPayer">${message("OrderPayment.payer")}:</label>
												<div class="col-xs-8">
													<input id="paymentPayer" name="payer" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderPayment.method")}:</label>
												<div class="col-xs-8">
													<select name="method" class="selectpicker form-control" data-size="5">
														[#list methods as method]
															[#if method != "DEPOSIT"]<option value="${method}">${message("OrderPayment.Method." + method)}</option>[/#if]
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderPayment.paymentMethod")}:</label>
												<div class="col-xs-8">
													<select name="paymentMethodId" class="selectpicker form-control" data-size="5">
														<option value="">${message("common.choose")}</option>
														[#list paymentMethods as paymentMethod]
															<option value="${paymentMethod.id}">${paymentMethod.name}</option>
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="paymentMemo">${message("OrderPayment.memo")}:</label>
												<div class="col-xs-8">
													<input id="paymentMemo" name="memo" class="form-control" type="text" maxlength="200">
												</div>
											</div>
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
			[/#if]
			[#if !order.hasExpired() && (order.refundableAmount > 0 || order.isAllowRefund)]
				<form id="refundsForm" class="form-horizontal" action="${base}/business/order/refunds" method="post">
					<input name="orderId" type="hidden" value="${order.id}">
					<div id="refundsModal" class="modal fade" tabindex="-1">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button class="close" type="button" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">${message("business.order.orderRefunds")}</h5>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("Order.sn")}:</dt>
												<dd>${order.sn}</dd>
												<dt>${message("Order.amount")}:</dt>
												<dd>${currency(order.amount, true, true)}</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("common.createdDate")}:</dt>
												<dd>${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
												<dt>${message("Order.refundableAmount")}:</dt>
												<dd>
													<span class="text-red">${currency(order.refundableAmount, true, true)}</span>
												</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="refundsBank">${message("OrderRefunds.bank")}:</label>
												<div class="col-xs-8">
													<input id="refundsBank" name="bank" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="refundsAccount">${message("OrderRefunds.account")}:</label>
												<div class="col-xs-8">
													<input id="refundsAccount" name="account" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="refundsAmount">${message("OrderRefunds.amount")}:</label>
												<div class="col-xs-8">
													<input id="refundsAmount" name="amount" class="form-control" type="text" value="${order.refundableAmount}" maxlength="16">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="refundsPayee">${message("OrderRefunds.payee")}:</label>
												<div class="col-xs-8">
													<input id="refundsPayee" name="payee" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderRefunds.method")}:</label>
												<div class="col-xs-8">
													<select name="method" class="selectpicker form-control" data-size="5">
														[#list refundsMethods as refundsMethod]
															<option value="${refundsMethod}">${message("OrderRefunds.Method." + refundsMethod)}</option>
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderRefunds.paymentMethod")}:</label>
												<div class="col-xs-8">
													<select name="paymentMethodId" class="selectpicker form-control" data-size="5">
														<option value="">${message("common.choose")}</option>
														[#list paymentMethods as paymentMethod]
															<option value="${paymentMethod.id}">${paymentMethod.name}</option>
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="refundsMemo">${message("OrderRefunds.memo")}:</label>
												<div class="col-xs-8">
													<input id="refundsMemo" name="memo" class="form-control" type="text" maxlength="200">
												</div>
											</div>
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
			[/#if]
			[#if order.shippableQuantity > 0]
				<form id="shippingForm" class="form-horizontal" action="${base}/business/order/shipping" method="post">
					<input name="orderId" type="hidden" value="${order.id}">
					<input name="deliveryCorpId" type="hidden" value="2">
					<div id="shippingModal" class="modal fade" tabindex="-1">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button class="close" type="button" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">${message("business.order.orderShipping")}</h5>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("Order.sn")}:</dt>
												<dd>${order.sn}</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("common.createdDate")}:</dt>
												<dd>${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
											</dl>
										</div>
										[#if false]
											<div class="col-xs-12 col-sm-6">
												<div class="form-group">
													<label class="col-xs-4 control-label">${message("OrderShipping.shippingMethod")}:</label>
													<div class="col-xs-8">
														<select name="shippingMethodId" class="selectpicker form-control" data-size="5">
															<option value="">${message("common.choose")}</option>
															[#list shippingMethods as shippingMethod]
																<option value="${shippingMethod.id}"[#if shippingMethod == order.shippingMethod] selected[/#if]>${shippingMethod.name}</option>
															[/#list]
														</select>
													</div>
												</div>
											</div>
											<div class="col-xs-12 col-sm-6">
												<div class="form-group">
													<label class="col-xs-4 control-label item-required">${message("OrderShipping.deliveryCorp")}:</label>
													<div class="col-xs-8">
														<select name="deliveryCorpId" class="selectpicker form-control" data-size="5">
															<option value="">${message("common.choose")}</option>
															[#list deliveryCorps as deliveryCorp]
																<option value="${deliveryCorp.id}"[#if order.shippingMethod?? && deliveryCorp == order.shippingMethod.defaultDeliveryCorp] selected[/#if]>${deliveryCorp.name}</option>
															[/#list]
														</select>
													</div>
												</div>
											</div>
											<div class="col-xs-12 col-sm-6">
												<div class="form-group">
													<label class="col-xs-4 control-label" for="shippingTrackingNo">${message("OrderShipping.trackingNo")}:</label>
													<div class="col-xs-8">
														<input id="shippingTrackingNo" name="trackingNo" class="form-control" type="text" maxlength="200">
													</div>
												</div>
											</div>
											<div class="col-xs-12 col-sm-6">
												<div class="form-group">
													<label class="col-xs-4 control-label" for="shippingFreight">${message("OrderShipping.freight")}:</label>
													<div class="col-xs-8">
														<input id="shippingFreight" name="freight" class="form-control" type="text" maxlength="16">
													</div>
												</div>
											</div>
										[/#if]
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="shippingConsignee">${message("OrderShipping.consignee")}:</label>
												<div class="col-xs-8">
													<input id="shippingConsignee" name="consignee" class="form-control" type="text" value="${order.consignee}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="shippingZipCode">${message("OrderShipping.zipCode")}:</label>
												<div class="col-xs-8">
													<input id="shippingZipCode" name="zipCode" class="form-control" type="text" value="${order.zipCode}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required">${message("OrderShipping.area")}:</label>
												<div class="col-xs-8">
													<input name="areaId" type="hidden" value="${(order.area.id)!}" treePath="${(order.area.treePath)!}">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="shippingAddress">${message("OrderShipping.address")}:</label>
												<div class="col-xs-8">
													<input id="shippingAddress" name="address" class="form-control" type="text" value="${order.address}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label item-required" for="shippingPhone">${message("OrderShipping.phone")}:</label>
												<div class="col-xs-8">
													<input id="shippingPhone" name="phone" class="form-control" type="text" value="${order.phone}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="shippingMemo">${message("OrderShipping.memo")}:</label>
												<div class="col-xs-8">
													<input id="shippingMemo" name="memo" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th>${message("business.orderShippingItem.sn")}</th>
													<th>${message("business.orderShippingItem.name")}</th>
													<th>${message("OrderShippingItem.isDelivery")}</th>
													<th>${message("business.order.skuStock")}</th>
													<th>${message("business.order.skuQuantity")}</th>
													<th>${message("business.order.shippedQuantity")}</th>
													<th>${message("business.order.shippingQuantity")}</th>
												</tr>
											</thead>
											<tbody>
												[#list order.orderItems as orderItem]
													<tr>
														<td>
															<input name="orderShippingItems[${orderItem_index}].sn" type="hidden" value="${orderItem.sn}">
															${orderItem.sn}
														</td>
														<td>
															${orderItem.name}
															[#if orderItem.specifications?has_content]
																<span class="text-gray">[${orderItem.specifications?join(", ")}]</span>
															[/#if]
															[#if orderItem.type != "GENERAL"]
																<span class="text-red">[${message("Product.Type." + orderItem.type)}]</span>
															[/#if]
														</td>
														<td>
															[#if orderItem.isDelivery]
																<i class="text-green iconfont icon-check"></i>
															[#else]
																<i class="text-red iconfont icon-close"></i>
															[/#if]
														</td>
														<td>${(orderItem.sku.stock)!"-"}</td>
														<td>${orderItem.quantity}</td>
														<td>${orderItem.shippedQuantity}</td>
														<td>
															[#if orderItem.sku?? && orderItem.sku.stock < orderItem.shippableQuantity]
																[#assign shippingQuantity = orderItem.sku.stock /]
															[#else]
																[#assign shippingQuantity = orderItem.shippableQuantity /]
															[/#if]
															<input name="orderShippingItems[${orderItem_index}].quantity" class="shipping-items-quantity form-control" type="text" value="${shippingQuantity}" max="${shippingQuantity}" data-is-delivery="${orderItem.isDelivery?string('true', 'false')}" maxlength="9"[#if shippingQuantity <= 0] disabled[/#if]>
														</td>
													</tr>
												[/#list]
											</tbody>
										</table>
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
			[/#if]
			[#if order.returnableQuantity > 0]
				<form id="returnsForm" class="form-horizontal" action="${base}/business/order/returns" method="post">
					<input name="orderId" type="hidden" value="${order.id}">
					<div id="returnsModal" class="modal fade" tabindex="-1">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button class="close" type="button" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">${message("business.order.orderReturns")}</h5>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("Order.sn")}:</dt>
												<dd>${order.sn}</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<dl class="items dl-horizontal">
												<dt>${message("common.createdDate")}:</dt>
												<dd>${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
											</dl>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderReturns.shippingMethod")}:</label>
												<div class="col-xs-8">
													<select name="shippingMethodId" class="selectpicker form-control" data-size="5">
														<option value="">${message("common.choose")}</option>
														[#list shippingMethods as shippingMethod]
															<option value="${shippingMethod.id}">${shippingMethod.name}</option>
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderReturns.deliveryCorp")}:</label>
												<div class="col-xs-8">
													<select name="deliveryCorpId" class="selectpicker form-control" data-size="5">
														<option value="">${message("common.choose")}</option>
														[#list deliveryCorps as deliveryCorp]
															<option value="${deliveryCorp.id}">${deliveryCorp.name}</option>
														[/#list]
													</select>
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsTrackingNo">${message("OrderReturns.trackingNo")}:</label>
												<div class="col-xs-8">
													<input id="returnsTrackingNo" name="trackingNo" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsFreight">${message("OrderReturns.freight")}:</label>
												<div class="col-xs-8">
													<input id="returnsFreight" name="freight" class="form-control" type="text" maxlength="16">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsShipper">${message("OrderReturns.shipper")}:</label>
												<div class="col-xs-8">
													<input id="returnsShipper" name="shipper" class="form-control" type="text" value="${order.consignee}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsZipCode">${message("OrderReturns.zipCode")}:</label>
												<div class="col-xs-8">
													<input id="returnsZipCode" name="zipCode" class="form-control" type="text" value="${order.zipCode}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label">${message("OrderReturns.area")}:</label>
												<div class="col-xs-8">
													<input name="areaId" type="hidden" value="${(order.area.id)!}" treePath="${(order.area.treePath)!}">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsAddress">${message("OrderReturns.address")}:</label>
												<div class="col-xs-8">
													<input id="returnsAddress" name="address" class="form-control" type="text" value="${order.address}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsPhone">${message("OrderReturns.phone")}:</label>
												<div class="col-xs-8">
													<input id="returnsPhone" name="phone" class="form-control" type="text" value="${order.phone}" maxlength="200">
												</div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="form-group">
												<label class="col-xs-4 control-label" for="returnsMemo">${message("OrderReturns.memo")}:</label>
												<div class="col-xs-8">
													<input id="returnsMemo" name="memo" class="form-control" type="text" maxlength="200">
												</div>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th>${message("OrderReturnsItem.sn")}</th>
													<th>${message("OrderReturnsItem.name")}</th>
													<th>${message("business.order.skuStock")}</th>
													<th>${message("business.order.shippedQuantity")}</th>
													<th>${message("business.order.returnedQuantity")}</th>
													<th>${message("business.order.returnsQuantity")}</th>
												</tr>
											</thead>
											<tbody>
												[#list order.orderItems as orderItem]
													<tr>
														<td>
															<input name="orderReturnsItems[${orderItem_index}].sn" type="hidden" value="${orderItem.sn}">
															${orderItem.sn}
														</td>
														<td>
															${orderItem.name}
															[#if orderItem.specifications?has_content]
																<span class="text-gray">[${orderItem.specifications?join(", ")}]</span>
															[/#if]
															[#if orderItem.type != "GENERAL"]
																<span class="text-red">[${message("Product.Type." + orderItem.type)}]</span>
															[/#if]
														</td>
														<td>${(orderItem.sku.stock)!"-"}</td>
														<td>${orderItem.shippedQuantity}</td>
														<td>${orderItem.returnedQuantity}</td>
														<td>
															<input name="orderReturnsItems[${orderItem_index}].quantity" class="returns-items-quantity form-control" type="text" value="${orderItem.returnableQuantity}" max="${orderItem.returnableQuantity}" maxlength="9"[#if orderItem.returnableQuantity <= 0] disabled[/#if]>
														</td>
													</tr>
												[/#list]
											</tbody>
										</table>
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
			[/#if]
			<div id="transitStepModal" class="transit-step-modal modal fade" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button class="close" type="button" data-dismiss="modal">&times;</button>
							<h5 class="modal-title">${message("business.order.transitStep")}</h5>
						</div>
						<div class="modal-body"></div>
						<div class="modal-footer">
							<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
						</div>
					</div>
				</div>
			</div>
			<ol class="breadcrumb">
				<li>
					<a href="${base}/business/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("business.order.view")}</li>
			</ol>
			<form class="form-horizontal">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs" id="orderTab">
							<li class="active">
								<a href="#orderInfo" data-toggle="tab">${message("business.order.orderInfo")}</a>
							</li>
							<li>
								<a href="#productInfo" data-toggle="tab">${message("business.order.productInfo")}</a>
							</li>
							[#if false]
								<li>
									<a href="#paymentInfo" data-toggle="tab">${message("business.order.paymentInfo")}</a>
								</li>
								<li>
									<a href="#orderRefundsInfo" data-toggle="tab">${message("business.order.orderRefundsInfo")}</a>
								</li>
							[/#if]
							<li>
								<a href="#orderShippingInfo" data-toggle="tab">${message("business.order.orderShippingInfo")}</a>
							</li>
							[#if false]
								<li>
									<a href="#oderReturnsInfo" data-toggle="tab">${message("business.order.oderReturnsInfo")}</a>
								</li>
							[/#if]
							<li>
								<a href="#orderLog" data-toggle="tab">${message("business.order.orderLog")}</a>
							</li>
						</ul>
						<div class="tab-content">
							<div id="orderInfo" class="tab-pane active">
								<div class="row">
									<div class="col-xs-10 col-sm-6 col-xs-offset-2 col-sm-offset-2">
										<div class="form-group">
											<button class="review btn btn-default" type="button" data-id="${order.id}"[#if order.hasExpired() || order.status != "PENDING_REVIEW" || (order.groupBuying?? && order.groupBuying.status != "GROUP_SUCCESSED")] disabled[/#if]>${message("business.order.review")}</button>
											[#if false]
												[#if currentStore.isSelf()]
													<button id="paymentModalButton" class="btn btn-default" type="button" data-toggle="modal" data-target="#paymentModal"[#if order.hasExpired()] disabled[/#if]>${message("business.order.payment")}</button>
												[/#if]
												<button id="refundsModalButton" class="btn btn-default" type="button" data-toggle="modal" data-target="#refundsModal"[#if order.hasExpired() || order.refundableAmount <= 0 && !order.isAllowRefund] disabled[/#if]>${message("business.order.orderRefunds")}</button>
											[/#if]
											<button id="progressTabButton" class="btn btn-default" type="button"[#if order.status != "PENDING_SHIPMENT"] disabled[/#if]>${message("business.order.orderProgress")}</button>
											<button id="shippingModalButton" class="btn btn-default" type="button" data-toggle="modal" data-target="#shippingModal"[#if order.shippableQuantity <= 0] disabled[/#if]>${message("business.order.orderShipping")}</button>
											[#if false]
												<button id="returnsModalButton" class="btn btn-default" type="button" data-toggle="modal" data-target="#returnsModal"[#if order.returnableQuantity <= 0 || order.status != "FAILED"] disabled[/#if]>${message("business.order.orderReturns")}</button>
											[/#if]
											<button class="complete btn btn-default" type="button" data-id="${order.id}"[#if order.hasExpired() || order.status != "RECEIVED"] disabled[/#if]>${message("business.order.complete")}</button>
											<button class="fail btn btn-default" type="button" data-id="${order.id}"[#if order.hasExpired() || (order.status != "PENDING_SHIPMENT" && order.status != "SHIPPED" && order.status != "RECEIVED")] disabled[/#if]>终止</button>
										</div>
									</div>
									<div class="col-xs-12 col-sm-6">
										<dl class="items dl-horizontal">
											<dt>${message("Order.sn")}:</dt>
											<dd>${order.sn}</dd>
											<dt>${message("Order.type")}:</dt>
											<dd>${message("Order.Type." + order.type)}</dd>
											<dt>${message("Order.member")}:</dt>
											<dd>${order.member.username}</dd>
											[#if false]
												<dt>${message("Order.price")}:</dt>
												<dd>${currency(order.price, true, true)}</dd>
												<dt>${message("Order.amount")}:</dt>
												<dd>${currency(order.amount, true, true)}</dd>
												[#if order.invoice??]
													<dt>${message("Invoice.title")}:</dt>
													<dd>${order.invoice.title}</dd>
													<dt>${message("Order.tax")}:</dt>
													<dd>${currency(order.tax, true, true)}</dd>
												[/#if]
												[#if order.refundAmount > 0 || order.refundableAmount > 0]
													<dt>${message("Order.refundAmount")}:</dt>
													<dd>${currency(order.refundAmount, true, true)}</dd>
												[/#if]
												<dt>${message("Order.weight")}:</dt>
												<dd>${order.weight}</dd>
												<dt>${message("Order.shippedQuantity")}:</dt>
												<dd>${order.shippedQuantity}</dd>
												<dt>${message("business.order.promotion")}:</dt>
												<dd>
													[#if order.promotionNames?has_content]
														<span>${order.promotionNames?join(", ")}</span>
													[#else]
														-
													[/#if]
												</dd>
												<dt>${message("business.order.coupon")}:</dt>
												<dd>${(order.couponCode.coupon.name)!"-"}</dd>
												<dt>${message("Order.fee")}:</dt>
												<dd>${currency(order.fee, true, true)}</dd>
												<dt>${message("Order.offsetAmount")}:</dt>
												<dd>${currency(order.offsetAmount, true, true)}</dd>
												<dt>${message("Order.paymentMethod")}:</dt>
												<dd>${order.paymentMethodName!"-"}</dd>
											[/#if]
											<dt>${message("Order.consignee")}:</dt>
											<dd>${order.consignee}</dd>
											<dt>${message("Order.address")}:</dt>
											<dd>${order.address}</dd>
											<dt>${message("Order.phone")}:</dt>
											<dd>${order.phone}</dd>
										</dl>
									</div>
									<div class="col-xs-12 col-sm-6">
										<dl class="items dl-horizontal">
											<dt>${message("common.createdDate")}:</dt>
											<dd>${order.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
											<dt>${message("Order.status")}:</dt>
											<dd>
												<span class="[#if order.status == "PENDING_SHIPMENT" || order.status == "PENDING_REVIEW" || order.status == "PENDING_PAYMENT"]text-orange[#elseif order.status == "FAILED" || order.status == "DENIED"]text-red[#elseif order.status == "CANCELED"]text-gray-dark[#else]text-green[/#if]">${message("Order.Status." + order.status)}</span>
												[#if order.hasExpired()]
													<span class="text-gray-dark">(${message("business.order.hasExpired")})</span>
												[#elseif order.expire??]
													<span class="text-orange">(${message("Order.expire")}: ${order.expire?string("yyyy-MM-dd HH:mm:ss")})</span>
												[#elseif order.status == "PENDING_REVIEW" && order.groupBuying??]
													[#if !order.groupBuying.groupFailure]
														<span class="text-gray-dark">(${message("GroupBuying.Status." + order.groupBuying.status)})</span>
													[#else]
														<span class="text-gray-dark">(${message("GroupBuying.groupFailure")})</span>
													[/#if]
												[/#if]
											</dd>
											<dt>${message("Member.memberRank")}:</dt>
											<dd>${order.member.memberRank.name}</dd>
											[#if false]
												<dt>${message("Order.exchangePoint")}:</dt>
												<dd>${order.exchangePoint}</dd>
												<dt>${message("Order.amountPaid")}:</dt>
												<dd>
													<span class="text-red">${currency(order.amountPaid, true, true)}</span>
													[#if order.amountPayable > 0]
														(${message("Order.amountPayable")}: ${currency(order.amountPayable, true, true)})
													[/#if]
												</dd>
												[#if order.invoice??]
													<dt>${message("Invoice.taxNumber")}:</dt>
													<dd>${order.invoice.taxNumber}</dd>
												[/#if]
												[#if order.refundAmount > 0 || order.refundableAmount > 0]
													<dt>${message("Order.refundableAmount")}:</dt>
													<dd>
														<span class="text-orange">${currency(order.refundableAmount, true, true)}</span>
													</dd>
												[/#if]
												<dt>${message("Order.quantity")}:</dt>
												<dd>${order.quantity}</dd>
												<dt>${message("Order.returnedQuantity")}:</dt>
												<dd>${order.returnedQuantity}</dd>
												<dt>${message("Order.promotionDiscount")}:</dt>
												<dd>${currency(order.promotionDiscount, true, true)}</dd>
												<dt>${message("Order.couponDiscount")}:</dt>
												<dd>${currency(order.couponDiscount, true, true)}</dd>
												<dt>${message("Order.freight")}:</dt>
												<dd>${currency(order.freight, true, true)}</dd>
												<dt>${message("Order.rewardPoint")}:</dt>
												<dd>${order.rewardPoint}</dd>
												<dt>${message("Order.shippingMethod")}:</dt>
												<dd>${order.shippingMethodName!"-"}</dd>
											[/#if]
											<dt>${message("Order.area")}:</dt>
											<dd>${order.areaName}</dd>
											<dt>${message("Order.zipCode")}:</dt>
											<dd>${order.zipCode}</dd>
											<dt>${message("Order.memo")}:</dt>
											<dd>${order.memo}</dd>
										</dl>
									</div>
								</div>
							</div>
							<div id="productInfo" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderItem.sn")}</th>
												<th>${message("OrderItem.name")}</th>
												<th>${message("OrderItem.price")}</th>
												<th>${message("OrderItem.quantity")}</th>
												<th>${message("OrderItem.subtotal")}</th>
												<th>${message("common.action")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderItems as orderItem]
												<tr>
													<td>${orderItem.sn}</td>
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
													<td>
														[#if orderItem.type == "GENERAL"]
															${currency(orderItem.price, true)}
														[#else]
															-
														[/#if]
													</td>
													<td>${orderItem.quantity}</td>
													<td>
														[#if orderItem.type == "GENERAL"]
															${currency(orderItem.subtotal, true)}
														[#else]
															-
														[/#if]
													</td>
													<td>
														<a class="btn btn-default btn-xs btn-icon progressAddModalButton" title="${message("business.order.editProgress")}" data-id="${orderItem.sku.product.id}">
															<i class="iconfont icon-write"></i>
														</a>
														<a class="btn btn-default btn-xs btn-icon progressShowModalButton" title="${message("business.order.showProgress")}" data-id="${orderItem.sku.product.id}">
															<i class="iconfont icon-search"></i>
														</a>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
								</div>
							</div>
							<div id="paymentInfo" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderPayment.sn")}</th>
												<th>${message("OrderPayment.method")}</th>
												<th>${message("OrderPayment.paymentMethod")}</th>
												<th>${message("OrderPayment.fee")}</th>
												<th>${message("OrderPayment.amount")}</th>
												<th>${message("common.createdDate")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderPayments as orderPayment]
												<tr>
													<td>${orderPayment.sn}</td>
													<td>${message("OrderPayment.Method." + orderPayment.method)}</td>
													<td>${orderPayment.paymentMethod!"-"}</td>
													<td>${currency(orderPayment.fee, true)}</td>
													<td>${currency(orderPayment.amount, true)}</td>
													<td>
														<span title="${orderPayment.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${orderPayment.createdDate}</span>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
									[#if !order.orderPayments?has_content]
										<p class="no-result">${message("common.noResult")}</p>
									[/#if]
								</div>
							</div>
							<div id="orderRefundsInfo" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderRefunds.sn")}</th>
												<th>${message("OrderRefunds.method")}</th>
												<th>${message("OrderRefunds.paymentMethod")}</th>
												<th>${message("OrderRefunds.amount")}</th>
												<th>${message("common.createdDate")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderRefunds as orderRefunds]
												<tr>
													<td>${orderRefunds.sn}</td>
													<td>${message("OrderRefunds.Method." + orderRefunds.method)}</td>
													<td>${orderRefunds.paymentMethod!"-"}</td>
													<td>${currency(orderRefunds.amount, true)}</td>
													<td>
														<span title="${orderRefunds.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${orderRefunds.createdDate}</span>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
									[#if !order.orderRefunds?has_content]
										<p class="no-result">${message("common.noResult")}</p>
									[/#if]
								</div>
							</div>
							<div id="orderShippingInfo" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderShipping.sn")}</th>
												<th>${message("OrderShipping.shippingMethod")}</th>
												<th>${message("OrderShipping.deliveryCorp")}</th>
												<th>${message("OrderShipping.trackingNo")}</th>
												<th>${message("OrderShipping.consignee")}</th>
												<th>${message("OrderShipping.isDelivery")}</th>
												<th>${message("common.createdDate")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderShippings as orderShipping]
												<tr>
													<td>${orderShipping.sn}</td>
													<td>${orderShipping.shippingMethod!"-"}</td>
													<td>${orderShipping.deliveryCorp!"-"}</td>
													<td>
														${orderShipping.trackingNo!"-"}
														[#if isKuaidi100Enabled && orderShipping.deliveryCorpCode?has_content && orderShipping.trackingNo?has_content]
															<a class="transit-step text-orange" href="javascript:;" data-shipping-id="${orderShipping.id}">[${message("business.order.transitStep")}]</a>
														[/#if]
													</td>
													<td>${orderShipping.consignee!"-"}</td>
													<td>
														[#if orderShipping.isDelivery]
															<i class="text-green iconfont icon-check"></i>
														[#else]
															<i class="text-red iconfont icon-close"></i>
														[/#if]
													</td>
													<td>
														<span title="${orderShipping.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${orderShipping.createdDate}</span>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
									[#if !order.orderShippings?has_content]
										<p class="no-result">${message("common.noResult")}</p>
									[/#if]
								</div>
							</div>
							<div id="oderReturnsInfo" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderReturns.sn")}</th>
												<th>${message("OrderReturns.shippingMethod")}</th>
												<th>${message("OrderReturns.deliveryCorp")}</th>
												<th>${message("OrderReturns.trackingNo")}</th>
												<th>${message("OrderReturns.shipper")}</th>
												<th>${message("common.createdDate")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderReturns as orderReturns]
												<tr>
													<td>${orderReturns.sn}</td>
													<td>${orderReturns.shippingMethod!"-"}</td>
													<td>${orderReturns.deliveryCorp!"-"}</td>
													<td>${orderReturns.trackingNo!"-"}</td>
													<td>${orderReturns.shipper}</td>
													<td>
													<span title="${orderReturns.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${orderReturns.createdDate}</span>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
									[#if !order.orderReturns?has_content]
										<p class="no-result">${message("common.noResult")}</p>
									[/#if]
								</div>
							</div>
							<div id="orderLog" class="tab-pane">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>${message("OrderLog.type")}</th>
												<th>${message("OrderLog.detail")}</th>
												<th>${message("common.createdDate")}</th>
											</tr>
										</thead>
										<tbody>
											[#list order.orderLogs as orderLog]
												<tr>
													<td>${message("OrderLog.Type." + orderLog.type)}</td>
													<td>
														[#if orderLog.detail??]
															<span title="${orderLog.detail}">${abbreviate(orderLog.detail, 30, "...")}</span>
														[#else]
															-
														[/#if]
													</td>
													<td>
														<span title="${orderLog.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${orderLog.createdDate}</span>
													</td>
												</tr>
											[/#list]
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
								<button class="btn btn-default" type="button" data-action="back">${message("common.back")}</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>
</body>
</html>