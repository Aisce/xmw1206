<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.memberReal.realname")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/zoom.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/admin/css/base.css" rel="stylesheet">
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
	<script src="${base}/resources/admin/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				var $profileForm = $("#profileForm");
				var $confirmFailBtn = $("#confirmFailBtn");
				var $failContent = $("#failContent");
				$profileForm.find("button.btn-primary.submit").click(function(){
					$profileForm.find("input[name=status]").val("REAL");
					$profileForm.ajaxSubmit({
						successRedirectUrl: "${base}/admin/member_real/list"
					});
				});
				$profileForm.find("button.btn-danger.submit").click(function(){
					//$profileForm.find("input[name=status]").val("FAIL");
					//$profileForm.ajaxSubmit({
					//	successRedirectUrl: "${base}/admin/member_real/list"
					//});
				});
				$confirmFailBtn.click(function(){
					var failContent = $failContent.val();
					if(failContent == null || failContent == ""){
						$.bootstrapGrowl("请输入认证失败理由", { type: "warning" });
						return;
					}
					$('#failModal').modal('hide');
					$profileForm.find("input[name=status]").val("FAIL");
					$profileForm.ajaxSubmit({
						successRedirectUrl: "${base}/admin/member_real/list"
					});
				});
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
				<li class="active">${message("admin.memberReal.realname")}</li>
			</ol>
			<form id="profileForm" class="ajax-form form-horizontal" action="${base}/admin/member_real/update" method="post">
				<input name="id" type="hidden" value="${member.id}">
				<input name="status" type="hidden" value="">
				<div id="failModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">${message("admin.memberReal.reasonTitle")}</h5>
							</div>
							<div class="modal-body form-horizontal">
								<div class="form-group">
									<label class="col-xs-2 control-label">${message("admin.memberReal.reason")}:</label>
									<div class="col-xs-10 col-sm-7">
										<div class="input-group">
											<textarea id="failContent" name="failContent" rows="8" cols="60"></textarea>
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
				<div class="panel panel-default">
					<div class="panel-heading">${message("admin.memberReal.realname")}</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<dl class="items dl-horizontal">
									<dt>${message("Member.username")}:</dt>
									<dd>${member.username}</dd>
									<dt>${message("Member.mobile")}:</dt>
									<dd>${member.mobile}</dd>
									<dt>${message("common.createdDate")}:</dt>
									<dd>${member.createdDate?string("yyyy-MM-dd HH:mm:ss")}</dd>
									<dt>${message("User.lastLoginIp")}:</dt>
									<dd>${member.lastLoginIp!"-"}</dd>
									<dt>${message("User.lastLoginDate")}:</dt>
									<dd>${(member.lastLoginDate?string("yyyy-MM-dd HH:mm:ss"))!"-"}</dd>
									<dt>${message("Member.name")}:</dt>
									<!--<dd>${member.attributeValue3}</dd>-->
									<dd>${member.name}</dd>
									<dt>${message("Member.idcard")}:</dt>
									<!--<dd>${member.attributeValue4}</dd>-->
									<dd>${member.idcard}</dd>
									<dt>${message("Member.unitName")}</dt>
									<dd>${member.unitName}</dd>
									<dt>${message("Member.unitAddress")}</dt>
									<dd>${member.unitAddress}</dd>
									<dt>${message("Member.idcard1")}:</dt>
									<dd><img class="img-thumbnail" src="${member.photo1}" alt="${message("Member.idcard1")}" width="50" data-action="zoom"></dd>
									<dt>${message("Member.idcard2")}:</dt>
									<dd><img class="img-thumbnail" src="${member.photo2}" alt="${message("Member.idcard1")}" width="50" data-action="zoom"></dd>
									<dt>${message("Member.idcard3")}:</dt>
									<dd><img class="img-thumbnail" src="${member.photo3}" alt="${message("Member.idcard1")}" width="50" data-action="zoom"></dd>
								</dl>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
								<button class="btn btn-primary submit" type="button">${message("Member.idcard.real")}</button>
								<button class="btn btn-danger submit" type="button" data-toggle="modal" data-target="#failModal" >${message("Member.idcard.fail")}</button>
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