<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.wiki.add")} - 北京芯梦国际科技有限公司</title>
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
			
				var $wikiForm = $("#wikiForm");
				
				// 表单验证
				$wikiForm.validate({
					rules: {
						title: "required",
						wikiCategoryId: "required"
					},
					submitHandler: function(form) {
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/admin/wiki/list"
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
				<li class="active">${message("admin.wiki.add")}</li>
			</ol>
			<form id="wikiForm" class="ajax-form form-horizontal" action="${base}/admin/wiki/save" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.wiki.add")}</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required" for="title">${message("Wiki.title")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="title" name="title" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required">${message("Wiki.wikiCategory")}:</label>
							<div class="col-xs-9 col-sm-4">
								<select name="wikiCategoryId" class="selectpicker form-control" data-size="10">
									[#list wikiCategoryTree as wikiCategory]
										<option value="${wikiCategory.id}" title="${wikiCategory.name}">
											[#if wikiCategory.grade != 0]
												[#list 1..wikiCategory.grade as i]
													&nbsp;&nbsp;
												[/#list]
											[/#if]
											${wikiCategory.name}
										</option>
									[/#list]
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="author">${message("Wiki.author")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="author" name="author" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("common.setting")}:</label>
							<div class="col-xs-9 col-sm-4">
								<div class="checkbox checkbox-inline">
									<input name="_isPublication" type="hidden" value="false">
									<input id="isPublication" name="isPublication" type="checkbox" value="true" checked>
									<label for="isPublication">${message("Wiki.isPublication")}</label>
								</div>
								<div class="checkbox checkbox-inline">
									<input name="_isTop" type="hidden" value="false">
									<input id="isTop" name="isTop" type="checkbox" value="true">
									<label for="isTop">${message("Wiki.isTop")}</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Wiki.wikiTags")}:</label>
							<div class="col-xs-9 col-sm-10">
								[#list wikiTags as wikiTag]
									<div class="checkbox checkbox-inline">
										<input id="wikiTag_${wikiTag.id}" name="wikiTagIds" type="checkbox" value="${wikiTag.id}">
										<label for="wikiTag_${wikiTag.id}">${wikiTag.name}</label>
									</div>
								[/#list]
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label">${message("Wiki.content")}:</label>
							<div class="col-xs-9 col-sm-10">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="content" style="display:none;" id="ueditorHtml"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="seoTitle">${message("Wiki.seoTitle")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="seoTitle" name="seoTitle" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="seoKeywords">${message("Wiki.seoKeywords")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="seoKeywords" name="seoKeywords" class="form-control" type="text" maxlength="200">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label" for="seoDescription">${message("Wiki.seoDescription")}:</label>
							<div class="col-xs-9 col-sm-4">
								<input id="seoDescription" name="seoDescription" class="form-control" type="text" maxlength="200">
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