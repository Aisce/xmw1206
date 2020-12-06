<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("member.profile.edit")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-datetimepicker.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-fileinput.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/member/css/base.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/moment.js"></script>
	<script src="${base}/resources/common/js/bootstrap-datetimepicker.js"></script>
	<script src="${base}/resources/common/js/bootstrap-fileinput.js"></script>
	<script src="${base}/resources/common/js/jquery.lSelect.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/member/js/base.js"></script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				
				var $profileForm = $("#profileForm");
				
				// 表单验证
				$profileForm.validate({
					rules: {
						name:"required",
						idcard:{
							required: true,
							minlength: 16,
							maxlength: 18
						},
						idcard1: "required",
						idcard2: "required",
						idcard3: "required"
					},
					submitHandler: function(form) {
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/member/realname/edit"
						});
					}
				});
			
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="member">
	[#include "/shop/include/main_header.ftl" /]
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					[#include "/member/include/main_menu.ftl" /]
				</div>
				<div class="col-xs-10">
					<form id="profileForm" class="ajax-form form-horizontal" action="${base}/member/realname/update" method="post">
						<div class="panel panel-default">
							<div class="panel-heading">${message("member.realname.title")} 
							[#if currentUser.attestationFlag == "REAL"]
								<span style='color:green;'>已实名认证成功</span>
							[/#if]
							</div>
							<div class="panel-body">
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Member.username")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">${currentUser.username}</p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Member.mobile")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">
										${currentUser.mobile ? replace(currentUser.mobile ? substring(3,currentUser.mobile ? length-4),"****")}
										</p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Member.name")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">${currentUser.fullname}</p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Member.idcard")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">
										${currentUser.idcard ? replace(currentUser.idcard ? substring(4,currentUser.idcard ? length-4),"**********")}
										</p>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>