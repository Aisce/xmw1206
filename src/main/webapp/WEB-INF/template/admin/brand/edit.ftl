<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.brand.edit")} - 北京芯梦国际科技有限公司</title>
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
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
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
				return SERVER_URL + '/common/ueditor/upload_Image';
			} else if (action == 'uploadfile') {
				return SERVER_URL + '/common/ueditor/upload_File';
			} else if (action == 'uploadvideo') {
				return SERVER_URL + '/common/ueditor/upload_Video';
			} else{
				return this._bkGetActionUrl.call(this, action);
			}
		};
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $brandForm = $("#brandForm");
				var $type = $("#type");
				var $logo = $("#logo");
				
				// 类型
				$type.change(function() {
					var isText = $(this).val() === "TEXT";
					
					$logo.prop("disabled", isText).closest(".form-group").velocity(isText ? "slideUp" : "slideDown");
				});
				
				// 表单验证
				$brandForm.validate({
					rules: {
						name: "required",
						logo: "required",
						url: "url2",
						order: "digits"
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/brand/list"
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
				<li class="active">${message("admin.brand.edit")}</li>
			</ol>
			<form id="brandForm" class="ajax-form form-horizontal" action="${base}/admin/brand/update" method="post">
				<input name="id" type="hidden" value="${brand.id}">
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.brand.edit")}</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="name">${message("Brand.name")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="name" name="name" class="form-control" type="text" value="${brand.name}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Brand.type")}:</label>
							<div class="col-xs-9 col-sm-4">
								<select id="type" name="type" class="selectpicker form-control" data-size="10">
									[#list types as type]
										<option value="${type}"[#if type == brand.type] selected[/#if]>${message("Brand.Type." + type)}</option>
									[/#list]
								</select>
							</div>
						</div>
						<div class="form-group[#if brand.type == "TEXT"] hidden-element[/#if]">
							<label class="col-xs-3 col-sm-2 control-label item-required">${message("Brand.logo")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="logo" name="logo" type="hidden" value="${brand.logo}" data-provide="fileinput" data-file-type="IMAGE"[#if brand.type == "TEXT"] disabled[/#if]>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="url">${message("Brand.url")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="url" name="url" class="form-control" type="text" value="${brand.url}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="order">${message("common.order")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="order" name="order" class="form-control" type="text" value="${brand.order}" maxlength="9">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Brand.introduction")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="introduction" style="display:none;" id="ueditorHtml">${brand.introduction}</textarea>
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