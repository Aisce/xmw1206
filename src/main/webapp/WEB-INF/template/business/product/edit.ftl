<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>${message("business.product.edit")} - 北京芯梦国际科技有限公司</title>
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
	<script id="productImageInputTemplate" type="text/template">
		<input name="productImages[<%-productImageIndex%>].source" type="hidden" value="<%-productImage.source%>">
		<input name="productImages[<%-productImageIndex%>].large" type="hidden" value="<%-productImage.large%>">
		<input name="productImages[<%-productImageIndex%>].medium" type="hidden" value="<%-productImage.medium%>">
		<input name="productImages[<%-productImageIndex%>].thumbnail" type="hidden" value="<%-productImage.thumbnail%>">
		<input name="productImages[<%-productImageIndex%>].order" type="hidden" value="<%-productImage.order%>">
	</script>
	<script id="dxyydlImageInputTemplate" type="text/template">
		<input name="dxyydlImages[<%-dxyydlImageIndex%>].source" type="hidden" value="<%-dxyydlImage.source%>">
		<input name="dxyydlImages[<%-dxyydlImageIndex%>].large" type="hidden" value="<%-dxyydlImage.large%>">
		<input name="dxyydlImages[<%-dxyydlImageIndex%>].medium" type="hidden" value="<%-dxyydlImage.medium%>">
		<input name="dxyydlImages[<%-dxyydlImageIndex%>].thumbnail" type="hidden" value="<%-dxyydlImage.thumbnail%>">
		<input name="dxyydlImages[<%-dxyydlImageIndex%>].order" type="hidden" value="<%-dxyydlImage.order%>">
	</script>
	<script id="kkxsybgFileInputTemplate" type="text/template">
		<input name="kkxsybgFiles[<%-kkxsybgFileIndex%>].source" type="hidden" value="<%-kkxsybgFile.source%>">
		<input name="kkxsybgFiles[<%-kkxsybgFileIndex%>].order" type="hidden" value="<%-kkxsybgFile.order%>">
	</script>
	<script id="addParameterGroupTemplate" type="text/template">
		<div class="item" data-parameter-index="<%-parameterIndex%>">
			<div class="form-group">
				<div class="col-xs-3 col-sm-1 col-sm-offset-1 text-right">
					<p class="form-control-static">${message("Parameter.group")}:</p>
				</div>
				<div class="col-xs-6 col-sm-4">
					<input name="parameterValues[<%-parameterIndex%>].group" class="parameter-group form-control" type="text" maxlength="200">
				</div>
				<div class="col-xs-3 col-sm-6">
					<p class="form-control-static">
						<a class="remove group" href="javascript:;">[${message("common.delete")}]</a>
						<a class="add" href="javascript:;">[${message("common.add")}]</a>
					</p>
				</div>
			</div>
			<div class="form-group">
				<div class="col-xs-3 col-sm-1 col-sm-offset-1">
					<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].name" class="parameter-entry-name form-control text-right" type="text" maxlength="200">
				</div>
				<div class="col-xs-6 col-sm-4">
					<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].value" class="parameter-entry-value form-control" type="text" maxlength="200">
				</div>
				<div class="col-xs-3 col-sm-6">
					<p class="form-control-static">
						<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
					</p>
				</div>
			</div>
		</div>
	</script>
	<script id="addDxncsParamTitleTemplate" type="text/template">
		<div class="form-group">
			<div class="col-sm-1 col-sm-offset-2">参数名称</div>
			<div class="col-sm-1">最小值</div>
			<div class="col-sm-1">额定值</div>
			<div class="col-sm-1">最大值</div>
			<div class="col-sm-1">单位</div>
		</div>
	</script>
	<script id="addDxncsParamTemplate" type="text/template">
		<div class="form-group item">
			<div class="col-sm-1 col-sm-offset-2">
				<input name="dxncsParams[<%-dxncsParamIndex%>].name" class="form-control" type="text" maxlength="200" value="<%-dxncsParam.name%>">
			</div>
			<div class="col-sm-1">
				<input name="dxncsParams[<%-dxncsParamIndex%>].min" class="form-control" type="text" maxlength="200" value="<%-dxncsParam.min%>">
			</div>
			<div class="col-sm-1">
				<input name="dxncsParams[<%-dxncsParamIndex%>].typ" class="form-control" type="text" maxlength="200" value="<%-dxncsParam.typ%>">
			</div>
			<div class="col-sm-1">
				<input name="dxncsParams[<%-dxncsParamIndex%>].max" class="form-control" type="text" maxlength="200" value="<%-dxncsParam.max%>">
			</div>
			<div class="col-sm-1">
				<input name="dxncsParams[<%-dxncsParamIndex%>].unit" class="form-control" type="text" maxlength="200" value="<%-dxncsParam.unit%>">
			</div>
			<div class="col-sm-1">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	<script id="addQthjzbParamTitleTemplate" type="text/template">
		<div class="form-group">
			<div class="col-sm-1 col-sm-offset-2">参数名称</div>
			<div class="col-sm-1">最小值</div>
			<div class="col-sm-1">额定值</div>
			<div class="col-sm-1">最大值</div>
			<div class="col-sm-1">单位</div>
		</div>
	</script>
	<script id="addQthjzbParamTemplate" type="text/template">
		<div class="form-group item">
			<div class="col-sm-1 col-sm-offset-2">
				<input name="qthjzbParams[<%-qthjzbParamIndex%>].name" class="form-control" type="text" maxlength="200" value="<%-qthjzbParam.name%>">
			</div>
			<div class="col-sm-1">
				<input name="qthjzbParams[<%-qthjzbParamIndex%>].value2" class="form-control" type="text" maxlength="200" value="<%-qthjzbParam.value2%>">
			</div>
			<div class="col-sm-1">
				<input name="qthjzbParams[<%-qthjzbParamIndex%>].value1" class="form-control" type="text" maxlength="200" value="<%-qthjzbParam.value1%>">
			</div>
			<div class="col-sm-1">
				<input name="qthjzbParams[<%-qthjzbParamIndex%>].value3" class="form-control" type="text" maxlength="200" value="<%-qthjzbParam.value3%>">
			</div>
			<div class="col-sm-1">
				<input name="qthjzbParams[<%-qthjzbParamIndex%>].unit" class="form-control" type="text" maxlength="200" value="<%-qthjzbParam.unit%>">
			</div>
			<div class="col-sm-1">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	<script id="addCsjdzdParamTitleTemplate" type="text/template">
		<div class="form-group">
			<div class="col-sm-1 col-sm-offset-2">参数名称</div>
			<div class="col-sm-1">最小值</div>
			<div class="col-sm-1">额定值</div>
			<div class="col-sm-1">最大值</div>
			<div class="col-sm-1">单位</div>
		</div>
	</script>
	<script id="addCsjdzdParamTemplate" type="text/template">
		<div class="form-group item">
			<div class="col-sm-1 col-sm-offset-2">
				<input name="csjdzdParams[<%-csjdzdParamIndex%>].name" class="form-control" type="text" maxlength="200" value="<%-csjdzdParam.name%>">
			</div>
			<div class="col-sm-1">
				<input name="csjdzdParams[<%-csjdzdParamIndex%>].value2" class="form-control" type="text" maxlength="200" value="<%-csjdzdParam.value2%>">
			</div>
			<div class="col-sm-1">
				<input name="csjdzdParams[<%-csjdzdParamIndex%>].value1" class="form-control" type="text" maxlength="200" value="<%-csjdzdParam.value1%>">
			</div>
			<div class="col-sm-1">
				<input name="csjdzdParams[<%-csjdzdParamIndex%>].value3" class="form-control" type="text" maxlength="200" value="<%-csjdzdParam.value3%>">
			</div>
			<div class="col-sm-1">
				<input name="csjdzdParams[<%-csjdzdParamIndex%>].unit" class="form-control" type="text" maxlength="200" value="<%-csjdzdParam.unit%>">
			</div>
			<div class="col-sm-1">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	<script id="addTjgzcsParamTitleTemplate" type="text/template">
		<div class="form-group">
			<div class="col-sm-1 col-sm-offset-2">参数名称</div>
			<div class="col-sm-1">最小值</div>
			<div class="col-sm-1">额定值</div>
			<div class="col-sm-1">最大值</div>
			<div class="col-sm-1">单位</div>
		</div>
	</script>
	<script id="addTjgzcsParamTemplate" type="text/template">
		<div class="form-group item">
			<div class="col-sm-1 col-sm-offset-2">
				<input name="tjgzcsParams[<%-tjgzcsParamIndex%>].name" class="form-control" type="text" maxlength="200" value="<%-tjgzcsParam.name%>">
			</div>
			<div class="col-sm-1">
				<input name="tjgzcsParams[<%-tjgzcsParamIndex%>].value2" class="form-control" type="text" maxlength="200" value="<%-tjgzcsParam.value2%>">
			</div>
			<div class="col-sm-1">
				<input name="tjgzcsParams[<%-tjgzcsParamIndex%>].value1" class="form-control" type="text" maxlength="200" value="<%-tjgzcsParam.value1%>">
			</div>
			<div class="col-sm-1">
				<input name="tjgzcsParams[<%-tjgzcsParamIndex%>].value3" class="form-control" type="text" maxlength="200" value="<%-tjgzcsParam.value3%>">
			</div>
			<div class="col-sm-1">
				<input name="tjgzcsParams[<%-tjgzcsParamIndex%>].unit" class="form-control" type="text" maxlength="200" value="<%-tjgzcsParam.unit%>">
			</div>
			<div class="col-sm-1">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	
	<script id="addJrgwParamTitleTemplate" type="text/template">
		<div class="form-group">
			<div class="col-sm-1 col-sm-offset-2">型号</div>
			<div class="col-sm-3">生产厂家</div>
		</div>
	</script>
	<script id="addJrgwParamTemplate" type="text/template">
		<div class="form-group item">
			<div class="col-sm-1 col-sm-offset-2">
				<input name="jrgwParams[<%-jrgwParamIndex%>].name" class="form-control" type="text" maxlength="200" value="<%-jrgwParam.name%>">
			</div>
			<div class="col-sm-1">
				<input name="jrgwParams[<%-jrgwParamIndex%>].value1" class="form-control" type="text" maxlength="200" value="<%-jrgwParam.value1%>">
			</div>
			<div class="col-sm-1">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	<script id="addParameterTemplate" type="text/template">
		<div class="form-group">
			<div class="col-xs-3 col-sm-1 col-sm-offset-1">
				<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].name" class="parameter-entry-name form-control" type="text" maxlength="200">
			</div>
			<div class="col-xs-6 col-sm-4">
				<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].value" class="parameter-entry-value form-control" type="text" maxlength="200">
			</div>
			<div class="col-xs-3 col-sm-6">
				<p class="form-control-static">
					<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
				</p>
			</div>
		</div>
	</script>
	<script id="parameterGroupTemplate" type="text/template">
		<%_.each(parameters, function(parameter, i) {%>
			<div class="item" data-parameter-index="<%-parameterIndex%>">
				<div class="form-group">
					<div class="col-xs-3 col-sm-1 col-sm-offset-1 text-right">
						<p class="form-control-static">${message("Parameter.group")}:</p>
					</div>
					<div class="col-xs-6 col-sm-4">
						<input name="parameterValues[<%-parameterIndex%>].group" class="parameter-group form-control" type="text" value="<%-parameter.group%>" maxlength="200">
					</div>
					<div class="col-xs-3 col-sm-6">
						<p class="form-control-static">
							<a class="remove group" href="javascript:;">[${message("common.delete")}]</a>
							<a class="add" href="javascript:;">[${message("common.add")}]</a>
						</p>
					</div>
				</div>
				<%var parameterEntryIndex = 0%>
				<%_.each(parameter.names, function(name, i) {%>
					<div class="form-group">
						<div class="col-xs-3 col-sm-1 col-sm-offset-1">
							<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].name" class="parameter-entry-name form-control text-right" type="text" value="<%-name%>" maxlength="200">
						</div>
						<div class="col-xs-6 col-sm-4">
							<input name="parameterValues[<%-parameterIndex%>].entries[<%-parameterEntryIndex%>].value" class="parameter-entry-value form-control" type="text" maxlength="200">
						</div>
						<div class="col-xs-3 col-sm-6">
							<p class="form-control-static">
								<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
							</p>
						</div>
					</div>
					<%parameterEntryIndex ++%>
				<%});%>
				<%parameterIndex ++%>
			</div>
		<%});%>
	</script>
	<script id="attributeTemplate" type="text/template">
		<%_.each(attributes, function(attribute, i) {%>
			<div class="form-group">
				<label class="col-xs-3 col-sm-2 control-label"><%-attribute.name%>:</label>
				<div class="col-xs-9 col-sm-4">
					<select name="attribute_<%-attribute.id%>" class="form-control">
						<option value="">${message("common.choose")}</option>
						<%_.each(attribute.options, function(option, i) {%>
							<option value="<%-option%>"><%-option%></option>
						<%});%>
					</select>
				</div>
			</div>
		<%});%>
	</script>
	<script id="specificationTemplate" type="text/template">
		<%_.each(specifications, function(specification, i) {%>
			<div class="specification-item form-group">
				<div class="col-xs-4 col-sm-2" style="margin: 5px 0;">
					<input name="specificationItems[<%-i%>].name" class="specification-item-name form-control text-right" type="text" value="<%-specification.name%>" data-value=<%-specification.name%>>
				</div>
				<div class="col-xs-8 col-sm-10">
					<div class="row">
						<%_.each(specification.options, function(option, j) {%>
							<div class="col-xs-10 col-sm-2" style="margin: 5px 0;">
								<div class="input-group">
									<span class="input-group-addon">
										<div class="checkbox">
											<input name="specificationItems[<%-i%>].entries[<%-j%>].isSelected" class="specification-item-check" type="checkbox" value="true">
											<label></label>
										</div>
									</span>
									<input name="specificationItems[<%-i%>].entries[<%-j%>].value" class="specification-item-entry-value form-control" type="text" value="<%-option%>" data-value=<%-specification.name%>>
									<input name="_specificationItems[<%-i%>].entries[<%-j%>].isSelected" type="hidden" value="false">
									<input name="specificationItems[<%-i%>].entries[<%-j%>].id" class="specification-item-entry-id" type="hidden" value="<%-_.uniqueId()%>">
								</div>
							</div>
						<%});%>
					</div>
				</div>
			</div>
		<%});%>
	</script>
	<script id="skuTemplate" type="text/template">
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<%_.each(specificationItems, function(specificationItem, i) {%>
							<th><%-specificationItem.name%></th>
						<%});%>
						[#if product.type == "GENERAL"]
							<th>${message("Sku.price")}</th>
						[/#if]
						<th>${message("Sku.cost")}</th>
						<th>${message("Sku.marketPrice")}</th>
						[#if product.type == "GENERAL"]
							<th>${message("Sku.maxCommission")}</th>
							<th>${message("Sku.rewardPoint")}</th>
						[/#if]
						[#if product.type == "EXCHANGE"]
							<th>${message("Sku.exchangePoint")}</th>
						[/#if]
						<th>${message("Sku.stock")}</th>
						<th>${message("Sku.isDefault")}</th>
						<th>${message("business.product.isEnabled")}</th>
					</tr>
				</thead>
				<tbody>
					<%_.each(skus, function(entries, i) {%>
						<%
							var ids = [];
							_.each(entries, function(entry, j) {
								ids.push(entry.id);
							});
							var initSkuValue = initSkuValues[ids.join(",")];
						%>
						<tr data-ids="<%-ids.join(",")%>" <%if (initSkuValue != null) {%>title="${message("Sku.sn")}: <%-initSkuValue.sn%>"<%}%>>
							<%
								var skuValue = skuValues[ids.join(",")];
								var price = skuValue != null && skuValue.price != null ? skuValue.price : "";
								var cost = skuValue != null && skuValue.cost != null ? skuValue.cost : "";
								var marketPrice = skuValue != null && skuValue.marketPrice != null ? skuValue.marketPrice : "";
								var maxCommission = skuValue != null && skuValue.maxCommission != null ? skuValue.maxCommission : "";
								var rewardPoint = skuValue != null && skuValue.rewardPoint != null ? skuValue.rewardPoint : "";
								var exchangePoint = skuValue != null && skuValue.exchangePoint != null ? skuValue.exchangePoint : "";
								var stock = skuValue != null && skuValue.stock != null ? skuValue.stock : "";
								var isDefault = skuValue != null && skuValue.isDefault != null ? skuValue.isDefault : false;
								var isEnabled = skuValue != null && skuValue.isEnabled != null ? skuValue.isEnabled : false;
							%>
							<%_.each(entries, function(entry, j) {%>
								<td>
									<p class="form-control-static"><%-entry.value%></p>
									<input name="skuList[<%-i%>].specificationValues[<%-j%>].id" type="hidden" value="<%-entry.id%>">
									<input name="skuList[<%-i%>].specificationValues[<%-j%>].value" type="hidden" value="<%-entry.value%>">
								</td>
							<%});%>
							[#if product.type == "GENERAL"]
								<td>
									<input name="skuList[<%-i%>].price" class="price form-control" type="text" value="<%-price%>" maxlength="16"<%-!isEnabled ? " disabled" : ""%>>
								</td>
							[/#if]
							<td>
								<input name="skuList[<%-i%>].cost" class="cost form-control" type="text" value="<%-cost%>" maxlength="16"<%-!isEnabled ? " disabled" : ""%>>
							</td>
							<td>
								<input name="skuList[<%-i%>].marketPrice" class="market-price form-control" type="text" value="<%-marketPrice%>" maxlength="16"<%-!isEnabled ? " disabled" : ""%>>
							</td>
							[#if product.type == "GENERAL"]
								<td>
									<input name="skuList[<%-i%>].maxCommission" class="max-commission form-control" type="text" value="<%-maxCommission%>" maxlength="16"<%-!isEnabled ? " disabled" : ""%>>
								</td>
								<td>
									<input name="skuList[<%-i%>].rewardPoint" class="reward-point form-control" type="text" value="<%-rewardPoint%>" maxlength="9"<%-!isEnabled ? " disabled" : ""%>>
								</td>
							[/#if]
							[#if product.type == "EXCHANGE"]
								<td>
									<input name="skuList[<%-i%>].exchangePoint" class="exchange-point form-control" type="text" value="<%-exchangePoint%>" maxlength="9"<%-!isEnabled ? " disabled" : ""%>>
								</td>
							[/#if]
							<td>
								<%if (initSkuValue != null) {%>
									<div class="input-group">
										<input name="skuList[<%-i%>].stock" class="stock form-control" type="text" value="<%-initSkuValue.stock%>" maxlength="9" title="${message("Sku.allocatedStock")}: <%-initSkuValue.allocatedStock%>" style="min-width: 70px;" readonly>
										<div class="input-group-btn">
											<a class="sn btn btn-default" href="${base}/business/stock/stock_in?skuSn=<%-initSkuValue.sn%>" title="${message("business.product.stockIn")}" data-toggle="tooltip">+</a>
											<a class="sn btn btn-default" href="${base}/business/stock/stock_out?skuSn=<%-initSkuValue.sn%>" title="${message("business.product.stockOut")}" data-toggle="tooltip">-</a>
										</div>
									</div>
								<%} else {%>
									<input name="skuList[<%-i%>].stock" class="stock form-control" type="text" value="<%-stock%>" maxlength="9"<%-!isEnabled ? " disabled" : ""%>>
								<%}%>
							</td>
							<td>
								<div class="checkbox">
									<input name="_skuList[<%-i%>].isDefault" type="hidden" value="false">
									<input name="skuList[<%-i%>].isDefault" class="is-default" type="checkbox" value="true"<%-isDefault ? " checked" : ""%><%-!isEnabled ? " disabled" : ""%>>
									<label></label>
								</div>
							</td>
							<td>
								<div class="checkbox">
									<input name="isEnabled" class="is-enabled" type="checkbox" value="true"<%-isEnabled ? " checked" : ""%>>
									<label></label>
								</div>
							</td>
						</tr>
					<%});%>
				</tbody>
			</table>
		</div>
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				
				var $productForm = $("#productForm");
				var $isDefault = $("#isDefault");
				var $productCategoryId = $("#productCategoryId");
				var $price = $("#price");
				var $cost = $("#cost");
				var $marketPrice = $("#marketPrice");
				var $maxCommission = $("#maxCommission");
				var $rewardPoint = $("#rewardPoint");
				var $exchangePoint = $("#exchangePoint");
				var $stock = $("#stock");
				var $productImage = $("#productImage");
				var $productImageFile = $("#productImage input:file");
				var $addParameterButton = $("#addParameterButton");
				var $resetParameter = $("#resetParameter");
				var $parameterContent = $("#parameterContent");
				var $attribute = $("#attribute");
				var $resetSpecification = $("#resetSpecification");
				var $specificationContent = $("#specificationContent");
				var $sku = $("#sku");
				var productImageInputTemplate = _.template($("#productImageInputTemplate").html());
				var addParameterGroupTemplate = _.template($("#addParameterGroupTemplate").html());
				var addParameterTemplate = _.template($("#addParameterTemplate").html());
				var parameterGroupTemplate = _.template($("#parameterGroupTemplate").html());
				var attributeTemplate = _.template($("#attributeTemplate").html());
				var specificationTemplate = _.template($("#specificationTemplate").html());
				var skuTemplate = _.template($("#skuTemplate").html());
				var previousProductCategoryId = ${product.productCategory.id};
				var productImageIndex = 0;
				var parameterIndex = ${(product.parameterValues?size)!0};
				var parameterEntryIndex = 0;
				var hasSpecification = ${product.hasSpecification()?string("true", "false")};
				var productImages = [];
				var initSkuValues = {};
				
				productImages = [
					[#list product.productImages as productImage]
						{
							source: "${productImage.source}",
							large: "${productImage.large}",
							medium: "${productImage.medium}",
							thumbnail: "${productImage.thumbnail}",
							order: "${productImage.order}"
						}[#if productImage_has_next],[/#if]
					[/#list]
				];
				
				var $dxyydlImage = $("#dxyydlImage");
				var $dxyydlImageFile = $("#dxyydlImage input:file");
				var dxyydlImageInputTemplate = _.template($("#dxyydlImageInputTemplate").html());
				var dxyydlImageIndex = 0;
				
				var dxyydlImages = [];
				
				dxyydlImages = [
					[#list product.dxyydlImages as dxyydlImage]
						{
							source: "${dxyydlImage.source}",
							large: "${dxyydlImage.large}",
							medium: "${dxyydlImage.medium}",
							thumbnail: "${dxyydlImage.thumbnail}",
							order: "${dxyydlImage.order}"
						}[#if dxyydlImage_has_next],[/#if]
					[/#list]
				];
				
				var $kkxsybgFile = $("#kkxsybgFile");
				var $kkxsybgFileFile = $("#kkxsybgFile input:file");
				var kkxsybgFileInputTemplate = _.template($("#kkxsybgFileInputTemplate").html());
				var kkxsybgFileIndex = 0;
				
				var kkxsybgFiles = [];
				
				kkxsybgFiles = [
					[#list product.kkxsybgFiles as kkxsybgFile]
						{
							source: "${kkxsybgFile.source}",
							order: "${kkxsybgFile.order}"
						}[#if kkxsybgFile_has_next],[/#if]
					[/#list]
				];
				
				var $addDxncsParamButton = $("#addDxncsParamButton");
				var $resetDxncsParam = $("#resetDxncsParam");
				var $dxncsParamContent = $("#dxncsParamContent");
				var addDxncsParamTitleTemplate = _.template($("#addDxncsParamTitleTemplate").html());
				var addDxncsParamTemplate = _.template($("#addDxncsParamTemplate").html());
				var dxncsParamIndex = ${(product.dxncsParams?size)!0};
				var dxncsParams = [];
				
				dxncsParams = [
					[#list product.dxncsParams as dxncsParam]
						{
							name: "${dxncsParam.name}",
							min: "${dxncsParam.min}",
							typ: "${dxncsParam.typ}",
							max: "${dxncsParam.max}",
							unit: "${dxncsParam.unit}"
						}[#if dxncsParam_has_next],[/#if]
					[/#list]
				];
				
				if(dxncsParams.length > 0)
					$dxncsParamContent.append(addDxncsParamTitleTemplate());
				$.each(dxncsParams,function(index,dxncsParam){
					$dxncsParamContent.append(addDxncsParamTemplate({
						dxncsParam: dxncsParam,
						dxncsParamIndex: index
					}));
				});
				
				var $addQthjzbParamButton = $("#addQthjzbParamButton");
				var $resetQthjzbParam = $("#resetQthjzbParam");
				var $qthjzbParamContent = $("#qthjzbParamContent");
				var addQthjzbParamTitleTemplate = _.template($("#addQthjzbParamTitleTemplate").html());
				var addQthjzbParamTemplate = _.template($("#addQthjzbParamTemplate").html());
				var qthjzbParamIndex = ${(product.qthjzbParams?size)!0};
				var qthjzbParams = [];
				
				qthjzbParams = [
					[#list product.qthjzbParams as qthjzbParam]
						{
							name: "${qthjzbParam.name}",
							value2: "${qthjzbParam.value2}",
							value1: "${qthjzbParam.value1}",
							value3: "${qthjzbParam.value3}",
							unit: "${qthjzbParam.unit}"
						}[#if qthjzbParam_has_next],[/#if]
					[/#list]
				];
				
				if(qthjzbParams.length > 0)
					$qthjzbParamContent.append(addQthjzbParamTitleTemplate());
				$.each(qthjzbParams,function(index,qthjzbParam){
					$qthjzbParamContent.append(addQthjzbParamTemplate({
						qthjzbParam: qthjzbParam,
						qthjzbParamIndex: index
					}));
				});
				
				var $addCsjdzdParamButton = $("#addCsjdzdParamButton");
				var $resetCsjdzdParam = $("#resetCsjdzdParam");
				var $csjdzdParamContent = $("#csjdzdParamContent");
				var addCsjdzdParamTitleTemplate = _.template($("#addCsjdzdParamTitleTemplate").html());
				var addCsjdzdParamTemplate = _.template($("#addCsjdzdParamTemplate").html());
				var csjdzdParamIndex = ${(product.csjdzdParams?size)!0};
				var csjdzdParams = [];
				
				csjdzdParams = [
					[#list product.csjdzdParams as csjdzdParam]
						{
							name: "${csjdzdParam.name}",
							value2: "${csjdzdParam.value2}",
							value1: "${csjdzdParam.value1}",
							value3: "${csjdzdParam.value3}",
							unit: "${csjdzdParam.unit}"
						}[#if csjdzdParam_has_next],[/#if]
					[/#list]
				];
				
				if(csjdzdParams.length > 0)
					$csjdzdParamContent.append(addCsjdzdParamTitleTemplate());
				$.each(csjdzdParams,function(index,csjdzdParam){
					$csjdzdParamContent.append(addCsjdzdParamTemplate({
						csjdzdParam: csjdzdParam,
						csjdzdParamIndex: index
					}));
				});
				
				var $addTjgzcsParamButton = $("#addTjgzcsParamButton");
				var $resetTjgzcsParam = $("#resetTjgzcsParam");
				var $tjgzcsParamContent = $("#tjgzcsParamContent");
				var addTjgzcsParamTitleTemplate = _.template($("#addTjgzcsParamTitleTemplate").html());
				var addTjgzcsParamTemplate = _.template($("#addTjgzcsParamTemplate").html());
				var tjgzcsParamIndex = ${(product.tjgzcsParams?size)!0};
				var tjgzcsParams = [];
				
				tjgzcsParams = [
					[#list product.tjgzcsParams as tjgzcsParam]
						{
							name: "${tjgzcsParam.name}",
							value1: "${tjgzcsParam.value1}",
							value2: "${tjgzcsParam.value2}",
							value3: "${tjgzcsParam.value3}",
							unit: "${tjgzcsParam.unit}"
						}[#if tjgzcsParam_has_next],[/#if]
					[/#list]
				];
				
				if(tjgzcsParams.length > 0)
					$tjgzcsParamContent.append(addTjgzcsParamTitleTemplate());
				$.each(tjgzcsParams,function(index,tjgzcsParam){
					$tjgzcsParamContent.append(addTjgzcsParamTemplate({
						tjgzcsParam: tjgzcsParam,
						tjgzcsParamIndex: index
					}));
				});
				
				var $addJrgwParamButton = $("#addJrgwParamButton");
				var $resetJrgwParam = $("#resetJrgwParam");
				var $jrgwParamContent = $("#jrgwParamContent");
				var addJrgwParamTitleTemplate = _.template($("#addJrgwParamTitleTemplate").html());
				var addJrgwParamTemplate = _.template($("#addJrgwParamTemplate").html());
				var jrgwParamIndex = ${(product.jrgwParams?size)!0};
				var jrgwParams = [];
				
				jrgwParams = [
					[#list product.jrgwParams as jrgwParam]
						{
							name: "${jrgwParam.name}",
							value1: "${jrgwParam.value1}"
						}[#if jrgwParam_has_next],[/#if]
					[/#list]
				];
				
				//$jrgwParamContent.append(addJrgwParamTitleTemplate());
				$.each(jrgwParams,function(index,jrgwParam){
					$jrgwParamContent.append(addJrgwParamTemplate({
						jrgwParam: jrgwParam,
						jrgwParamIndex: index
					}));
				});
				
				[#if !product.parameterValues?has_content]
					loadParameter();
				[/#if]
				
				[#if product.hasSpecification()]
					[#list product.skus as sku]
						initSkuValues["${sku.specificationValueIds?join(",")}"] = {
							id: ${sku.id},
							sn: "${sku.sn}",
							price: ${sku.price},
							cost: ${sku.cost!"null"},
							marketPrice: ${sku.marketPrice},
							maxCommission: ${sku.maxCommission},
							rewardPoint: ${sku.rewardPoint},
							exchangePoint: ${sku.exchangePoint},
							stock: ${sku.stock},
							allocatedStock: ${sku.allocatedStock},
							isDefault: ${sku.isDefault?string("true", "false")},
							isEnabled: true
						};
					[/#list]
					buildSkuTable(initSkuValues);
				[#else]
					loadSpecification();
				[/#if]
				
				// 商品分类
				$productCategoryId.change(function() {
					if (!isEmpty($attribute.find("select"))) {
						bootbox.confirm("${message("business.product.productCategoryChangeConfirm")}", function(result) {
							if (result) {
								if (isEmpty($parameterContent.find("input.parameter-entry-value"))) {
									loadDxnParams();
									//loadParameter();
								}
								loadAttribute();
								if (isEmpty($sku.find("input:text"))) {
									hasSpecification = false;
									changeView();
									loadSpecification();
								}
								previousProductCategoryId = $productCategoryId.val();
							} else {
								$productCategoryId.selectpicker("val", previousProductCategoryId);
							}
						});
					} else {
						if (isEmpty($parameterContent.find("input.parameter-entry-value"))) {
							//loadParameter();
							loadDxnParams();
						}
						loadAttribute();
						if (isEmpty($sku.find("input:text"))) {
							hasSpecification = false;
							changeView();
							loadSpecification();
						}
						previousProductCategoryId = $productCategoryId.val();
					}
				});
				
				// 判断是否为空
				function isEmpty($elements) {
					var isEmpty = true;
					
					$elements.each(function() {
						var $element = $(this);
						if ($.trim($element.val()) !== "") {
							isEmpty = false;
							return false;
						}
					});
					return isEmpty;
				}
				
				// 修改视图
				function changeView() {
					$isDefault.prop("disabled", hasSpecification);
					$price.add($cost).add($marketPrice).add($maxCommission).add($rewardPoint).add($exchangePoint).add($stock).prop("disabled", hasSpecification).closest("div.form-group").velocity(hasSpecification ? "slideUp" : "slideDown");
				}
				
				// 商品图片
				$productImageFile.fileinput({
					uploadUrl: "${base}/business/product/upload_product_image",
					allowedFileExtensions: "${setting.uploadImageExtension}".split(","),
					[#if setting.uploadMaxSize != 0]
						maxFileSize: ${setting.uploadMaxSize} * 1024,
					[/#if]
					showRemove: false,
					showClose: false,
					dropZoneEnabled: false,
					overwriteInitial: false,
					initialPreviewAsData: true,
					initialPreview: $.map(productImages, function(productImage) {
						return productImage.large;
					}),
					initialPreviewConfig: $.map(productImages, function(productImage, i) {
						return {
							url: "${base}/business/product/delete_product_image",
							key: i
						}
					}),
					initialPreviewThumbTags: $.map(productImages, function(productImage) {
						return {
							"{inputs}": productImageInputTemplate({
								productImageIndex: productImageIndex ++,
								productImage: productImage
							})
						}
					}),
					previewClass: "multiple-file-preview",
					previewThumbTags: {
						"{inputs}": function() {
							return productImageInputTemplate({
								productImageIndex: productImageIndex ++
							});
						}
					},
					layoutTemplates: {
						footer: '<div class="file-thumbnail-footer">{inputs}{actions}</div>',
						actions: '<div class="file-actions"><div class="file-footer-buttons">{upload} {download} {delete} {zoom} {other}</div>{drag}<div class="clearfix"></div></div>'
					},
					fileActionSettings: {
						showUpload: false,
						showRemove: true,
						showDrag: false
					},
					removeFromPreviewOnError: true,
					showAjaxErrorDetails: false
				}).on("fileuploaded", function(event, data, previewId, index) {
					var $preview = $("#" + previewId);
					var productImage = data.response;
					
					$preview.find("input[name$='.source']").val(productImage.source);
					$preview.find("input[name$='.large']").val(productImage.large);
					$preview.find("input[name$='.medium']").val(productImage.medium);
					$preview.find("input[name$='.thumbnail']").val(productImage.thumbnail);
				});
				
				// 典型应用电路图片
				$dxyydlImageFile.fileinput({
					uploadUrl: "${base}/business/product/upload_dxyydl_image",
					allowedFileExtensions: "${setting.uploadImageExtension}".split(","),
					[#if setting.uploadMaxSize != 0]
						maxFileSize: ${setting.uploadMaxSize} * 1024,
					[/#if]
					showRemove: false,
					showClose: false,
					dropZoneEnabled: false,
					overwriteInitial: false,
					initialPreviewAsData: true,
					initialPreview: $.map(dxyydlImages, function(dxyydlImage) {
						return dxyydlImage.large;
					}),
					initialPreviewConfig: $.map(dxyydlImages, function(dxyydlImage, i) {
						return {
							url: "${base}/business/product/delete_dxyydl_image",
							key: i
						}
					}),
					initialPreviewThumbTags: $.map(dxyydlImages, function(dxyydlImage) {
						return {
							"{inputs}": dxyydlImageInputTemplate({
								dxyydlImageIndex: dxyydlImageIndex ++,
								dxyydlImage: dxyydlImage
							})
						}
					}),
					previewClass: "multiple-file-preview",
					previewThumbTags: {
						"{inputs}": function() {
							return dxyydlImageInputTemplate({
								dxyydlImageIndex: dxyydlImageIndex ++
							});
						}
					},
					layoutTemplates: {
						footer: '<div class="file-thumbnail-footer">{inputs}{actions}</div>',
						actions: '<div class="file-actions"><div class="file-footer-buttons">{upload} {download} {delete} {zoom} {other}</div>{drag}<div class="clearfix"></div></div>'
					},
					fileActionSettings: {
						showUpload: false,
						showRemove: true,
						showDrag: false
					},
					removeFromPreviewOnError: true,
					showAjaxErrorDetails: false
				}).on("fileuploaded", function(event, data, previewId, index) {
					var $preview = $("#" + previewId);
					var dxyydlImage = data.response;
					
					$preview.find("input[name$='.source']").val(dxyydlImage.source);
					$preview.find("input[name$='.large']").val(dxyydlImage.large);
					$preview.find("input[name$='.medium']").val(dxyydlImage.medium);
					$preview.find("input[name$='.thumbnail']").val(dxyydlImage.thumbnail);
				});
				
				// 可靠性试验报告文件
				$kkxsybgFileFile.fileinput({
					uploadUrl: "${base}/common/file/upload",
					uploadExtraData: {
						fileType: "FILE"
					},
					allowedFileExtensions: "pdf".split(","),
					[#if setting.uploadMaxSize != 0]
						maxFileSize: ${setting.uploadMaxSize} * 1024,
					[/#if]
					showRemove: false,
					showClose: false,
					dropZoneEnabled: false,
					overwriteInitial: false,
					initialPreview: $.map(kkxsybgFiles, function(kkxsybgFile) {
						return kkxsybgFile.source;
					}),
					initialPreviewConfig: $.map(kkxsybgFiles, function(kkxsybgFile, i) {
						return {
							url: "${base}/business/product/delete_file",
							key: i,
							type:"pdf"
							
						}
					}),
					/*initialPreviewThumbTags: $.map(kkxsybgFiles, function(kkxsybgFile) {
						return {
							"{inputs}": kkxsybgFileInputTemplate({
								kkxsybgFileIndex: kkxsybgFileIndex ++,
								kkxsybgFile: kkxsybgFile
							})
						}
					}),*/
					previewClass: "multiple-file-preview",
					previewThumbTags: {
						"{inputs}": function() {
							return kkxsybgFileInputTemplate({
								kkxsybgFileIndex: kkxsybgFileIndex ++
							});
						}
					},
					layoutTemplates: {
						footer: '<div class="file-thumbnail-footer">{inputs}{actions}</div>',
						actions: '<div class="file-actions"><div class="file-footer-buttons">{upload} {download} {delete} {zoom} {other}</div>{drag}<div class="clearfix"></div></div>'
					},
					fileActionSettings: {
						showUpload: false,
						showRemove: true,
						showDrag: false
					},
					removeFromPreviewOnError: true,
					showAjaxErrorDetails: false
				}).on("fileuploaded", function(event, data, previewId, index) {
					var $preview = $("#" + previewId);
					var file = data.response;
					$preview.find("input[name$='.source']").val(file.url);
				});
				
				// 商品文件
				Sortable.create($kkxsybgFile.find(".file-preview-thumbnails")[0], {
					animation: 300
				});
				
				// 商品图片排序
				Sortable.create($dxyydlImage.find(".file-preview-thumbnails")[0], {
					animation: 300
				});
				
				// 商品图片排序
				Sortable.create($productImage.find(".file-preview-thumbnails")[0], {
					animation: 300
				});
				
				// 增加参数
				$addParameterButton.click(function() {
					var parameterIndex = $parameterContent.children(".item").size();
					
					$parameterContent.append(addParameterGroupTemplate({
						parameterIndex: parameterIndex,
						parameterEntryIndex: parameterEntryIndex
					}));
				});
				
				// 重置参数
				$resetParameter.click(function() {
					bootbox.confirm("${message("business.product.resetParameterConfirm")}", function(result) {
						if (result) {
							loadParameter();
						}
					});
				});
				
				// 删除参数
				$parameterContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($element.hasClass("group")) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						if ($element.closest("div.item").find("div.form-group").size() <= 2) {
							$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
								type: "warning"
							});
							return false;
						}
						$element.closest("div.form-group").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					}
				});
				
				// 添加参数
				$parameterContent.on("click", "a.add", function() {
					var $element = $(this);
					var $item = $element.closest(".item");
					var parameterIndex = $item.data("parameter-index");
					var parameterEntryIndex = $item.find(".form-group").size() - 1;
					
					$item.append(addParameterTemplate({
						parameterIndex: parameterIndex,
						parameterEntryIndex: parameterEntryIndex
					}));
				});
				
				// 添加电性能参数
				$addDxncsParamButton.click(function() {
					var dxncsParamIndex = $dxncsParamContent.children(".item").size();
					
					var $item = $dxncsParamContent;
					if(dxncsParamIndex == 0){
						$item.append(addDxncsParamTitleTemplate());
					}
					$item.append(addDxncsParamTemplate({
						dxncsParam:{},
						dxncsParamIndex: dxncsParamIndex
					}));
				});
				
				// 重置电性能参数
				$resetDxncsParam.click(function() {
					bootbox.confirm("${message("business.product.resetDxncsParamConfirm")}", function(result) {
						if (result) {
							loadDxnParams();
							//$dxncsParamContent.empty();
						}
					});
				});
				
				// 删除电性能参数
				$dxncsParamContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($dxncsParamContent.children(".item").size() > 1) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
				});
				
				// 添加其它环境适应性指标
				$addQthjzbParamButton.click(function() {
					var qthjzbParamIndex = $qthjzbParamContent.children(".item").size();
					
					var $item = $qthjzbParamContent;
					if(qthjzbParamIndex == 0){
						$item.append(addQthjzbParamTitleTemplate());
					}
					$item.append(addQthjzbParamTemplate({
						qthjzbParam: {},
						qthjzbParamIndex: qthjzbParamIndex
					}));
				});
				
				// 重置其它环境适应性指标
				$resetQthjzbParam.click(function() {
					bootbox.confirm("${message("business.product.resetQthjzbParamConfirm")}", function(result) {
						if (result) {
							$qthjzbParamContent.empty();
						}
					});
				});
				
				// 删除其它环境适应性指标
				$qthjzbParamContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($qthjzbParamContent.children(".item").size() > 1) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
				});
				
				// 添加参数绝对最大额定值
				$addCsjdzdParamButton.click(function() {
					var csjdzdParamIndex = $csjdzdParamContent.children(".item").size();
					
					var $item = $csjdzdParamContent;
					if(csjdzdParamIndex == 0){
						$item.append(addCsjdzdParamTitleTemplate());
					}
					$item.append(addCsjdzdParamTemplate({
						csjdzdParam: {},
						csjdzdParamIndex: csjdzdParamIndex
					}));
				});
				
				// 重置参数绝对最大额定值
				$resetCsjdzdParam.click(function() {
					bootbox.confirm("${message("business.product.resetCsjdzdParamConfirm")}", function(result) {
						if (result) {
							$csjdzdParamContent.empty();
						}
					});
				});
				
				// 删除参数绝对最大额定值
				$csjdzdParamContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($csjdzdParamContent.children(".item").size() > 1) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
				});
				
				// 添加推荐工作参数
				$addTjgzcsParamButton.click(function() {
					var tjgzcsParamIndex = $tjgzcsParamContent.children(".item").size();
					
					var $item = $tjgzcsParamContent;
					if(tjgzcsParamIndex == 0){
						$item.append(addTjgzcsParamTitleTemplate());
					}
					$item.append(addTjgzcsParamTemplate({
						tjgzcsParam: {},
						tjgzcsParamIndex: tjgzcsParamIndex
					}));
				});
				
				// 重置推荐工作参数
				$resetTjgzcsParam.click(function() {
					bootbox.confirm("${message("business.product.resetTjgzcsParamConfirm")}", function(result) {
						if (result) {
							$tjgzcsParamContent.empty();
						}
					});
				});
				
				// 删除推荐工作参数
				$tjgzcsParamContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($tjgzcsParamContent.children(".item").size() > 1) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
				});
				
				// 添加兼容国外型号生产厂家
				$addJrgwParamButton.click(function() {
					var jrgwParamIndex = $jrgwParamContent.children(".item").size();
					
					var $item = $jrgwParamContent;
					if(jrgwParamIndex == 0){
						$item.append(addJrgwParamTitleTemplate());
					}
					$item.append(addJrgwParamTemplate({
						jrgwParam: {},
						jrgwParamIndex: jrgwParamIndex
					}));
				});
				
				// 重置兼容国外型号生产厂家
				$resetJrgwParam.click(function() {
					bootbox.confirm("${message("business.product.resetJrgwParamConfirm")}", function(result) {
						if (result) {
							$jrgwParamContent.empty();
						}
					});
				});
				
				// 删除兼容国外型号生产厂家
				$jrgwParamContent.on("click", "a.remove", function() {
					var $element = $(this);
					
					if ($jrgwParamContent.children(".item").size() > 1) {
						$element.closest("div.item").velocity("fadeOut", {
							complete: function() {
								$(this).remove();
							}
						});
					} else {
						$.bootstrapGrowl("${message("business.product.deleteAllNotAllowed")}", {
							type: "warning"
						});
						return false;
					}
				});
				
				// 加载参数
				function loadParameter() {
					$.ajax({
						url: "${base}/business/product/parameters",
						type: "GET",
						data: {
							productCategoryId: $productCategoryId.val()
						},
						dataType: "json",
						success: function(parameters) {
							$parameterContent.html(parameterGroupTemplate({
								parameters: parameters,
								parameterIndex: parameterIndex
							}));
						}
					});
				}
				
				// 加载参数
				function loadDxnParams() {
					$dxncsParamContent.empty();
					$.ajax({
						url: "${base}/business/product/dxn_params",
						type: "GET",
						data: {
							productCategoryId: $productCategoryId.val()
						},
						dataType: "json",
						success: function(params) {
							if(params.length > 0 && params[0].names > 0){
								$dxncsParamContent.append(addDxncsParamTitleTemplate());
								for(var i = 0; i < params.names; i++){
									$dxncsParamContent.append(addDxncsParamTemplate({
										dxncsParam: {"name":params[i]},
										dxncsParamIndex: dxncsParamIndex
									}));
								}
							}
						}
					});
				}
				
				// 加载属性
				function loadAttribute() {
					$.ajax({
						url: "${base}/business/product/attributes",
						type: "GET",
						data: {
							productCategoryId: $productCategoryId.val()
						},
						dataType: "json",
						success: function(attributes) {
							$attribute.html(attributeTemplate({
								attributes: attributes
							})).find("select").selectpicker();
						}
					});
				}
				
				// 重置规格
				$resetSpecification.click(function() {
					bootbox.confirm("${message("business.product.resetSpecificationConfirm")}", function(result) {
						if (result) {
							hasSpecification = false;
							changeView();
							loadSpecification();
						}
					});
				});
				
				// 选择规格
				$specificationContent.on("change", "input.specification-item-check", function() {
					hasSpecification = $specificationContent.find("input:checkbox:checked").size() > 0;
					changeView();
					buildSkuTable();
					if ($sku.find("input.is-default:not(:disabled):checked").size() === 0) {
						$sku.find("input.is-default:not(:disabled):first").prop("checked", true);
					}
				});
				
				// 规格
				$specificationContent.on("change", "input:text", function() {
					var $element = $(this);
					var value = $.trim($element.val());
					
					if (value === "") {
						$element.val($element.data("value"));
						return false;
					}
					if ($element.hasClass("specification-item-entry-value")) {
						var values = $element.closest("div.specification-item").find("input.specification-item-entry-value").not($element).map(function() {
							return $.trim($(this).val());
						}).get();
						
						if ($.inArray(value, values) >= 0) {
							$.bootstrapGrowl("${message("business.product.specificationItemEntryValueRepeated")}", {
								type: "warning"
							});
							$element.val($element.data("value"));
							return false;
						}
					}
					$element.data("value", value);
					buildSkuTable();
				});
				
				// 是否默认
				$sku.on("change", "input.is-default", function() {
					var $element = $(this);
					
					if ($element.prop("checked")) {
						$sku.find("input.is-default").not($element).prop("checked", false);
					} else {
						$element.prop("checked", true);
					}
				});
				
				// 是否启用
				$sku.on("change", "input.is-enabled", function() {
					var $element = $(this);
					
					if ($element.prop("checked")) {
						$element.closest("tr").find("input:not(input.is-enabled)").prop("disabled", false);
					} else {
						$element.closest("tr").find("input:not(input.is-enabled)").prop("disabled", true).end().find("input.is-default").prop("checked", false);
					}
					if ($sku.find("input.is-default:not(:disabled):checked").size() === 0) {
						$sku.find("input.is-default:not(:disabled):first").prop("checked", true);
					}
				});
				
				// 生成SKU表
				function buildSkuTable(skuValues) {
					var specificationItems = [];
					
					if (!hasSpecification) {
						$sku.empty()
						return false;
					}
					$specificationContent.find("div.specification-item").each(function() {
						var $element = $(this);
						var $checked = $element.find("input:checkbox:checked");
						
						if ($checked.size() > 0) {
							var specificationItem = {};
							
							specificationItem.name = $element.find("input.specification-item-name").val();
							specificationItem.entries = $checked.map(function() {
								var $element = $(this);
								return {
									id: $element.closest("div.input-group").find("input.specification-item-entry-id").val(),
									value: $element.closest("div.input-group").find("input.specification-item-entry-value").val()
								};
							}).get();
							specificationItems.push(specificationItem);
						}
					});
					var skus = cartesianSkuOf($.map(specificationItems, function(specificationItem) {
						return [specificationItem.entries];
					}));
					if (skuValues == null) {
						skuValues = {};
						$sku.find("tr").each(function() {
							var $element = $(this);
							skuValues[$element.data("ids")] = {
								sn: $element.find("a.sn").data("id"),
								price: $element.find("input.price").val(),
								cost: $element.find("input.cost").val(),
								marketPrice: $element.find("input.market-price").val(),
								maxCommission: $element.find("input.max-commission").val(),
								rewardPoint: $element.find("input.reward-point").val(),
								exchangePoint: $element.find("input.exchange-point").val(),
								stock: $element.find("input.stock").val(),
								isDefault: $element.find("input.is-default").prop("checked"),
								isEnabled: $element.find("input.is-enabled").prop("checked")
							};
						});
					}
					$sku.html(skuTemplate({
						initSkuValues: initSkuValues,
						specificationItems: specificationItems,
						skus: skus,
						skuValues: skuValues
					}));
				}
				
				// 笛卡尔积
				function cartesianSkuOf(array) {
					function addTo(current, args) {
						var i, copy;
						var rest = args.slice(1);
						var isLast = !rest.length;
						var result = [];
						
						for (i = 0; i < args[0].length; i++) {
							copy = current.slice();
							copy.push(args[0][i]);
							if (isLast) {
								result.push(copy);
							} else {
								result = result.concat(addTo(copy, rest));
							}
						}
						return result;
					}
					return addTo([], array);
				}
				
				// 加载规格
				function loadSpecification() {
					$.ajax({
						url: "${base}/business/product/specifications",
						type: "GET",
						data: {
							productCategoryId: $productCategoryId.val()
						},
						dataType: "json",
						success: function(specifications) {
							$specificationContent.html(specificationTemplate({
								specifications: specifications
							}));
							$sku.empty();
						}
					});
				}
				
				$.validator.addClassRules({
					"parameter-group": {
						required: true
					},
					price: {
						required: true,
						number: true,
						min: 0,
						decimal: {
							integer: 12,
							fraction: ${setting.priceScale}
						}
					},
					cost: {
						number: true,
						min: 0,
						decimal: {
							integer: 12,
							fraction: ${setting.priceScale}
						}
					},
					"market-price": {
						number: true,
						min: 0,
						decimal: {
							integer: 12,
							fraction: ${setting.priceScale}
						}
					},
					"max-commission": {
						required: true,
						number: true,
						min: 0,
						max: function(element) {
							var price = $(element).closest("tr").find("input.price").val();
							
							return $.isNumeric(price) ? parseFloat(price) : 999999999;
						},
						decimal: {
							integer: 12,
							fraction: ${setting.priceScale}
						}
					},
					"reward-point": {
						digits: true,
						max: function(element) {
							var price = $(element).closest("tr").find("input.price").val();
							
							return $.isNumeric(price) ? parseInt(price * ${setting.maxPointScale}) : 999999999;
						}
					},
					"exchange-point": {
						required: true,
						digits: true
					},
					stock: {
						required: true,
						digits: true
					}
				});
				
				// 表单验证
				$productForm.validate({
					rules: {
						productCategoryId: "required",
						name: "required",
						"sku.price": {
							required: true,
							number: true,
							min: 0,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						"sku.cost": {
							number: true,
							min: 0,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						"sku.marketPrice": {
							number: true,
							min: 0,
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						"sku.maxCommission": {
							required: true,
							number: true,
							min: 0,
							max: function(element) {
								var price = $price.val();
								
								return $.isNumeric(price) ? parseFloat(price) : 999999999;
							},
							decimal: {
								integer: 12,
								fraction: ${setting.priceScale}
							}
						},
						weight: "digits",
						"sku.rewardPoint": {
							digits: true,
							max: function() {
								return parseInt($price.val() * ${setting.maxPointScale});
							}
						},
						"sku.exchangePoint": {
							required: true,
							digits: true
						},
						"sku.stock": {
							required: true,
							digits: true
						}
					},
					messages: {
						sn: {
							pattern: "${message("common.validator.illegal")}",
							remote: "${message("common.validator.exist")}"
						}
					},
					submitHandler: function(form) {
						if (hasSpecification && $sku.find("input.is-enabled:checked").size() < 1) {
							$.bootstrapGrowl("${message("business.product.specificationSkuRequired")}", {
								type: "warning"
							});
							return false;
						}
						if ($productImageFile.fileinput("getFileStack").length > 0) {
							$.bootstrapGrowl("${message("business.product.productImageUnupload")}", {
								type: "warning"
							});
							return false;
						}
						$productImage.find(".kv-preview-thumb input[name$='.order']").each(function(i) {
							$(this).val(i);
						});
						$productImage.find(".kv-zoom-thumb input").each(function() {
							$(this).prop("disabled", true);
						});
						
						//
						if ($dxyydlImageFile.fileinput("getFileStack").length > 0) {
							$.bootstrapGrowl("${message("business.product.dxyydlImageUnupload")}", {
								type: "warning"
							});
							return false;
						}
						$dxyydlImage.find(".kv-preview-thumb input[name$='.order']").each(function(i) {
							$(this).val(i);
						});
						$dxyydlImage.find(".kv-zoom-thumb input").each(function() {
							$(this).prop("disabled", true);
						});
						
						//
						if ($kkxsybgFileFile.fileinput("getFileStack").length > 0) {
							$.bootstrapGrowl("${message("business.product.kkxsybgFileUnupload")}", {
								type: "warning"
							});
							return false;
						}
						$kkxsybgFile.find(".kv-preview-thumb input[name$='.order']").each(function(i) {
							$(this).val(i);
						});
						$kkxsybgFile.find(".kv-zoom-thumb input").each(function() {
							$(this).prop("disabled", true);
						});
						
						if($("#ueditorHtml").length == 1){
							var content = UE.getEditor('ueditorDiv').getContent();
							$("#ueditorHtml").val(content);
						}
						localStorage.setItem("previousProductCategoryId", $productCategoryId.val());
						$(form).ajaxSubmit({
							successRedirectUrl: "${base}/business/product/list"
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
				<li class="active">${message("business.product.edit")}</li>
			</ol>
			<form id="productForm" class="form-horizontal" action="${base}/business/product/update" method="post">
				<input name="productId" type="hidden" value="${product.id}">
				<input id="isDefault" name="sku.isDefault" type="hidden" value="true">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active">
								<a href="#base" data-toggle="tab">${message("business.product.base")}</a>
							</li>
							<li>
								<a href="#zyjszb" data-toggle="tab">${message("business.product.zyjszb")}</a>
							</li>
							<li>
								<a href="#appdata" data-toggle="tab">${message("business.product.appdata")}</a>
							</li>
							<li>
								<a href="#manufacturer" data-toggle="tab">${message("business.product.manufacturer")}</a>
							</li>
							<li>
								<a href="#introduction" data-toggle="tab">${message("business.product.introduction")}</a>
							</li>
							<li>
								<a href="#productImage" data-toggle="tab">${message("business.product.productImage")}</a>
							</li>
							<!--
							<li>
								<a href="#parameter" data-toggle="tab">${message("business.product.parameter")}</a>
							</li>
							<li>
								<a href="#attribute" data-toggle="tab">${message("business.product.attribute")}</a>
							</li>
							<li>
								<a href="#specification" data-toggle="tab">${message("business.product.specification")}</a>
							</li>-->
						</ul>
						<div class="tab-content">
							<div id="base" class="tab-pane active">
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required">${message("Product.productCategory")}:</label>
									<div class="col-xs-9 col-sm-4">
										<select id="productCategoryId" name="productCategoryId" class="selectpicker form-control" data-live-search="true" data-size="10">
											<option value="">${message("common.choose")}</option>
											[#list productCategoryTree as productCategory]
												[#if allowedProductCategories?seq_contains(productCategory) || allowedProductCategoryParents?seq_contains(productCategory)]
													<option value="${productCategory.id}" title="${productCategory.name}"[#if productCategory == product.productCategory] selected[/#if][#if !allowedProductCategories?seq_contains(productCategory)] disabled[/#if]>
														[#if productCategory.grade != 0]
															[#list 1..productCategory.grade as i]
																&nbsp;&nbsp;
															[/#list]
														[/#if]
														${productCategory.name}
													</option>
												[/#if]
											[/#list]
										</select>
									</div>
								</div>
								<div class="hidden-element form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Product.storeProductCategory")}:</label>
									<div class="col-xs-9 col-sm-4">
										<select name="storeProductCategoryId" class="selectpicker form-control" data-live-search="true" data-size="10">
											<option value="">${message("common.choose")}</option>
											[#list storeProductCategoryTree as storeProductCategory]
												<option value="${storeProductCategory.id}" title="${storeProductCategory.name}"[#if storeProductCategory == product.storeProductCategory] selected[/#if]>
													[#if storeProductCategory.grade != 0]
														[#list 1..storeProductCategory.grade as i]
															&nbsp;&nbsp;
														[/#list]
													[/#if]
													${storeProductCategory.name}
												</option>
											[/#list]
										</select>
									</div>
								</div>
								<div class="hidden-element form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Product.type")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">${message("Product.Type." + product.type)}</p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Product.sn")}:</label>
									<div class="col-xs-9 col-sm-4">
										<p class="form-control-static">${product.sn}</p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="name">${message("Product.name")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="name" name="name" class="form-control" type="text" value="${product.name}" maxlength="200">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cpxh">${message("Product.cpxh")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="cpxh" name="cpxh" class="form-control" type="text" maxlength="200" value="${product.cpxh}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="gnms">${message("Product.cyd")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea id="differences" name="differences" rows="8" class="form-control">${product.differences}</textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jrgw">${message("Product.jrgw")}:</label>
									<div class="col-xs-9">
										<button id="addJrgwParamButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addJrgwParam")}
										</button>
										<button id="resetJrgwParam" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetJrgwParam")}
										</button>
									</div>
								</div>
								<div id="jrgwParamContent"></div>
								<div class="hidden-element form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="caption">${message("Product.caption")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="caption" name="caption" class="form-control" type="text" value="${product.caption}" maxlength="200">
									</div>
								</div>
								[#if product.type == "GENERAL"]
									<div class="hidden-element [#if product.hasSpecification()]hidden-element[/#if] form-group">
										<label class="col-xs-3 col-sm-2 control-label item-required" for="maxCommission">${message("Sku.maxCommission")}:</label>
										<div class="col-xs-9 col-sm-4" title="${message("business.product.maxCommission")}" data-toggle="tooltip">
											<input id="maxCommission" name="sku.maxCommission" class="form-control" type="text" value="${product.defaultSku.maxCommission}" maxlength="16"[#if product.hasSpecification()] disabled[/#if]>
										</div>
									</div>
								[/#if]
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="unit">${message("Product.unit")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="unit" name="unit" class="form-control" type="text" value="${product.unit}" maxlength="200">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="weight">${message("Product.weight")}:</label>
									<div class="col-xs-9 col-sm-4">
										<div class="input-group">
											<input id="weight" name="weight" class="form-control" type="text" value="${product.weight}" maxlength="9">
											<span class="input-group-addon">${message("common.unit.gram")}</span>
										</div>
									</div>
								</div>
								[#if product.type == "GENERAL"]
									<div class="hidden-element [#if product.hasSpecification()]hidden-element[/#if] form-group">
										<label class="col-xs-3 col-sm-2 control-label" for="rewardPoint">${message("Sku.rewardPoint")}:</label>
										<div class="col-xs-9 col-sm-4" title="${message("business.product.rewardPointTitle")}" data-toggle="tooltip">
											<input id="rewardPoint" name="sku.rewardPoint" class="form-control" type="text" value="${product.defaultSku.rewardPoint}" maxlength="9"[#if product.hasSpecification()] disabled[/#if]>
										</div>
									</div>
								[/#if]
								[#if product.type == "EXCHANGE"]
									<div class="[#if product.hasSpecification()]hidden-element[/#if] form-group">
										<label class="col-xs-3 col-sm-2 control-label item-required" for="exchangePoint">${message("Sku.exchangePoint")}:</label>
										<div class="col-xs-9 col-sm-4">
											<input id="exchangePoint" name="sku.exchangePoint" class="form-control" type="text" value="${product.defaultSku.exchangePoint}" maxlength="9"[#if product.hasSpecification()] disabled[/#if]>
										</div>
									</div>
								[/#if]
								[#if product.hasSpecification()]
									<div class="hidden-element form-group">
										<label class="col-xs-3 col-sm-2 control-label item-required" for="stock">${message("Sku.stock")}:</label>
										<div class="col-xs-9 col-sm-4">
											<input id="stock" name="sku.stock" class="form-control" type="text" value="" maxlength="9" disabled>
										</div>
									</div>
								[#else]
									<div class="form-group">
										<label class="col-xs-3 col-sm-2 control-label" for="stock">${message("Sku.stock")}:</label>
										<div class="col-xs-9 col-sm-4">
											<div class="input-group">
												<input id="stock" name="sku.stock" class="form-control" type="text" value="${product.defaultSku.stock}" maxlength="9" title="${message("Sku.allocatedStock")}: ${product.defaultSku.allocatedStock}" style="min-width: 70px;" readonly>
												<div class="input-group-btn">
													<a class="btn btn-default" href="${base}/business/stock/stock_in?skuSn=${product.defaultSku.sn}" title="${message("business.product.stockIn")}" data-toggle="tooltip">+</a>
													<a class="btn btn-default" href="${base}/business/stock/stock_out?skuSn=${product.defaultSku.sn}" title="${message("business.product.stockOut")}" data-toggle="tooltip">-</a>
												</div>
											</div>
										</div>
									</div>
								[/#if]
								<div class="hidden-element form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("Product.brand")}:</label>
									<div class="col-xs-9 col-sm-4">
										<select name="brandId" class="selectpicker form-control" data-live-search="true" data-size="10">
											<option value="">${message("common.choose")}</option>
											[#list brands as brand]
												<option value="${brand.id}"[#if brand == product.brand] selected[/#if]>${brand.name}</option>
											[/#list]
										</select>
									</div>
								</div>
								[#if productTags?has_content]
									<div class="hidden-element form-group">
										<label class="col-xs-3 col-sm-2 control-label">${message("Product.productTags")}:</label>
										<div class="col-xs-9 col-sm-10">
											[#list productTags as productTag]
												<div class="checkbox checkbox-inline">
													<input id="productTag_${productTag.id}" name="productTagIds" type="checkbox" value="${productTag.id}"[#if product.productTags?seq_contains(productTag)] checked[/#if]>
													<label for="productTag_${productTag.id}">${productTag.name}</label>
												</div>
											[/#list]
										</div>
									</div>
								[/#if]
								[#if storeProductTags?has_content]
									<div class="hidden-element form-group">
										<label class="col-xs-3 col-sm-2 control-label">${message("Product.storeProductTags")}:</label>
										<div class="col-xs-9 col-sm-10">
											[#list storeProductTags as storeProductTag]
												<div class="checkbox checkbox-inline">
													<input id="storeProductTags_${storeProductTag.id}" name="storeProductTagIds" type="checkbox" value="${storeProductTag.id}"[#if product.storeProductTags?seq_contains(storeProductTag)] checked[/#if]>
													<label for="storeProductTags_${storeProductTag.id}">${storeProductTag.name}</label>
												</div>
											[/#list]
										</div>
									</div>
								[/#if]
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label">${message("common.setting")}:</label>
									<div class="col-xs-9 col-sm-4">
										<div class="checkbox checkbox-inline">
											<input name="_isMarketable" type="hidden" value="false">
											<input id="isMarketable" name="isMarketable" type="checkbox" value="true"[#if product.isMarketable] checked[/#if]>
											<label for="isMarketable">${message("Product.isMarketable")}</label>
										</div>
										<div class="checkbox checkbox-inline">
											<input name="_isList" type="hidden" value="false">
											<input id="isList" name="isList" type="checkbox" value="true"[#if product.isList] checked[/#if]>
											<label for="isList">${message("Product.isList")}</label>
										</div>
										<div class="checkbox checkbox-inline">
											<input name="_isSample" type="hidden" value="false">
											<input id="isSample" name="isSample" type="checkbox" value="true"[#if product.isSample] checked[/#if]>
											<label for="isSample">是否提供样片</label>
										</div>
										<div class="checkbox checkbox-inline">
											<input name="_isTop" type="hidden" value="false">
											<input id="isTop" name="isTop" type="checkbox" value="true"[#if product.isTop] checked[/#if]>
											<label for="isTop">${message("Product.isTop")}</label>
										</div>
										<div class="checkbox checkbox-inline">
											<input name="_isDelivery" type="hidden" value="false">
											<input id="isDelivery" name="isDelivery" type="checkbox" value="true"[#if product.isDelivery] checked[/#if]>
											<label for="isDelivery">${message("Product.isDelivery")}</label>
										</div>
									</div>
								</div>
								<div class="hidden-element form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="memo">${message("Product.memo")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="memo" name="memo" class="form-control" type="text" value="${product.memo}" maxlength="200">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="keyword">${message("Product.keyword")}:</label>
									<div class="col-xs-9 col-sm-4" title="${message("business.product.keywordTitle")}" data-toggle="tooltip">
										<input id="keyword" name="keyword" class="form-control" type="text" value="${product.keyword}" maxlength="200">
									</div>
								</div>
							</div>
							<div id="zyjszb" class="tab-pane">
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="fzxs">${message("Product.fzxs")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="fzxs" name="fzxs" class="form-control" type="text" maxlength="200" value="${product.fzxs}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="gnms">${message("Product.gnms")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea name="gnms" rows="8" class="form-control">${product.gnms}</textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="dxncscstj">${message("Product.dxncscstj")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="dxncscstj" name="dxncscstj" class="form-control" type="text" maxlength="200" value="${product.dxncscstj}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="dxncs">${message("Product.dxncs")}:</label>
									<div class="col-xs-9">
										<button id="addDxncsParamButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addDxncsParam")}
										</button>
										<button id="resetDxncsParam" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetDxncsParam")}
										</button>
									</div>
								</div>
								<div id="dxncsParamContent"></div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="zldj">${message("Product.zldj")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="zldj" name="zldj" class="form-control" type="text" maxlength="200" value="${product.zldj}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="gzwd">${message("Product.gzwd")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="gzwd" name="gzwd" class="form-control" type="text" maxlength="200" value="${product.gzwd}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="zcwd">${message("Product.zcwd")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="zcwd" name="zcwd" class="form-control" type="text" maxlength="200" value="${product.zcwd}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="esd">${message("Product.esd")}:</label>
									<div class="col-xs-9 col-sm-4">
										<div class="input-group">
											<input id="esd" name="esd" class="form-control" type="text" maxlength="9" value="${product.esd}">
											<span class="input-group-addon">${message("common.unit.esd")}</span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="qthjzb">${message("Product.qthjzb")}:</label>
									<div class="col-xs-9">
										<button id="addQthjzbParamButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addQthjzbParam")}
										</button>
										<button id="resetQthjzbParam" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetQthjzbParam")}
										</button>
									</div>
								</div>
								<div id="qthjzbParamContent"></div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="sytygf">${message("Product.sytygf")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="sytygf" type="hidden" data-provide="fileinput" data-file-type="FILE" value="${product.sytygf}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="sytygfm">${message("Product.sytygfm")}:</label>
									<div class="col-xs-9 col-sm-4" title="${message("business.product.sytygfmTitle")}" data-toggle="tooltip">
										<input id="sytygfm" name="sytygfm" class="form-control" type="text" maxlength="200" value="${product.sytygfm}">
									</div>
								</div>
							</div>
							<div id="appdata" class="tab-pane">
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cpsc">${message("Product.cpsc")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="cpsc" type="hidden" data-provide="fileinput" data-file-type="FILE" value="${product.cpsc}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jdjyjj">${message("Product.jdjyjj")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea name="jdjyjj" rows="8" class="form-control">${product.jdjyjj}</textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jdjybg">${message("Product.jdjybg")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="jdjybg" type="hidden" data-provide="fileinput" data-file-type="FILE" value="${product.jdjybg}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cpgf">${message("Product.cpgf")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="cpgf" name="cpgf" class="form-control" type="text" maxlength="200" value="${product.cpgf}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="yyzysx">${message("Product.yyzysx")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea name="yyzysx" rows="8" class="form-control">${product.yyzysx}</textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="yyly">${message("Product.dxwwyqj")}:</label>
									<div class="col-xs-9 col-sm-4" title="${message("business.product.dxwwyqjSplit")}" data-toggle="tooltip">
										<input id="dxwwyqj" name="dxwwyqj" class="form-control" type="text" maxlength="200" value="${product.dxwwyqj}">
									</div>
								</div>
								<div class="form-group" id="dxyydlImage">
									<label class="col-xs-3 col-sm-2 control-label" for="cpsc">${message("Product.dxyydl")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="file" type="file" multiple>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jgfxjj">${message("Product.jgfxjj")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea name="jgfxjj" rows="8" class="form-control">${product.jgfxjj}</textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jgfxbg">${message("Product.jgfxbg")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="jgfxbg" type="hidden" data-provide="fileinput" data-file-type="FILE" value="${product.jgfxbg}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="kkxsyjj">${message("Product.kkxsyjj")}:</label>
									<div class="col-xs-9 col-sm-4">
										<textarea name="kkxsyjj" rows="8" class="form-control">${product.kkxsyjj}</textarea>
									</div>
								</div>
								<div class="form-group" id="kkxsybgFile">
									<label class="col-xs-3 col-sm-2 control-label" for="cpsc">${message("Product.kkxsybg")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input name="file" type="file" multiple>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="csjdzd">${message("Product.csjdzd")}:</label>
									<div class="col-xs-9">
										<button id="addCsjdzdParamButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addCsjdzdParam")}
										</button>
										<button id="resetCsjdzdParam" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetCsjdzdParam")}
										</button>
									</div>
								</div>
								<div id="csjdzdParamContent"></div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="tjgzcs">${message("Product.tjgzcs")}:</label>
									<div class="col-xs-9">
										<button id="addTjgzcsParamButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addTjgzcsParam")}
										</button>
										<button id="resetTjgzcsParam" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetTjgzcsParam")}
										</button>
									</div>
								</div>
								<div id="tjgzcsParamContent"></div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="yyly">${message("Product.yyly")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="yyly" name="yyly" class="form-control" type="text" maxlength="200" value="${product.yyly}">
									</div>
								</div>
							</div>
							<div id="manufacturer" class="tab-pane">
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cjdwmc">${message("Product.cjdwmc")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="cjdwmc" name="cjdwmc" class="form-control" type="text" maxlength="200" value="${product.cjdwmc}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cjdz">${message("Product.cjdz")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="cjdz" name="cjdz" class="form-control" type="text" maxlength="200" value="${product.cjdz}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="cjlxfs">${message("Product.cjlxfs")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="cjlxfs" name="cjlxfs" class="form-control" type="text" maxlength="200" value="${product.cjlxfs}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="sclxr">${message("Product.sclxr")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="sclxr" name="sclxr" class="form-control" type="text" maxlength="200" value="${product.sclxr}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label item-required" for="sclxfs">${message("Product.sclxfs")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="sclxfs" name="sclxfs" class="form-control" type="text" maxlength="200" value="${product.sclxfs}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jslxr">${message("Product.jslxr")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="jslxr" name="jslxr" class="form-control" type="text" maxlength="200" value="${product.jslxr}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="jslxfs">${message("Product.jslxfs")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="jslxfs" name="jslxfs" class="form-control" type="text" maxlength="200" value="${product.jslxfs}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="nghnl">${message("Product.nghnl")}:</label>
									<div class="col-xs-9 col-sm-4">
										<input id="nghnl" name="nghnl" class="form-control" type="text" maxlength="200" value="${product.nghnl}">
									</div>
								</div>
								[#if product.type == "GENERAL"]
									<div class="hidden-element [#if product.hasSpecification()]hidden-element[/#if] form-group">
										<label class="col-xs-3 col-sm-2 control-label item-required" for="price">${message("Sku.price")}:</label>
										<div class="col-xs-9 col-sm-4">
											<input id="price" name="sku.price" class="form-control" type="text" value="${product.defaultSku.price}" maxlength="16"[#if product.hasSpecification()] disabled[/#if]>
										</div>
									</div>
								[/#if]
								<div class="hidden-element [#if product.hasSpecification()]hidden-element[/#if] form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="cost">${message("Sku.cost")}:</label>
									<div class="col-xs-9 col-sm-4" title="${message("business.product.costTitle")}" data-toggle="tooltip">
										<input id="cost" name="sku.cost" class="form-control" type="text" value="${product.defaultSku.cost}" maxlength="16"[#if product.hasSpecification()] disabled[/#if]>
									</div>
								</div>
								<div class="hidden-element [#if product.hasSpecification()]hidden-element[/#if] form-group">
									<label class="col-xs-3 col-sm-2 control-label" for="marketPrice">${message("Sku.marketPrice")}:</label>
									<div class="col-xs-9 col-sm-4" title="${message("business.product.marketPriceTitle")}" data-toggle="tooltip">
										<input id="marketPrice" name="sku.marketPrice" class="form-control" type="text" value="${product.defaultSku.marketPrice}" maxlength="16"[#if product.hasSpecification()] disabled[/#if]>
									</div>
								</div>
							</div>
							<div id="introduction" class="tab-pane">
								<div id="ueditorDiv" style="width:100%;height:300px;"></div>
								<textarea name="introduction" style="display:none;" id="ueditorHtml">${product.introduction}</textarea>
							</div>
							<div id="productImage" class="tab-pane">
								<div class="form-group">
									<div class="col-xs-12 col-sm-6">
										<input name="file" type="file" multiple>
									</div>
								</div>
							</div>
							<div id="parameter" class="tab-pane">
								<div class="form-group">
									<div class="col-xs-10 col-xs-offset-2">
										<button id="addParameterButton" class="btn btn-default" type="button">
											<i class="iconfont icon-add"></i>
											${message("business.product.addParameter")}
										</button>
										<button id="resetParameter" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetParameter")}
										</button>
									</div>
								</div>
								<div id="parameterContent">
									[#list product.parameterValues as parameterValue]
										<div class="item" data-parameter-index="${parameterValue_index}" data-parameter-entry-index="${parameterValue.entries?size}">
											<div class="form-group">
												<div class="col-xs-3 col-sm-1 col-sm-offset-1 text-right">
													<p class="form-control-static">${message("Parameter.group")}:</p>
												</div>
												<div class="col-xs-6 col-sm-4">
													<input name="parameterValues[${parameterValue_index}].group" class="parameter-group form-control" type="text" value="${parameterValue.group}" maxlength="200">
												</div>
												<div class="col-xs-3 col-sm-6">
													<p class="form-control-static">
														<a class="remove group" href="javascript:;">[${message("common.delete")}]</a>
														<a class="add" href="javascript:;">[${message("common.add")}]</a>
													</p>
												</div>
											</div>
											[#list parameterValue.entries as entry]
												<div class="form-group">
													<div class="col-xs-3 col-sm-1 col-sm-offset-1">
														<input name="parameterValues[${parameterValue_index}].entries[${entry_index}].name" class="parameter-entry-name form-control text-right" type="text" value="${entry.name}" maxlength="200">
													</div>
													<div class="col-xs-6 col-sm-4">
														<input name="parameterValues[${parameterValue_index}].entries[${entry_index}].value" class="parameter-entry-value form-control" type="text" value="${entry.value}" maxlength="200">
													</div>
													<div class="col-xs-3 col-sm-6">
														<p class="form-control-static">
															<a class="remove" href="javascript:;">[${message("common.delete")}]</a>
														</p>
													</div>
												</div>
											[/#list]
										</div>
									[/#list]
								</div>
							</div>
							<div id="attribute" class="tab-pane">
								[#list product.productCategory.attributes as attribute]
									<div class="form-group">
										<label class="col-xs-3 col-sm-2 control-label">${attribute.name}:</label>
										<div class="col-xs-9 col-sm-4">
											<select name="attribute_${attribute.id}" class="selectpicker form-control">
												<option value="">${message("common.choose")}</option>
												[#list attribute.options as option]
													<option value="${option}"[#if option == product.getAttributeValue(attribute)] selected[/#if]>${option}</option>
												[/#list]
											</select>
										</div>
									</div>
								[/#list]
							</div>
							<div id="specification" class="tab-pane">
								<div class="form-group">
									<div class="col-xs-4 col-xs-offset-2">
										<button id="resetSpecification" class="btn btn-default" type="button">
											<i class="iconfont icon-repeal"></i>
											${message("business.product.resetSpecification")}
										</button>
									</div>
								</div>
								<div id="specificationContent">
									[#list product.specificationItems as specificationItem]
										<div class="specification-item form-group">
											<div class="col-xs-4 col-sm-2" style="margin: 5px 0;">
												<input name="specificationItems[${specificationItem_index}].name" class="specification-item-name form-control text-right" type="text" value="${specificationItem.name}" data-value="${specificationItem.name}">
											</div>
											<div class="col-xs-8 col-sm-10">
												<div class="row">
													[#list specificationItem.entries as entry]
														<div class="col-xs-10 col-sm-2" style="margin: 5px 0;">
															<div class="input-group">
																<span class="input-group-addon">
																	<div class="checkbox">
																		<input name="specificationItems[${specificationItem_index}].entries[${entry_index}].isSelected" class="specification-item-check" type="checkbox" value="true"[#if entry.isSelected] checked[/#if]>
																		<label></label>
																	</div>
																</span>
																<input name="specificationItems[${specificationItem_index}].entries[${entry_index}].value" class="specification-item-entry-value form-control" type="text" value="${entry.value}" data-value="${entry.value}">
																<input name="_specificationItems[${specificationItem_index}].entries[${entry_index}].isSelected" type="hidden" value="false">
																<input name="specificationItems[${specificationItem_index}].entries[${entry_index}].id" class="specification-item-entry-id" type="hidden" value="${entry.id}">
															</div>
														</div>
													[/#list]
												</div>
											</div>
										</div>
									[/#list]
								</div>
								<div id="sku"></div>
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