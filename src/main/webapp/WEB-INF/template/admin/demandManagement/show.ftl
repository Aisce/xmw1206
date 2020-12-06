<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.demandManagement.add")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
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
			
				var $articleForm = $("#articleForm");
				
				// 表单验证
				$articleForm.validate({
					rules: {
						title: "required",
						articleCategoryId: "required"
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/demand_management/list"
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
				<li class="active">${message("admin.demandManagement.add")}</li>
			</ol>
			<form id="articleForm" class="ajax-form form-horizontal" action="${base}/admin/demand_management/save" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.demandManagement.add")}</div>
					<div class="panel-body">
						<!--产品名称-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="title">${message("admin.demandManagement.product")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="name" name="name" readonly="readonly" class="form-control" type="text" maxlength="200" value="${DemandManagement.name}">
							</div>
						</div>
						<!--需求类型-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="author">${message("admin.demandManagement.type")}:</label>
							<div class="col-xs-9 col-sm-4">
								<label for="isTop"><input id="typeNorms1" name="typeNorms" class="form-control" type="radio" disabled="disabled" maxlength="200" value="0" [#if DemandManagement.typeNorms == 0]checked[/#if]>${message("admin.demandManagement.type.research")}</label>
								<label for="isTop"><input id="typeNorms2" name="typeNorms" class="form-control" type="radio" disabled="disabled" maxlength="200" value="1" [#if DemandManagement.typeNorms == 1]checked[/#if]>${message("admin.demandManagement.type.purchase")}</label>
							</div>
						</div>
						<!--需求数量-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.demandManagement.number")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="number" readonly="readonly" name="number" value="${DemandManagement.number}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<!--质量等级-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.demandManagement.grade")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="weight" readonly="readonly" name="weight" class="form-control" value="${DemandManagement.weight}" type="text" maxlength="200">
							</div>
						</div>
						<!--需求方-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.demandManagement.demandUser")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="demandUser" readonly="readonly" name="demandUser" value="${DemandManagement.demandUser}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<!--需求简介-->
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="seoDescription">${message("admin.demandManagement.productDescribe")}:</label>
							<div class="col-xs-9 col-sm-4">
								<textarea id="synopsis" name="synopsis" readonly class="form-control" row="4" >${DemandManagement.synopsis}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("admin.demandManagement.productneirong")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="introduction" readonly="readonly" style="display:none;" id="ueditorHtml">${DemandManagement.introduction}</textarea>
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