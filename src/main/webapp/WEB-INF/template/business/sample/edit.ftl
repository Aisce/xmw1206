<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("business.sample.list")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/zoom.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/business/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/zoom.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/business/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				var $profileForm = $("#profileForm");
				var $confirmFailBtn = $("#confirmFailBtn");
				var $failContent = $("#failContent");
				
				var $successModal = $("#successModal");
				var $successBtn = $("#successBtn");
				
				$confirmFailBtn.click(function(){
					var failContent = $failContent.val();
					if(failContent == null || failContent == ""){
						$.bootstrapGrowl("请输入审核失败理由", { type: "warning" });
						return;
					}
					$("#flag").val("2");
					$('#failModal').modal('hide');
					$profileForm.ajaxSubmit({
						successRedirectUrl: "${base}/business/sample/list"
					});
				});
				
				$successBtn.click(function(){
					$("#flag").val("1");
					$('#failModal').modal('hide');
					$profileForm.ajaxSubmit({
						successRedirectUrl: "${base}/business/sample/list"
					});
				});
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="admin">
	[#include "/business/include/main_header.ftl" /]
	[#include "/business/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li>
					<a href="${base}/business/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("business.sample.real")}</li>
			</ol>
			<form id="profileForm" class="ajax-form form-horizontal" action="${base}/business/sample/update" method="post">
				<input name="id" type="hidden" value="${sample.id}">
				<input id="flag" name="flag" type="hidden" value="">
				<div id="failModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">${message("admin.memberReal.reasonTitle")}</h5>
							</div>
							<div class="modal-body form-horizontal">
								<div class="form-group">
									<label class="col-xs-2 control-label">${message("business.sample.reason")}:</label>
									<div class="col-xs-10 col-sm-7">
										<div class="input-group">
											<textarea id="failContent" name="reason" rows="8" cols="60"></textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" id="confirmFailBtn">${message("common.ok")}</button>
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
				</div>
				
				<div id="successModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">请输入快递单号和快递公司</h5>
							</div>
							<div class="modal-body form-horizontal">
								<div class="form-group">
									<label class="col-xs-2 control-label">快递单号:</label>
									<div class="col-xs-10 col-sm-7">
										<div class="input-group">
											<input id="orderNubmer" name="orderNubmer"/>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-2 control-label">快递公司:</label>
									<div class="col-xs-10 col-sm-7">
										<div class="input-group">
											<select name="kuaidiCompany" class="selectpicker form-control" data-size="5">
												<option value="">${message("common.choose")}</option>
												[#list deliveryCorps as deliveryCorp]
													<option value="${deliveryCorp.id}">${deliveryCorp.name}</option>
												[/#list]
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" id="successBtn">${message("common.ok")}</button>
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="panel panel-default">
					<div class="panel-heading">${message("business.sample.real")}</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<dl class="items dl-horizontal">
								
									<dt>${message("business.sample.applyUser")}:</dt>
									<dd>${sample.applyUser}</dd>
									
									<dt>${message("business.sample.applyCompany")}:</dt>
									<dd>${sample.applyCompany}</dd>
									
									<dt>${message("common.createdDate")}:</dt>
									<dd>${sample.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
									
									<dt>${message("business.sample.applicationProduct")}:</dt>
									<dd>${sample.applicationProduct}</dd>
									
									<dt>${message("business.sample.applicationBackground")}:</dt>
									<dd>${sample.applicationBackground}</dd>
									
									
									<dt>${message("business.sample.address")}:</dt>
									<dd>${sample.address}</dd>
									
									
									<dt>${message("business.sample.product")}:</dt>
									<dd>${sample.product.name}</dd>
									
									<dt>${message("business.sample.phone")}</dt>
									<dd>${sample.phone}</dd>
									
									[#if sample.flag == 1]
										<dt>快递单号</dt>
										<dd>${sample.orderNubmer}</dd>
										
										<dt>快递公司</dt>
										<dd>${sample.kuaidiCompany}</dd>
									[/#if]
									[#if sample.flag == 2]
										<dt>不通过理由</dt>
										<dd>${sample.reason}</dd>
									[/#if]
								</dl>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							[#if sample.flag== 0]
								<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
									<button class="btn btn-primary submit" type="button" data-toggle="modal" data-target="#successModal">审核通过</button>
									<button class="btn btn-danger submit" type="button" data-toggle="modal" data-target="#failModal" >审核失败</button>
									<button class="btn btn-default" type="button" data-action="back">${message("common.back")}</button>
								</div>
							[/#if]
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>
</body>
</html>