<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("addmin.updateNew")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-fileinput.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-datetimepicker.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
		<link href="${base}/resources/common/css/ajax-bootstrap-select.css" rel="stylesheet">
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
			<script src="${base}/resources/common/js/ajax-bootstrap-select.js"></script>
		<script src="${base}/resources/common/js/bootstrap-fileinput.js"></script>
	<script src="${base}/resources/common/js/moment.js"></script>
	<script src="${base}/resources/common/js/bootstrap-datetimepicker.js"></script>
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
				var $productsId=$("#productsId");
				// 商家选择
				$productsId.selectpicker({
					liveSearch: true
				}).ajaxSelectPicker({
					ajax: {
						url: "${base}/admin/new_launch/product_select",
						type: "GET",
						data: function() {
							return {
								keyword: "{{{q}}}"
							};
						},
						dataType: "json"
					},
					preprocessData: function(data) {
						return $.map(data, function(item) {
							return {
								value: item.id,
								text: item.poductname
							};
						});
					},
					preserveSelected: false
				}).change(function() {
					$articleForm.validate().element($productsId);
				});
				
				// 表单验证
				$articleForm.validate({
					rules: {
						title: "required",
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/new_launch/list"
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
				<li class="active">${message("addmin.updateNew")}</li>
			</ol>
			<form id="articleForm" class="ajax-form form-horizontal" action="${base}/admin/new_launch/update" method="post">
				<input type="hidden" name="id" id="aid" value="${newLaunch.id}"/>
				<input type="hidden" name="creatTime" id="aid" value="${newLaunch.creatTime}"/>
				<input type="hidden" name="createdDate" id="aid" value="${newLaunch.createDate}"/>
				<div class="panel panel-default">
					<div class="panel-heading">${message("addmin.updateNew")}</div>
					<div class="panel-body">
						<div class="form-group">
						<!--产品名称-->
							<label class="col-xs-3 col-sm-2 control-label item-required" for="title">${message("admin.cpName")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="title" name="name" value="${newLaunch.name}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
						<!--型号规格-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("addmin.typeNorms")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="typeNorms" name="typeNorms" value="${newLaunch.typeNorms}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
						<!--产品编号-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.productCode")}:</label>
							<div class="col-xs-9 col-sm-4">
								<select id="productsId" name="productsId" class="selectpicker form-control" data-size="10" title="${newLaunch.productId.name}">
									<option value="${newLaunch.productId.id}" title="${newLaunch.productId.name}" selected="selected">${newLaunch.productId.name}</option>
								</select>
							</div>
						</div>
						<div class="form-group">
						<!--生产厂商-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.scfirm")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="unit" name="unit" value="${newLaunch.unit}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required">${message("addmin.Image")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="productImages" name="productImages" type="hidden" data-provide="fileinput" data-file-type="IMAGE" value="${newLaunch.productImages}" data-provide="fileinput" data-file-type="IMAGE">
							</div>
						</div>
						<div class="form-group">
						<!--质量等级-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("addmin.weight")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="weight" name="weight" value="${newLaunch.weight}" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
						<!--定型时间-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("addmin.StereotypeTime")}:</label>
							<div class="col-xs-9 col-sm-4">
								<div class='input-group'>
									<input type='text' name="stereotypeTime" id="endTime" class="form-control" data-provide="datetimepicker" data-date-format="YYYY" value="[#if newLaunch.stereotypeTime??]${newLaunch.stereotypeTime?string("YYYY")}[/#if]"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("common.setting")}:</label>
							<div class="col-xs-9 col-sm-4">
								<div class="checkbox checkbox-inline">
									<input name="_releaseFlag" type="hidden" value="0">
									<input id="isPublication" name="releaseFlag" type="checkbox" value="1" [#if newLaunch.releaseFlag == "1"] checked[/#if]>
									<label for="isPublication">${message("addmin.releaseFlag")}</label>
								</div>
								<!--<div class="checkbox checkbox-inline">
									<input name="_isTop" type="hidden" value="flase">
									<input id="isTop" name="isTop" type="checkbox" value="true" [#if newLaunch.isTop] checked[/#if]>
									<label for="isTop">${message("addmin.isTop")}</label>
								</div>-->
							</div>
						</div>
						<div class="form-group">
						<!--新品简介-->
							<label class="col-xs-3 col-sm-2 control-label" for="title">${message("admin.newlaunch.synopsis")}:</label>
							<div class="col-xs-9 col-sm-4">
								<textarea id="synopsis" name="synopsis" class="form-control" type="text" maxlength="200" rows="8">${newLaunch.synopsis}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("addmin.introduction")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="introduction" style="display:none;" id="ueditorHtml">${newLaunch.introduction}</textarea>
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