<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="SHOP++ Team">
	<meta name="copyright" content="SHOP++">
	<title>芯梦导航 - 北京芯梦国际科技有限公司</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/reset2.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/jquery.lazyload.js"></script>
	<script src="${base}/resources/common/js/jquery.qrcode.js"></script>
	<script src="${base}/resources/common/js/lodash.js"></script>
	<script src="${base}/resources/common/js/URI.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/mobile/shop/js/base.js"></script>
	<style type="text/less">
			#Navigation{
				width: 100%;
				margin: 0 auto;
				
				.nav{
					padding:10px;
					border:1px solid #f2f2f2;
				
					ul{
						li{
							a{
								&:not(:last-child){
									margin-right: 10px;
								}
								
								display: inline-block;
							    line-height: 2;
							    width: ~"calc(25.285% - 12px)";
							    color: gray;
							    font-size: 14px;
							    text-overflow: ellipsis;
							    white-space: nowrap;
							    text-align: center;
								overflow:hidden;
							}
						}	
					}
				}
				
				.nav_cate{
					border: 1px solid #f2f2f2;
					padding-bottom: 30px;
					position: relative;
					height: 0;
					transition: height .5s;
					overflow: hidden;
					
					ul{
						&:not(:last-child){
							border-bottom:1px solid #f2f2f2;
						}
						padding:10px;
						
						
						li{
							font-size: 0;
							
							&:not(:last-child){
								margin-bottom:10px
							}
							
							span{
								display: inline-block;
								width: 8%;
								color: lightseagreen;
								margin-right: 2%;
								font-size: 14px;
							}
							
							a{
								display: inline-block;
								width: 20.4%;
								font-size:12px; 
								background: #F5F5F5;
								text-overflow: ellipsis;
							    white-space: nowrap;
							    text-align: center;
								overflow:hidden;
								
								&:not(:last-child){
									margin-right: 2%;
								}
							}
						}
					}
					
					.moreBtn{
						position: absolute;
						bottom: 0px;
						width: 100%;
						text-align: center;
						height: 30px;
						background: white;
						line-height: 30px;
						
						a{
							color: lightseagreen;
						}
					}
				}
			}
		</style>
		<script src="${base}/resources/shop/js/less2.js"></script>
</head>
<body id="Navigation">
	<header class="header-default html5plus-hidden" data-spy="scrollToFixed">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-1">
					<a href="javascript:;" data-action="back">
						<i class="iconfont icon-back"></i>
					</a>
				</div>
				<div class="col-xs-10">
					<h5>芯梦导航</h5>
				</div>
			</div>
		</div>
	</header>
	<main>
		<div class="container">
			<div class="row">
				<div class="col-xs-10" style="width:100%">
					<div class="nav">
						[@xm_navigation_list navigationGroupId =1 count = 60]
							[#if xm_navigations?has_content]
									<ul class="clearfix">
										<li>
											[#list xm_navigations as xm_navigation]
												<a href="${xm_navigation.url}" title="${xm_navigation.name}" target="_blank">${xm_navigation.name}</a>
												[#if xm_navigation_has_next  && (xm_navigation_index+1)%4==0 ]
													</li><li>
												[/#if]
											[/#list]
										</li>
									</ul>
							[/#if]
						[/@xm_navigation_list]
					</div>
					<div class="nav_cate">
						[#if page.content?has_content]
							[#list page.content as xmNavigation]
								[#if xmNavigation.id != 1]
									<ul>
										<li>
											<span>${xmNavigation.name}</span>
											[#list xmNavigation.navigations as navigation ]
												<a href="${navigation.url}" target="_blank">${navigation.name}</a>
												[#if navigation_has_next && (navigation_index+1)%4==0 ]
													</li><li><span></span>
												[/#if]
											[/#list]
										</li>
									</ul>
								[/#if]
							[/#list]
						[/#if]
						<div class="moreBtn" style="margin-bottom: 53px;"><a>展开更多 ︾</a></div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer class="adaptation-sty footer-default html5plus-hidden" data-spy="scrollToFixed" data-bottom="0" style="z-index: 100;position: fixed; bottom: 0px;margin-left: 0px;width: 100%;left: 0px;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-3">
					<a class="active" href="${base}/">
						<i class="iconfont icon-home center-block"></i>
						<span class="center-block">${message("shop.footer.home")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/product_category">
						<i class="iconfont icon-sort center-block"></i>
						<span class="center-block">${message("shop.footer.productCategory")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/cart/list">
						<i class="iconfont icon-cart center-block"></i>
						<span class="center-block">${message("shop.footer.cart")}</span>
					</a>
				</div>
				<div class="col-xs-3">
					<a href="${base}/member/index">
						<i class="iconfont icon-people center-block"></i>
						<span class="center-block">${message("shop.footer.member")}</span>
					</a>
				</div>
			</div>
		</div>
	</footer>
</body>
<script type="text/javascript">
		+function(){
			let container = document.querySelector(".nav_cate");
			let content = document.querySelectorAll(".nav_cate>ul");
			let moreBtn = document.querySelector('.moreBtn>a');
			var height = 0 , allHeight = 0;
			for(let x = 0 ; x < content.length ; x ++){
				if(x<2){
					height += content[x].offsetHeight;
				}
				allHeight += content[x].offsetHeight;
			}
			console.log(container,height);
			container.style.height = 41 + height + "px";
			moreBtn.onclick = function(){
				if(!this.isAll){
					container.style.height =41 + 41 + allHeight + "px";
					$(".moreBtn").css("position","initial");
					this.isAll = true;
					this.innerText = "点击收起︽";
					return;
				}else{
					container.style.height = 41 + height + "px";
					this.isAll = false;
					$(".moreBtn").css("position","absolute");
					this.innerText = "展开更多 ︾";
					return;
				} 
			}
		}()
	</script>
</html>