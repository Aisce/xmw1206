<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("member.register.title")} - 北京芯梦国际科技有限公司</title>
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
				var $captchaImage1 = $("[data-toggle='captchaImage1']")
				var $agree = $("#agree");
				var $submit = $("#registerForm button:submit");
				var $openSendModal = $("#openSendModal");
				var $sendMobileCode = $("#sendMobileCode");
				var $captcha1=$("#captcha1");
				
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
							successRedirectUrl: "${base}/member/register/success"
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
					$captchaImage1.captchaImage("refresh");
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
					var param = {"mobile":mobile,"mobilecodeId":mobilecodeId,"captchaId":$("input[name=captchaId]").val(),"captcha":$captcha1.val()};
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
			<div id="sendModal" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">${message("member.register.mobileSendTip")}</h5>
							</div>
							<div class="modal-body form-horizontal">
								<div class="form-group">
									<label class="col-xs-3 control-label">${message("common.captcha.name")}:</label>
									<div class="col-xs-9 col-sm-7">
										<div class="input-group">
											<input id="captcha1" class="captcha form-control" type="text" maxlength="4" autocomplete="off">
											<div class="input-group-btn">
												<img class="captcha-image" src="${base}/resources/common/images/transparent.png" title="${message("common.captcha.imageTitle")}" data-toggle="captchaImage1">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" id="sendMobileCode">${message("common.ok")}</button>
								<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
							</div>
						</div>
					</div>
			</div>
			<form id="registerForm" class="form-horizontal" action="${base}/member/register/submit" method="post">
				<input name="socialUserId" type="hidden" value="${socialUserId}">
				<input name="uniqueId" type="hidden" value="${uniqueId}">
				<input name="spreadMemberUsername" type="hidden">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title">
							<h1 class="text-red">
								[#if socialUserId?has_content && uniqueId?has_content]
									${message("member.register.bind")}
									<small>REGISTER BIND</small>
								[#else]
									${message("member.register.title")}
									<small>USER REGISTER</small>
								[/#if]
							</h1>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-8">
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="username">${message("member.register.username")}:</label>
									<div class="col-xs-8">
										<input id="username" name="username" class="form-control" type="text" maxlength="20" autocomplete="off">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="password">${message("member.register.password")}:</label>
									<div class="col-xs-8">
										<input id="password" name="password" class="form-control" type="password" maxlength="20" autocomplete="off">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="rePassword">${message("member.register.rePassword")}:</label>
									<div class="col-xs-8">
										<input id="rePassword" name="rePassword" class="form-control" type="password" maxlength="20" autocomplete="off">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="gzxz">${message("member.register.workxz")}:</label>
									<div class="col-xs-8">
										<select id="gzxz" name="gzxz" class="selectpicker form-control">
											<option value="">${message("common.choose")}</option>
											<option value="1">${message("member.register.xz1")}</option>
											<option value="2">${message("member.register.xz2")}</option>
											<option value="3">${message("member.register.xz3")}</option>
											<option value="4">${message("member.register.xz4")}</option>
											<option value="5">${message("member.register.xz5")}</option>
											<option value="6">${message("member.register.xz6")}</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="zw">${message("member.register.workzw")}:</label>
									<div class="col-xs-8">
										<select id="zw" name="zw" class="selectpicker form-control">
											<option value="">${message("common.choose")}</option>
											<option value="1">${message("member.register.zw1")}</option>
											<option value="2">${message("member.register.zw2")}</option>
											<option value="3">${message("member.register.zw3")}</option>
											<option value="4">${message("member.register.zw4")}</option>
											<option value="5">${message("member.register.zw5")}</option>
											<option value="6">${message("member.register.zw6")}</option>
											<option value="7">${message("member.register.zw7")}</option>
											<option value="8">${message("member.register.zw8")}</option>
											<option value="9">${message("member.register.zw9")}</option>
											<option value="10">${message("member.register.zw10")}</option>
											<option value="11">${message("member.register.zw11")}</option>
											<option value="12">${message("member.register.zw12")}</option>
											<option value="13">${message("member.register.zw13")}</option>
											<option value="14">${message("member.register.zw14")}</option>
											<option value="15">${message("member.register.zw15")}</option>
											<option value="16">${message("member.register.zw16")}</option>
											<option value="17">${message("member.register.zw17")}</option>
											<option value="18">${message("member.register.zw18")}</option>
											<option value="19">${message("member.register.zw19")}</option>
											<option value="20">${message("member.register.zw20")}</option>
											<option value="21">${message("member.register.zw21")}</option>
											<option value="22">${message("member.register.zw22")}</option>
											<option value="23">${message("member.register.zw23")}</option>
											<option value="24">${message("member.register.zw24")}</option>
											<option value="25">${message("member.register.zw25")}</option>
											<option value="26">${message("member.register.zw26")}</option>
											<option value="27">${message("member.register.zw27")}</option>
											<option value="28">${message("member.register.zw28")}</option>
											<option value="29">${message("member.register.zw29")}</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label" for="field">${message("member.register.workly")}:</label>
									<div class="col-xs-8">
										<input id="field" name="field" class="form-control" type="text" maxlength="200">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="email">${message("member.register.email")}:</label>
									<div class="col-xs-8">
										<input id="email" name="email" class="form-control" type="text" maxlength="200">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="mobile">${message("member.register.mobile")}:</label>
									<div class="col-xs-8">
										<div class="input-group">
											<input id="mobile" name="mobile" class="form-control" type="text" maxlength="200">
											<div class="input-group-btn">
												<button class="btn btn-default" type="button" data-toggle="modal" data-target="#sendModal" id="openSendModal">${message("member.register.mobilesend")}</button>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label item-required" for="mobilecode">${message("member.register.mobilecode")}:</label>
									<div class="col-xs-8">
										<input type="hidden" id="mobilecodeId" name="mobilecodeId"/>
										<input id="mobilecode" name="mobilecode" class="form-control" type="text" maxlength="6" autocomplete="off">
									</div>
								</div>
								[@member_attribute_list]
									[#list memberAttributes as memberAttribute]
										<div class="form-group">
											<label class="col-xs-3 control-label[#if memberAttribute.isRequired] item-required[/#if]" for="memberAttribute_${memberAttribute.id}">${memberAttribute.name}:</label>
											[#if memberAttribute.type == "NAME" || memberAttribute.type == "ADDRESS" || memberAttribute.type == "ZIP_CODE" || memberAttribute.type == "PHONE" || memberAttribute.type == "TEXT"]
												<div class="col-xs-8">
													<input id="memberAttribute_${memberAttribute.id}" name="memberAttribute_${memberAttribute.id}" class="form-control" type="text" maxlength="200">
												</div>
											[#elseif memberAttribute.type == "GENDER"]
												<div class="col-xs-8">
													[#list genders as gender]
														<div class="radio radio-inline">
															<input id="${gender}" name="memberAttribute_${memberAttribute.id}" type="radio" value="${gender}">
															<label for="${gender}">${message("Member.Gender." + gender)}</label>
														</div>
													[/#list]
												</div>
											[#elseif memberAttribute.type == "BIRTH"]
												<div class="col-xs-8">
													<div class="input-group">
														<input name="memberAttribute_${memberAttribute.id}" class="form-control" type="text" data-provide="datetimepicker">
														<span class="input-group-addon">
															<i class="iconfont icon-calendar"></i>
														</span>
													</div>
												</div>
											[#elseif memberAttribute.type == "AREA"]
												<div class="col-xs-8">
													<div class="input-group">
														<input id="areaId" name="memberAttribute_${memberAttribute.id}" type="hidden">
													</div>
												</div>
											[#elseif memberAttribute.type == "SELECT"]
												<div class="col-xs-8">
													<select name="memberAttribute_${memberAttribute.id}" class="form-control">
														<option value="">${message("common.choose")}</option>
														[#list memberAttribute.options as option]
															<option value="${option}">${option}</option>
														[/#list]
													</select>
												</div>
											[#elseif memberAttribute.type == "CHECKBOX"]
												<div class="col-xs-8">
													[#list memberAttribute.options as option]
														<div class="checkbox checkbox-inline">
															<input id="${option}_${memberAttribute.id}" name="memberAttribute_${memberAttribute.id}" type="checkbox" value="${option}">
															<label for="${option}_${memberAttribute.id}">${option}</label>
														</div>
													[/#list]
												</div>
											[/#if]
										</div>
									[/#list]
								[/@member_attribute_list]
								[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("MEMBER_REGISTER")]
									<div class="form-group">
										<label class="col-xs-3 control-label item-required" for="captcha">${message("common.captcha.name")}:</label>
										<div class="col-xs-8">
											<div class="input-group">
												<input id="captcha" name="captcha" class="captcha form-control" type="text" maxlength="4" autocomplete="off">
												<div class="input-group-btn">
													<img class="captcha-image" src="${base}/resources/common/images/transparent.png" title="${message("common.captcha.imageTitle")}" data-toggle="captchaImage">
												</div>
											</div>
										</div>
									</div>
								[/#if]
							</div>
							<div class="col-xs-3">
								<div class="login">
									<h2>${message("member.register.loginTitle")}</h2>
									<a class="btn btn-default btn-lg btn-block" href="${base}/member/login">${message("member.register.login")}</a>
									[#if loginPlugins?has_content && !socialUserId?has_content && !uniqueId?has_content]
										<ul class="clearfix">
											[#list loginPlugins as loginPlugin]
												<li>
													<a href="${base}/social_user_login?loginPluginId=${loginPlugin.id}"[#if loginPlugin.description??] title="${loginPlugin.description}"[/#if]>
														[#if loginPlugin.logo?has_content]
															<img src="${loginPlugin.logo}" alt="${loginPlugin.displayName}">
														[#else]
															${loginPlugin.displayName}
														[/#if]
													</a>
												</li>
											[/#list]
										</ul>
									[/#if]
								</div>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="row">
							<div class="col-xs-8">
								<div class="form-group">
									<div class="col-xs-8 col-xs-offset-3">
										<div class="checkbox">
											<input id="agree" name="agree" type="checkbox" value="true" checked>
											<label for="agree">${message("member.register.agree")}</label>
											<a class="text-red" href="${base}/article/detail/14_1" target="_blank">${message("member.register.agreement")}</a>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-8 col-xs-offset-3">
										<button class="btn btn-primary btn-lg btn-block" type="submit">${message("member.register.submit")}</button>
									</div>
								</div>
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