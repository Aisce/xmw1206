<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.store.edit")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
	<script src="${base}/resources/common/js/moment.js"></script>
	<script src="${base}/resources/common/js/bootstrap-datetimepicker.js"></script>
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
			
				var $storeForm = $("#storeForm");
				
				// 表单验证
				$storeForm.validate({
					rules: {
						name: {
							required: true,
							remote: {
								url: "${base}/admin/store/check_name?id=${store.id}",
								cache: false
							}
						},
						email: {
							required: true,
							email: true
						},
						mobile: {
							required: true,
							mobile: true
						},
						zipCode: "zipCode",
						phone: "phone",
						introduction: {
							maxlength: 200
						},
						endDate: "required"
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/mechanism_store/list"
						});
					},
					messages: {
						name: {
							remote: "${message("common.validator.exist")}"
						}
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
				<li class="active">${message("admin.store.edit")}</li>
			</ol>
			<form id="storeForm" class="ajax-form form-horizontal" action="${base}/admin/mechanism_store/update" method="post">
				<input name="id" type="hidden" value="${store.id}">
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.store.edit")}</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="name">${message("Store.name")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="name" name="name" class="form-control" type="text" value="${store.name}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="number">${message("mechanismStore.number")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="number" name="number" class="form-control" type="text" value="${store.number}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Store.logo")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input name="logo" type="hidden" value="${store.logo}" data-provide="fileinput" data-file-type="IMAGE">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required">图标:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="image" name="image" type="hidden" data-provide="fileinput" data-file-type="IMAGE" value="${store.image}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="number">机构url:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="url" name="url" class="form-control" type="text" maxlength="200" value="${store.url}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Store.type")}:</label>
							<div class="col-xs-9 col-sm-4">
								<p class="form-control-static">${message("mechanismStore.Type." + store.type)}</p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="email">${message("Store.email")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="email" name="email" class="form-control" type="text" value="${store.email}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="mobile">${message("Store.mobile")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="mobile" name="mobile" class="form-control" type="text" value="${store.mobile}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="phone">${message("Store.phone")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="phone" name="phone" class="form-control" type="text" value="${store.phone}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="address">${message("Store.address")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="address" name="address" class="form-control" type="text" value="${store.address}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="zipCode">${message("Store.zipCode")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="zipCode" name="zipCode" class="form-control" type="text" value="${store.zipCode}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="zipCode">排序:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="sorting" name="sorting" class="form-control" type="text" maxlength="200" value="${store.sorting}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="sclxr">${message("Store.sclxr")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="sclxr" name="sclxr" class="form-control" type="text" value="${store.sclxr}" maxlength="16">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="sclxfs">${message("Store.sclxfs")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="sclxfs" name="sclxfs" class="form-control" type="text" value="${store.sclxfs}" maxlength="16">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="introduction">${message("Store.introduction")}:</label>
							<div class="col-xs-9 col-sm-4">
								<textarea id="introduction" name="introduction" class="form-control" rows="5">${store.introduction}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="keyword">${message("Store.keyword")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="keyword" name="keyword" class="form-control" type="text" value="${store.keyword}" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("common.setting")}:</label>
							<div class="col-xs-9 col-sm-4">
								<div class="checkbox">
									<input name="_isEnabled" type="hidden" value="false">
									<input id="isEnabled" name="isEnabled" type="checkbox" value="true"[#if store.isEnabled] checked[/#if]>
									<label for="isEnabled">${message("User.isEnabled")}</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("addmin.introduction")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="content" style="display:none;" id="ueditorHtml">${store.content}</textarea>
								<!--<textarea name="content" class="form-control" data-provide="editor"></textarea>-->
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