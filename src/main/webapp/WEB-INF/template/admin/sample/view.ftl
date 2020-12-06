<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("admin.order.view")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
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
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/admin/js/base.js"></script>
	<script id="transitStepTemplate" type="text/template">
		<%if (_.isEmpty(data.transitSteps)) {%>
			<p class="text-gray">${message("admin.order.noResult")}</p>
		<%} else {%>
			<div class="list-group">
				<%_.each(data.transitSteps, function(transitStep, i) {%>
					<div class="list-group-item">
						<p class="text-gray"><%-transitStep.time%></p>
						<p><%-transitStep.context%></p>
					</div>
				<%});%>
			</div>
		<%}%>
	</script>
</head>
<body class="admin">
	[#include "/admin/include/main_header.ftl" /]
	[#include "/admin/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			<div id="transitStepModal" class="transit-step-modal modal fade" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button class="close" type="button" data-dismiss="modal">&times;</button>
							<h5 class="modal-title">${message("admin.order.transitStep")}</h5>
						</div>
						<div class="modal-body"></div>
						<div class="modal-footer">
							<button class="btn btn-default" type="button" data-dismiss="modal">${message("common.cancel")}</button>
						</div>
					</div>
				</div>
			</div>
			<ol class="breadcrumb">
				<li>
					<a href="${base}/admin/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">${message("admin.order.view")}</li>
			</ol>
			<div class="panel panel-default">
				<div class="panel-body">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#orderInfo" data-toggle="tab">索取样片信息</a>
						</li>
					</ul>
					<div class="tab-content">
						<div id="orderInfo" class="tab-pane active">
							<div class="row">
								<div class="col-xs-12 col-sm-6">
									<dl class="items dl-horizontal">
										<dt>${message("admin.sample.sqr")}:</dt>
										<dd>${find.applyUser}</dd>
										<dt>${message("admin.sample.sqdw")}:</dt>
										<dd>${find.applyCompany}</dd>
										<dt>${message("admin.sample.yycp")}:</dt>
										<dd>
											${find.applicationProduct}
										</dd>
										<dt>${message("admin.sample.yybj")}:</dt>
										<dd>${find.applicationBackground}</dd>
										<dt>${message("admin.sample.ypsl")}:</dt>
										<dd>${find.sampleNumber}</dd>
										<dt>${message("admin.sample.address")}:</dt>
										<dd>${find.address}</dd>
										<dt>${message("admin.sample.phone")}:</dt>
										<dd>${find.phone}</dd>
										<dt>${message("admin.sample.zt")}:</dt>
										<dd>${find.flag}</dd>
										<dt>${message("OrderItem.sn")}:</dt>
										<dd>${find.product.sn}</dd>
										<dt>${message("OrderItem.name")}:</dt>
										<dd>${find.product.name}</dd>
										
										[#if find.flag == '1']
											<dt>${message("admin.sample.code")}:</dt>
											<dd>${find.orderNubmer}</dd>
											<dt>${message("admin.sample.gs")}:</dt>
											<dd>${find.kuaidiCompany}</dd>
										[#elseif find.flag == '2']
											<dt>${message("admin.sample.ly")}:</dt>
											<dd>${find.reason}</dd>
										[/#if]
									</dl>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-footer">
					<div class="row">
						<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
							<button class="btn btn-default" type="button" data-action="back">${message("common.back")}</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>