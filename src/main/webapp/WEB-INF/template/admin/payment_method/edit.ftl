<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.paymentMethod.edit")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-fileinput.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/admin/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/bootstrap-select.js"></script>
	<script src="${base}/resources/common/js/bootstrap-fileinput.js"></script>
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/admin/js/base.js"></script>
	<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${setting.siteUrl}/resources/plugin/ueditor/";
	window.SERVER_URL = "${base}";
	</script>
	<script type="text/javascript" charset="utf-8" src="${base}/resources/plugin/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${base}/resources/plugin/ueditor/ueditor.all.js"></script>
	<script type="text/javascript">
		UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
		UE.Editor.prototype.getActionUrl = function(action) {
			if (action == 'uploadimage') {
				return SERVER_URL + '/common/ueditor/upload_image';
			} else if (action == 'uploadfile') {
				return SERVER_URL + '/common/ueditor/upload_file';
			} else if (action == 'uploadvideo') {
				return SERVER_URL + '/common/ueditor/upload_video';
			} else{
				return this._bkGetActionUrl.call(this, action);
			}
		};
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $paymentMethodForm = $("#paymentMethodForm");
				
				// 表单验证
				$paymentMethodForm.validate({
					rules: {
						name: "required",
						timeout: {
							integer: true,
							min: 1
						},
						order: "digits"
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/payment_method/list"
						});
					}
				});
				if (UE != null) {
					var ue = UE.getEditor('ueditorDiv');
		            ue.ready(function(){
		            	var csrfToken = $.cookie("csrfToken");
		            	ue.execCommand('serverparam','csrfToken',csrfToken);
		            	ue.setContent($("#ueditorHtml").val());
		            	ue.setHeight('300px');
		            });
				}
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="admin">
	[#include "/admin/include/main_header.ftl" /]
	[#include "/admin/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li>
					<a href="${base}/admin/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("admin.paymentMethod.edit")}</li>
			</ol>
			<form id="paymentMethodForm" class="ajax-form form-horizontal" action="${base}/admin/payment_method/update" method="post">
				<input name="id" type="hidden" value="${paymentMethod.id}">
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.paymentMethod.edit")}</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="name">${message("PaymentMethod.name")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="name" name="name" class="form-control" type="text" value="${paymentMethod.name}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("PaymentMethod.type")}:</label>
							<div class="col-xs-9 col-sm-4">
								<select name="type" class="selectpicker form-control" data-size="10">
									[#list types as type]
										<option value="${type}"[#if type == paymentMethod.type] selected[/#if]>${message("PaymentMethod.Type." + type)}</option>
									[/#list]
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("PaymentMethod.method")}:</label>
							<div class="col-xs-9 col-sm-4">
								<select name="method" class="selectpicker form-control" data-size="10">
									[#list methods as method]
										<option value="${method}"[#if method == paymentMethod.method] selected[/#if]>${message("PaymentMethod.Method." + method)}</option>
									[/#list]
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="timeout">${message("PaymentMethod.timeout")}:</label>
							<div class="col-xs-9 col-sm-4" title="${message("admin.paymentMethod.timeoutTitle")}" data-toggle="tooltip">
								<div class="input-group">
									<input id="timeout" name="timeout" class="form-control" type="text" value="${paymentMethod.timeout}" maxlength="9">
									<span class="input-group-addon">${message("common.unit.minute")}</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("PaymentMethod.icon")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input name="icon" type="hidden" value="${paymentMethod.icon}" data-provide="fileinput" data-file-type="IMAGE">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="description">${message("PaymentMethod.description")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="description" name="description" class="form-control" type="text" value="${paymentMethod.description}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="order">${message("common.order")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="order" name="order" class="form-control" type="text" value="${paymentMethod.order}" maxlength="9">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("PaymentMethod.content")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="content" style="display:none;" id="ueditorHtml">${paymentMethod.content}</textarea>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
								<button class="btn btn-primary" type="submit">${message("common.submit")}</button>
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