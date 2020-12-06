<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("business.product.add")} - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
	<link href="${base}/resources/common/css/bootstrap-select.css" rel="stylesheet">
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
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/bootstrap-select.js"></script>
	<script src="${base}/resources/common/js/sortable.js"></script>
	<script src="${base}/resources/common/js/bootstrap-fileinput.js"></script>
	<script src="${base}/resources/common/js/jquery.nicescroll.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.js"></script>
	<script src="${base}/resources/common/js/jquery.validate.additional.js"></script>
	<script src="${base}/resources/common/js/jquery.form.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/business/js/base.js"></script>
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
	<style>
		.table tbody tr td {
			vertical-align: top;
		}
	</style>
	
	<script>
			$().ready(function() {
				[#if findList?? && (findList?size>0)]
					$(".file-caption-name").attr("readonly",false);
					$("input:file").attr("disabled",false);
				[#else]
					$(".file-caption-name").attr("readonly",true);
					$("input:file").attr("disabled","disabled");
				[/#if]
				var $productForm = $("#productForm");
				var $hostFileBatchFile = $("#hostFileBatch input:file");
				// 表单验证
				$productForm.validate({
					rules: {
						filePath: "required"
					},
					submitHandler: function(form) {
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/business/product/list"
						});
					}
				});
			});
			function overlap(){
				if(window.confirm("强制覆盖无法恢复！！！")){
					
					$("#flag").val("1");
					 $.ajax({
		                type: "POST",//方法类型
		                dataType: "json",//预期服务器返回的数据类型
		                url: "${base}/business/import/importExcel",
		                data: $('#productForm').serialize(),
		                success: function (result) {
		                	location.reload(true)   
		                },
		                error : function(){
		                }
		            });
	  			}
			}
			</script>
</head>
<body class="business">
	[#include "/business/include/main_header.ftl" /]
	[#include "/business/include/main_sidebar.ftl" /]
	<main>
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li>
					<a href="${base}/business/index">
						<i class="iconfont icon-homefill"></i>
						${message("common.breadcrumb.index")}
					</a>
				</li>
				<li class="active">导入excel文件</li>
			</ol>
			<form id="productForm" class="form-horizontal" action="${base}/business/import/importExcel" method="post" enctype="multipart/form-data">
				<input type="hidden" id="flag" name="flag" value=""/>
				<div class="form-group">
					<label class="col-xs-3 col-sm-2 control-label item-required">上传数据包:</label>
					<div class="col-xs-9 col-sm-4">
						<input id="img" name="hostFileBatch" type="hidden" data-provide="fileinput" data-file-type="LQFILE" data-show-preview = "false">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-9 col-sm-10 col-xs-offset-3 col-sm-offset-2">
						[#if findList?? && (findList?size>0)]
							<button class="btn btn-primary" type="submit">导入数据</button>
							<button class="btn btn-default" type="button" onclick = "overlap()">强制覆盖导入数据</button>
						[#else]
							<button class="btn btn-primary" type="button">导入数据</button>
							<button class="btn btn-default" type="button" >强制覆盖导入数据</button>
						[/#if]
					</div>
				</div>
				</div>
			</form>
			<div>
				[#if findList?? && (findList?size>0)]
				[#else]
					<i style="font-size:17px;color: #d9534f;font-weight: bold;">请申请经营分类后重新导入数据，如已申请请联系管理员</i>
				[/#if]
				
			
			</div>
			<form action="" method="get">
				<input name="pageSize" type="hidden" value="${page.pageSize}">
				<input name="searchProperty" type="hidden" value="${page.searchProperty}">
				<input name="orderProperty" type="hidden" value="${page.orderProperty}">
				<input name="orderDirection" type="hidden" value="${page.orderDirection}">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>
											<div class="checkbox">
												<input type="checkbox" data-toggle="checkAll">
												<label></label>
											</div>
										</th>
										<th>
											<a href="javascript:;" data-order-property="fileUrl">
												${message("business.uploadLog.fileUrl")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="uploadUser">
												${message("business.uploadLog.uploadUser")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="fileFlag">
												${message("business.uploadLog.fileFlag")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
										<th>
											<a href="javascript:;" data-order-property="createdDate">
												${message("business.uploadLog.createdDate")}
												<i class="iconfont icon-biaotou-kepaixu"></i>
											</a>
										</th>
									</tr>
								</thead>
								[#if page.content?has_content]
									<tbody>
										[#list page.content as uploadLog]
											<tr>
												<td>
													<div class="checkbox">
														<input name="ids" type="checkbox" value="${launch.id}">
														<label></label>
													</div>
												</td>
												<td>${uploadLog.fileUrl}</td>
												<td>${uploadLog.uploadUser.username}</td>
												
												[#if uploadLog.fileFlag == "0"]
													<td>批量导入中</td>
												[#elseif uploadLog.fileFlag == "1"]
													<td>导入成功</td>
												[#else]
													<td>导入失败</td>
												[/#if]
												<td>
													<span title="${uploadLog.createdDate?string("yyyy-MM-dd HH:mm:ss")}" data-toggle="tooltip">${uploadLog.createdDate?string("yyyy-MM-dd HH:mm:ss")}</span>
												</td>
											</tr>
										[/#list]
									</tbody>
								[/#if]
							</table>
							[#if !page.content?has_content]
								<p class="no-result">${message("common.noResult")}</p>
							[/#if]
						</div>
					</div>
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
						[#if totalPages > 1]
							<div class="panel-footer text-right">
								[#include "/admin/include/pagination.ftl" /]
							</div>
						[/#if]
					[/@pagination]
				</div>
			</form>
		</div>
	</main>
</body>
</html>