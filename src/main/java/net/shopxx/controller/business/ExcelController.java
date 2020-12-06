package net.shopxx.controller.business;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.Business;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.Sku;
import net.shopxx.entity.Store;
import net.shopxx.entity.UploadLog;
import net.shopxx.security.CurrentStore;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.CategoryApplicationService;
import net.shopxx.service.DxncsParamService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.ProductParamService;
import net.shopxx.service.ProductService;
import net.shopxx.service.StoreCategoryService;
import net.shopxx.service.StoreProductCategoryService;
import net.shopxx.service.UploadLogService;
import net.shopxx.util.FileDecompressionZip;

@Controller("excelController")
@RequestMapping("/business/import")
public class ExcelController extends BaseController {

	@Inject
	private ProductCategoryService productCategoryService;
	@Inject
	private DxncsParamService dxncsParamService;
	@Inject
	private ProductParamService productParamService;
	@Inject
	private ProductService productService;
	@Inject
	private UploadLogService uploadLogService;
	@Inject
	private StoreProductCategoryService storeProductCategoryService;
	@Inject
	private CategoryApplicationService categoryApplicationService;

	/**
	 * 跳转上传页面
	 * 
	 * @param filePath
	 * @param currentStore
	 * @return
	 */
	@RequestMapping("/importPage")
	public String importPage(@CurrentUser Business currentUser, ModelMap model,Pageable pageable) {
		//获取日志
		Page<UploadLog> findPage = uploadLogService.findPage(pageable, currentUser);
		List<ProductCategory> findList = productCategoryService.findList(currentUser.getStore(), null, null, null);
		model.addAttribute("page", findPage);
		model.addAttribute("findList", findList);
		return "business/product/importExcel";

	}
	/**
	 * 
	 * @parma absPath 相对web的路径
	 * */
	
	@PostMapping("/importExcel")
	public ResponseEntity<?> upLoad(HttpServletRequest req, HttpServletResponse resp,
			@CurrentStore Store currentStore,String hostFileBatch,UploadLog uploadLog,@CurrentUser Business currentUser,String flag) {
		
		//新增日志
		uploadLog.setFileUrl(hostFileBatch);
		uploadLog.setCreatedDate(new Date());
		uploadLog.setFileFlag("0");
		uploadLog.setUploadUser(currentUser);
		
		//保存日志
		uploadLogService.save(uploadLog);

		String path = req.getServletContext().getRealPath("/"); // 保存的路径
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");//获取时间
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");//获取时间
		
		String ymd = sdf.format(new Date());//格式化时间
		String strPath = "upload/" + ymd + "/" + format.format(new Date()) + "/";
		String absPath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/" + strPath; 
		String savePath = path + strPath;
		System.out.println("---savePath---"+savePath);
		
		// 判断是不是zip文件
		if (hostFileBatch.matches(".*.zip") || hostFileBatch.matches(".*.lq")) {
			String fileName = "";
		try {
			// 判断文件目录是否存在
			File file = new File(savePath);
			// 不存在
			if (!file.exists()) {
				// 创建文件夹
				file.mkdirs();
			} else {
				// 文件存在则删除
				deleteDir(file);
				file.mkdirs();
			}
				
				// 解压文件到指定目录文件名
				fileName = new FileDecompressionZip().zipToFile(path + hostFileBatch, savePath);
				//遍历zipToFile获取excel文件名
				System.out.println(savePath);
			} catch (Exception e) {
				e.printStackTrace();
				new File(savePath, hostFileBatch).delete();
			}
			
			//获取解压成功之后的路径
			String filePath = savePath+fileName;
				// 执行批处理
				new ExcelThread(flag,hostFileBatch,uploadLogService,productService, productParamService, dxncsParamService, productCategoryService, filePath, currentStore, null, null, savePath, absPath,storeProductCategoryService,categoryApplicationService).start();
		} else {
			// 不是zip则返回false
			return Results.UNPROCESSABLE_ENTITY;
		}
		return Results.OK;

	}
	
	

	/**
	 * 递归删除目录下的所有文件及子目录下所有文件
	 * 
	 * @param dir 将要删除的文件目录
	 */
	private static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}

	/**
	 * FormBean - SKU
	 * 
	 * @author SHOP++ Team
	 * @version 6.1
	 */
	public static class SkuForm {

		/**
		 * SKU
		 */
		private Sku sku;

		/**
		 * 获取SKU
		 * 
		 * @return SKU
		 */
		public Sku getSku() {
			return sku;
		}

		/**
		 * 设置SKU
		 * 
		 * @param sku SKU
		 */
		public void setSku(Sku sku) {
			this.sku = sku;
		}

	}

	/**
	 * FormBean - SKU
	 * 
	 * @author SHOP++ Team
	 * @version 6.1
	 */
	public static class SkuListForm {

		/**
		 * SKU
		 */
		private List<Sku> skuList;

		/**
		 * 获取SKU
		 * 
		 * @return SKU
		 */
		public List<Sku> getSkuList() {
			return skuList;
		}

		/**
		 * 设置SKU
		 * 
		 * @param skuList SKU
		 */
		public void setSkuList(List<Sku> skuList) {
			this.skuList = skuList;
		}

	}
}
