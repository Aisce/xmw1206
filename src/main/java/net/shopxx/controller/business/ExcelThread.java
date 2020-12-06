package net.shopxx.controller.business;


import net.shopxx.controller.business.ExcelController.SkuForm;
import net.shopxx.controller.business.ExcelController.SkuListForm;
import net.shopxx.entity.Store;
import net.shopxx.service.CategoryApplicationService;
import net.shopxx.service.DxncsParamService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.ProductParamService;
import net.shopxx.service.ProductService;
import net.shopxx.service.StoreProductCategoryService;
import net.shopxx.service.UploadLogService;
import net.shopxx.util.ImpotExcel;

public class ExcelThread extends Thread {
	private String filePath = null; 
	private Store currentStore = null;
	private SkuForm skuForm = null;
	private SkuListForm skuListForm = null;
	private String path = null;
	private String absPath = null;
	
	private String hostFileBatch = null;
	
	private String flag = null;
	
	private UploadLogService uploadLogService;
	
	private ProductCategoryService productCategoryService;
	private DxncsParamService dxncsParamService;
	private ProductParamService productParamService;
	private ProductService productService;
	private StoreProductCategoryService storeProductCategoryService;
	
	private CategoryApplicationService categoryApplicationService;
	
	public ExcelThread(String flag,String hostFileBatch, UploadLogService uploadLogService, ProductService productService,ProductParamService productParamService,DxncsParamService dxncsParamService,ProductCategoryService productCategoryService,String filePath, Store currentStore, SkuForm skuForm,
			SkuListForm skuListForm,String path,String absPath,StoreProductCategoryService storeProductCategoryService,CategoryApplicationService categoryApplicationService) {
		// TODO Auto-generated constructor stub
		this.filePath = filePath;
		this.currentStore = currentStore;
		this.skuForm = skuForm;
		this.skuListForm = skuListForm;
		this.path = path;
		this.absPath = absPath;
		this.productCategoryService = productCategoryService;
		this.dxncsParamService = dxncsParamService;
		this.productParamService = productParamService;
		this.productService = productService;
		this.uploadLogService = uploadLogService;
		this.hostFileBatch = hostFileBatch;
		this.flag = flag;
		this.storeProductCategoryService = storeProductCategoryService;
		this.categoryApplicationService = categoryApplicationService;
	}
	@Override
	public void run() {
		ImpotExcel col = new ImpotExcel();
		col.getDataFromExcel(flag,hostFileBatch,uploadLogService,productService, productParamService, dxncsParamService, productCategoryService, filePath, currentStore, skuForm, skuListForm, filePath, absPath,storeProductCategoryService,categoryApplicationService);
	}
		
}
