<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("member.register.success")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-datetimepicker.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/member/css/register.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/moment.js"></script>
	<script src="${base}/resources/common/js/bootstrap-datetimepicker.js"></script>
	<script src="${base}/resources/common/js/jquery.lSelect.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/jquery.base64.js"></script>
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
				
				var $document = $(document);
				var $registerForm = $("#registerForm");
				var $spreadMemberUsername = $("input[name='spreadMemberUsername']");
				var $username = $("#username");
				var $areaId = $("#areaId");
				var $captcha = $("#captcha");
				var $mobile = $("#mobile");
				var $captchaImage = $("[data-toggle='captchaImage']");
				var $agree = $("#agree");
				var $submit = $("#registerForm button:submit");
				var $openSendModal = $("#openSendModal");
				var $sendMobileCode = $("#sendMobileCode");
				
				// 推广用户
				var spreadUser = $.getSpreadUser();
				if (spreadUser != null) {
					$spreadMemberUsername.val(spreadUser.username);
				}
				
				// 地区选择
				$areaId.lSelect({
					url: "${base}/common/area"
				});
				
				// 同意注册协议
				$agree.change(function() {
					$submit.prop("disabled", !$agree.prop("checked"));
				});
				
				// 表单验证
				$registerForm.validate({
					rules: {
						username: {
							required: true,
							minlength: 4,
							username: true,
							notAllNumber: true,
							remote: {
								url: "${base}/member/register/check_username",
								cache: false
							}
						},
						password: {
							required: true,
							minlength: 4,
							normalizer: function(value) {
								return value;
							}
						},
						rePassword: {
							required: true,
							equalTo: "#password",
							normalizer: function(value) {
								return value;
							}
						},
						gzxz: {
							required: true,
							normalizer: function(value) {
								return value;
							}
						},
						zw: {
							required: true,
							normalizer: function(value) {
								return value;
							}
						},
						email: {
							required: true,
							email: true,
							remote: {
								url: "${base}/member/register/check_email",
								cache: false
							}
						},
						mobile: {
							required: true,
							mobile: true,
							remote: {
								url: "${base}/member/register/check_mobile",
								cache: false
							}
						},
						captcha: "required"
						[@member_attribute_list]
							[#list memberAttributes as memberAttribute]
								[#if memberAttribute.isRequired || memberAttribute.pattern?has_content]
									,"memberAttribute_${memberAttribute.id}": {
										[#if memberAttribute.isRequired]
											required: true
											[#if memberAttribute.pattern?has_content],[/#if]
										[/#if]
										[#if memberAttribute.pattern?has_content]
											pattern: new RegExp("${memberAttribute.pattern}")
										[/#if]
									}
								[/#if]
							[/#list]
						[/@member_attribute_list]
						,
						mobilecode: {
							required: true,
							minlength: 5,
							maxlength: 5,
							normalizer: function(value) {
								return value;
							}
						}
					},
					messages: {
						username: {
							remote: "${message("member.register.usernameExist")}"
						},
						email: {
							remote: "${message("member.register.emailExist")}"
						},
						mobile: {
							remote: "${message("member.register.mobileExist")}"
						}
					},
					submitHandler: function(form) {
						
						$(form).ajaxSubmit({
							successMessage: false,
							successRedirectUrl: "${base}/"
						});
					}
				});
				
				// 用户注册成功
				$registerForm.on("success.shopxx.ajaxSubmit", function() {
					$document.trigger("registered.shopxx.user", [{
						type: "member",
						username: $username.val()
					}]);
				});
				
				// 验证码图片
				$registerForm.on("error.shopxx.ajaxSubmit", function() {
					$captchaImage.captchaImage("refresh");
				});
				
				// 验证码图片
				$captchaImage.on("refreshed.shopxx.captchaImage", function() {
					$captcha.val("");
				});
				
				$captcha.keydown(function(e){
					var theEvent = e || window.event;    
   					var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
					if (code == 13) {
						$sendMobileCode.click();
						if (e && e.stopPropagation)
							e.stopPropagation();
						else
							window.event.cancelBubble = true;
						return false;
					}
					return true;
				});
				// 打开输入验证码弹出层
				$openSendModal.click(function(){
					$captchaImage.captchaImage("refresh");
				});
				// 发送验证码
				$sendMobileCode.click(function(){
					$('#sendModal').modal('hide');
					var mobile = $mobile.val();
					if(mobile == null || mobile == "" || !(/^1[3|4|5|8][0-9]\d{4,8}$/.test(mobile))){
						$.bootstrapGrowl("请输入正确的手机号", { type: "warning" });
						return;
					}
					var mobilecodeId = uuid();
					$("#mobilecodeId").val(mobilecodeId);
					var param = {"mobile":mobile,"mobilecodeId":mobilecodeId,"captchaId":$("input[name=captchaId]").val(),"captcha":$captcha.val()};
					$.post("${base}/member/register/send_mobile_code", param, function(data) {
						$.bootstrapGrowl(data.message, {
							type: "success"
						});
						$openSendModal.attr('disabled','disabled');
						var count = 60;
						function resend(){
							count --;
							if(count >= 0 ){
								$openSendModal.text("重新发送("+count+")");
							}else{
								$openSendModal.removeAttr('disabled');
								$openSendModal.text("重新发送");
								count = 60;
								clearInterval(timer);
							}
						}
						var timer = 0;
						clearInterval(timer);
						timer = setInterval(resend,1000);
					});
				});
			
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="register">
	[#include "/shop/include/main_header.ftl" /]
	<main>
		<div class="container">
			<form id="registerForm" class="form-horizontal" action="${base}/member/register/submit" method="post">
				<input name="socialUserId" type="hidden" value="${socialUserId}">
				<input name="uniqueId" type="hidden" value="${uniqueId}">
				<input name="spreadMemberUsername" type="hidden">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">
							<h1 class="text-red">
								${message("member.register.success")}
								<small>REGISTER SUCCESS</small>
							</h1>
						</div>
					</div>
					<div class="panel-body">
						<div class="row" style="min-height:200px;">
							<div class="col-xs-12">
								<p style="margin-bottom:20px;">完成实名认证，获取最新优惠</p>
								<a class="btn btn-primary" href="${base}/member/realname/edit">${message("member.realname.title")}</a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>
	[#include "/shop/include/main_footer.ftl" /]
</body>
</html>