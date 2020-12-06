<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>提交审核 - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/ajax-bootstrap-select.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-fileinput.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/business/css/base.css" rel="stylesheet">
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
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/business/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
			
				var $storeForm = $("#storeForm");
				var $businessId = $("#mechanismId");
				var $bzmechanismId=$("#bzmechanismId");
				
				// 商家选择
				$businessId.selectpicker({
					liveSearch: true
				}).ajaxSelectPicker({
					ajax: {
						url: "${base}/business/product/mechanismStore_select",
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
								text: item.username
							};
						});
					},
					preserveSelected: false
				}).change(function() {
					$storeForm.validate().element($businessId);
				});
				
				// 商家选择
				$bzmechanismId.selectpicker({
					liveSearch: true
				}).ajaxSelectPicker({
					ajax: {
						url: "${base}/business/product/mechanismStore_select1",
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
								text: item.username
							};
						});
					},
					preserveSelected: false
				}).change(function() {
					$storeForm.validate().element($businessId);
				});
				
				// 表单验证
				$storeForm.validate({
					rules: {
					},
					messages: {
						name: {
							remote: "${message("common.validator.exist")}"
						}
					}
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
					<a href="${base}/admin/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("admin.mechanismStore.add")}</li>
			</ol>
			<form id="storeForm" class="ajax-form form-horizontal" action="${base}/business/product/review" method="post">
				<input type="hidden" value="${find.id}" id="ids" name="id"/>
				<div class="panel panel-default">
					<div class="panel-heading">提交审核</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required">检测机构:</label>
							<div class="col-xs-9 col-sm-4">
								<select id="mechanismId" name="mechanismId" class="form-control" title="${message("admin.mechanismStore.mechanismTitle")}"></select>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-xs-3 col-sm-2 control-label item-required">标准化机构:</label>
							<div class="col-xs-9 col-sm-4">
								<select id="bzmechanismId" name="bzmechanismId" class="form-control" title="${message("admin.mechanismStore.mechanismTitle")}"></select>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
								<button class="btn btn-primary" type="submit">提交认证</button>
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