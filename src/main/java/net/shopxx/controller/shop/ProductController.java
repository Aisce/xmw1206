/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 0ztlvrE6uPWc21LdaGRIwPq1wg5V6wWl
 */
package net.shopxx.controller.shop;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonView;

import net.shopxx.Filter;
import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.Setting;
import net.shopxx.entity.Attribute;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Brand;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.MechanismStore;
import net.shopxx.entity.Member;
import net.shopxx.entity.Product;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.ProductImage;
import net.shopxx.entity.ProductParam;
import net.shopxx.entity.ProductTag;
import net.shopxx.entity.Promotion;
import net.shopxx.entity.Sample;
import net.shopxx.entity.Store;
import net.shopxx.entity.StoreProductCategory;
import net.shopxx.exception.ResourceNotFoundException;
import net.shopxx.security.CurrentUser;
import net.shopxx.service.AttributeService;
import net.shopxx.service.BrandService;
import net.shopxx.service.CacheService;
import net.shopxx.service.DxncsParamService;
import net.shopxx.service.GroupBuyingService;
import net.shopxx.service.MechanismStoreService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.ProductParamService;
import net.shopxx.service.ProductService;
import net.shopxx.service.ProductTagService;
import net.shopxx.service.PromotionService;
import net.shopxx.service.SampleService;
import net.shopxx.service.StoreProductCategoryService;
import net.shopxx.service.StoreService;
import net.shopxx.util.ImageUtils;

/**
 * Controller - 商品
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("shopProductController")
@RequestMapping("/product")
public class ProductController extends BaseController {

	/**
	 * 最大对比商品数
	 */
	public static final Integer MAX_COMPARE_PRODUCT_COUNT = 4;

	/**
	 * 最大浏览记录商品数
	 */
	public static final Integer MAX_HISTORY_PRODUCT_COUNT = 10;

	@Inject
	private ProductService productService;
	@Inject
	private StoreService storeService;
	@Inject
	private ProductCategoryService productCategoryService;
	@Inject
	private StoreProductCategoryService storeProductCategoryService;
	@Inject
	private BrandService brandService;
	@Inject
	private PromotionService promotionService;
	@Inject
	private ProductTagService productTagService;
	@Inject
	private AttributeService attributeService;
	@Inject
	private GroupBuyingService groupBuyingService;
	@Inject
	private DxncsParamService dxncsParamService;
	@Inject
	private ProductParamService productParamService;
	@Inject
	private SampleService sampleService;
	@Inject
	private MechanismStoreService mechanismStoreService;
	/**
	 * 详情
	 */
	@GetMapping("/detail/{productId}")
	public String detail(@PathVariable Long productId, ModelMap model,@CurrentUser Member currentUser) {
		Product product = productService.find(productId);
		if (product == null || BooleanUtils.isNotTrue(product.getIsActive()) || BooleanUtils.isNotTrue(product.getIsMarketable())) {
			throw new ResourceNotFoundException();
		}
		// 电性能参数
		product.setDxncsParams(dxncsParamService.findList(product, 20, null, null));
		
		// 其它环境适应性指标
		List<Filter> filters = new ArrayList<>();
		filters.add(Filter.eq("type", ProductParam.Type.QTHJSYXZB));
		product.setQthjzbParams(productParamService.findList(product, 20, filters, null));

		// 参数绝对最大额定值
		filters = new ArrayList<>();
		filters.add(Filter.eq("type", ProductParam.Type.CSJDZDEDZ));
		product.setCsjdzdParams(productParamService.findList(product, 20, filters, null));

		// 推荐工作参数
		filters = new ArrayList<>();
		filters.add(Filter.eq("type", ProductParam.Type.TJGZCS));
		product.setTjgzcsParams(productParamService.findList(product, 20, filters, null));
		
		// 兼容国外型号生产厂家
		filters = new ArrayList<>();
		filters.add(Filter.eq("type", ProductParam.Type.JRGWXH));
		product.setJrgwParams(productParamService.findList(product, 20, filters, null));
		List<String> asList = null;
		String dxwwyqj = product.getDxwwyqj();
		if(StringUtils.isNotEmpty(dxwwyqj)) {
			//以,分割
			String[] split = dxwwyqj.split(",");
			
			asList = Arrays.asList(split);
		}
		model.addAttribute("arrayList", asList);
		model.addAttribute("product", product);
		model.addAttribute("currentUser", currentUser);
		return "shop/product/detail";
	}

	/**
	 * 对比栏
	 */
	@GetMapping("/compare_bar")
	public ResponseEntity<?> compareBar(Long[] productIds) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (ArrayUtils.isEmpty(productIds) || productIds.length > MAX_COMPARE_PRODUCT_COUNT) {
			return ResponseEntity.ok(data);
		}

		List<Product> products = productService.findList(productIds);
		for (Product product : products) {
			if (product != null && BooleanUtils.isTrue(product.getIsActive()) && BooleanUtils.isTrue(product.getIsMarketable())) {
				Map<String, Object> item = new HashMap<>();
				item.put("id", product.getId());
				item.put("name", product.getName());
				item.put("price", product.getPrice());
				item.put("marketPrice", product.getMarketPrice());
				item.put("thumbnail", product.getThumbnail());
				item.put("path", product.getPath());
				data.add(item);
			}
		}
		return ResponseEntity.ok(data);
	}

	/**
	 * 添加对比
	 */
	@GetMapping("/add_compare")
	public ResponseEntity<?> addCompare(Long productId) {
		Map<String, Object> data = new HashMap<>();
		Product product = productService.find(productId);
		if (product == null || BooleanUtils.isNotTrue(product.getIsActive()) || BooleanUtils.isNotTrue(product.getIsMarketable())) {
			return Results.UNPROCESSABLE_ENTITY;
		}

		data.put("id", product.getId());
		data.put("name", product.getName());
		data.put("price", product.getPrice());
		data.put("marketPrice", product.getMarketPrice());
		data.put("thumbnail", product.getThumbnail());
		data.put("path", product.getPath());
		return ResponseEntity.ok(data);
	}
	/**
	 * 
	 * @param productId 商品id
	 * @param compareId 对比栏中的商品id
	 * @return
	 */
	@GetMapping("/isSimilar")
	public ResponseEntity<?> isSimilar(Long productId,Long compareId) {
		Product product = productService.find(productId);
		Product compare = productService.find(compareId);
		
		ProductCategory productCategory = product.getProductCategory();
		
		
		ProductCategory parent = productCategory.getParent();
		
		String name = "";
		if(null!=parent) {
			name = parent.getName();
		}else {
			name = productCategory.getName();
		}
		
		ProductCategory compareCategory = compare.getProductCategory();
		
		ProductCategory parent2 = compareCategory.getParent();
		String name1 = "";
		if(null!=parent2) {
			name1 = parent2.getName();
		}else {
			name1=compareCategory.getName();
		}
		if(name1.equals(name)) {
			return ResponseEntity.ok("ok");
		}else {
			return ResponseEntity.ok("no");
		}
	}

	/**
	 * 浏览记录
	 */
	@GetMapping("/history")
	public ResponseEntity<?> history(Long[] productIds) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (ArrayUtils.isEmpty(productIds) || productIds.length > MAX_HISTORY_PRODUCT_COUNT) {
			return ResponseEntity.ok(data);
		}

		List<Product> products = productService.findList(productIds);
		for (Product product : products) {
			if (product != null && BooleanUtils.isTrue(product.getIsActive()) && BooleanUtils.isTrue(product.getIsMarketable())) {
				Map<String, Object> item = new HashMap<>();
				item.put("id", product.getId());
				item.put("name", product.getName());
				item.put("price", product.getPrice());
				item.put("thumbnail", product.getThumbnail());
				item.put("path", product.getPath());
				data.add(item);
			}
		}
		return ResponseEntity.ok(data);
	}

	/**
	 * 列表
	 */
	@GetMapping("/list/{productCategoryId}")
	public String list(@PathVariable Long productCategoryId, Product.Type type, Store.Type storeType, Long brandId, Long promotionId, Long productTagId, String promotionPluginId, BigDecimal startPrice, BigDecimal endPrice, Boolean isOutOfStock, Product.OrderType orderType, Integer pageNumber,
			Integer pageSize, HttpServletRequest request, ModelMap model,@CurrentUser Member currentUser) {
		
		
		ProductCategory productCategory = productCategoryService.find(productCategoryId);
		if (productCategory == null) {
			throw new ResourceNotFoundException();
		}

		Brand brand = brandService.find(brandId);
		Promotion promotion = promotionService.find(promotionId);
		ProductTag productTag = productTagService.find(productTagId);
		Map<Attribute, String> attributeValueMap = new HashMap<>();
		Set<Attribute> attributes = productCategory.getAttributes();
		if (CollectionUtils.isNotEmpty(attributes)) {
			for (Attribute attribute : attributes) {
				String value = request.getParameter("attribute_" + attribute.getId());
				String attributeValue = attributeService.toAttributeValue(attribute, value);
				if (attributeValue != null) {
					attributeValueMap.put(attribute, attributeValue);
				}
			}
		}

		if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
			BigDecimal tempPrice = startPrice;
			startPrice = endPrice;
			endPrice = tempPrice;
		}
		StoreProductCategory storeProductCategory = new StoreProductCategory();
		Pageable pageable = new Pageable(pageNumber, pageSize);
		model.addAttribute("orderTypes", Product.OrderType.values());
		model.addAttribute("productCategory", productCategory);
		model.addAttribute("type", type);
		model.addAttribute("storeType", storeType);
		model.addAttribute("brand", brand);
		model.addAttribute("promotion", promotion);
		model.addAttribute("productTag", productTag);
		model.addAttribute("attributeValueMap", attributeValueMap);
		model.addAttribute("promotionPluginId", promotionPluginId);
		model.addAttribute("startPrice", startPrice);
		model.addAttribute("endPrice", endPrice);
		model.addAttribute("endPrice", endPrice);
		model.addAttribute("isOutOfStock", isOutOfStock);
		model.addAttribute("orderType", orderType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentUser", currentUser);
		model.addAttribute("storeProductCategory", null);
		model.addAttribute("page", productService.findPage(type, storeType, null, productCategory, null, brand, promotion, productTag, null, attributeValueMap, promotionPluginId, startPrice, endPrice, true, true, null, null, true, isOutOfStock, null, null, orderType, pageable, null));
		return "shop/product/list";
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(Product.Type type, Store.Type storeType, Long storeProductCategoryId, Long brandId, Long promotionId, Long productTagId, String promotionPluginId, BigDecimal startPrice, BigDecimal endPrice, Boolean isOutOfStock, Product.OrderType orderType, Integer pageNumber,
			Integer pageSize, ModelMap model,Long storeId,@CurrentUser Member CurrentUser) {
		StoreProductCategory storeProductCategory = storeProductCategoryService.find(storeProductCategoryId);
		if(storeProductCategory == null && storeId > 0) {
			storeProductCategory = new StoreProductCategory();
			Store store = storeService.find(storeId);
			storeProductCategory.setStore(store);
			storeProductCategory.setId(storeProductCategoryId);
		}
		Brand brand = brandService.find(brandId);
		Promotion promotion = promotionService.find(promotionId);
		ProductTag productTag = productTagService.find(productTagId);

		if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
			BigDecimal tempPrice = startPrice;
			startPrice = endPrice;
			endPrice = tempPrice;
		}

		Pageable pageable = new Pageable(pageNumber, pageSize);
		model.addAttribute("orderTypes", Product.OrderType.values());
		model.addAttribute("type", type);
		model.addAttribute("storeType", storeType);
		model.addAttribute("storeProductCategory", storeProductCategory);
		model.addAttribute("brand", brand);
		model.addAttribute("promotion", promotion);
		model.addAttribute("productTag", productTag);
		model.addAttribute("promotionPluginId", promotionPluginId);
		model.addAttribute("startPrice", startPrice);
		model.addAttribute("endPrice", endPrice);
		model.addAttribute("isOutOfStock", isOutOfStock);
		model.addAttribute("orderType", orderType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentUser", CurrentUser);
		if(storeId != null && storeId > 0) {
			model.addAttribute("page", productService.findPage(type, storeType, storeProductCategory.getStore(), null, null, brand, promotion, productTag, null, null, promotionPluginId, startPrice, endPrice, true, true, null, null, true, isOutOfStock, null, null, orderType, pageable, null));

		}else {
			model.addAttribute("page", productService.findPage(type, storeType, null, null, storeProductCategory, brand, promotion, productTag, null, null, promotionPluginId, startPrice, endPrice, true, true, null, null, true, isOutOfStock, null, null, orderType, pageable, null));
		}
		return "shop/product/list";
	}

	/**
	 * 列表
	 */
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@JsonView(BaseEntity.BaseView.class)
	public ResponseEntity<?> list(Long productCategoryId, Product.Type type, Long storeProductCategoryId, Long brandId, Long promotionId, Long productTagId, String promotionPluginId, BigDecimal startPrice, BigDecimal endPrice, Product.OrderType orderType, Integer pageNumber, Integer pageSize,
			HttpServletRequest request,Long storeId) {
		ProductCategory productCategory = productCategoryService.find(productCategoryId);
		StoreProductCategory storeProductCategory = null;
		if(storeProductCategoryId != null) {
			storeProductCategory = storeProductCategoryService.find(storeProductCategoryId);
			if(storeProductCategory == null && storeId > 0) {
				storeProductCategory = new StoreProductCategory();
				Store store = storeService.find(storeId);
				storeProductCategory.setStore(store);
				storeProductCategory.setId(storeProductCategoryId);
			}
		}
		Brand brand = brandService.find(brandId);
		Promotion promotion = promotionService.find(promotionId);
		ProductTag productTag = productTagService.find(productTagId);
		Map<Attribute, String> attributeValueMap = new HashMap<>();
		if (productCategory != null) {
			Set<Attribute> attributes = productCategory.getAttributes();
			if (CollectionUtils.isNotEmpty(attributes)) {
				for (Attribute attribute : attributes) {
					String value = request.getParameter("attribute_" + attribute.getId());
					String attributeValue = attributeService.toAttributeValue(attribute, value);
					if (attributeValue != null) {
						attributeValueMap.put(attribute, attributeValue);
					}
				}
			}
		}

		if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
			BigDecimal tempPrice = startPrice;
			startPrice = endPrice;
			endPrice = tempPrice;
		}
		Pageable pageable = new Pageable(pageNumber, pageSize);
		Page<Product> findPage =  null;
		if(storeId != null && storeId > 0) {
			findPage = productService.findPage(type, null, storeProductCategory.getStore(), null, null, brand, promotion, productTag, null, null, promotionPluginId, startPrice, endPrice, true, true, null, null, true, null, null, null, orderType, pageable, null);	
		}else {
			findPage = productService.findPage(type, null, null, productCategory, storeProductCategory, brand, promotion, productTag, null, attributeValueMap, promotionPluginId, startPrice, endPrice, true, true, null, null, true, null, null, null, orderType, pageable, null);
		}

		
		return ResponseEntity.ok(findPage.getContent());
	}

	/**
	 * 搜索输入页面
	 */
	@GetMapping("/search_input")
	public String searchInput(ModelMap model) {
		return "shop/product/search_input";
	}

	/**
	 * 搜索
	 */
	@GetMapping("/search")
	public String search(String keyword, Store.Type storeType, Long storeId, Boolean isOutOfStock, BigDecimal startPrice, BigDecimal endPrice, Product.OrderType orderType, Integer pageNumber, Integer pageSize, ModelMap model) {
		if (StringUtils.isEmpty(keyword)) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
			BigDecimal tempPrice = startPrice;
			startPrice = endPrice;
			endPrice = tempPrice;
		}
		Store store = storeService.find(storeId);

		Pageable pageable = new Pageable(pageNumber, pageSize);
		model.addAttribute("orderTypes", Product.OrderType.values());
		model.addAttribute("productKeyword", keyword);
		model.addAttribute("storeType", storeType);
		model.addAttribute("store", store);
		model.addAttribute("isOutOfStock", isOutOfStock);
		model.addAttribute("startPrice", startPrice);
		model.addAttribute("endPrice", endPrice);
		model.addAttribute("orderType", orderType);
		model.addAttribute("searchType", "PRODUCT");
		model.addAttribute("page", productService.search(keyword, null, storeType, store, isOutOfStock, null, startPrice, endPrice, orderType, pageable));
		return "shop/product/search";
	}

	/**
	 * 搜索
	 */
	@GetMapping(path = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@JsonView(BaseEntity.BaseView.class)
	public ResponseEntity<?> search(String keyword, Long storeId, BigDecimal startPrice, BigDecimal endPrice, Product.OrderType orderType, Integer pageNumber, Integer pageSize) {
		if (StringUtils.isEmpty(keyword)) {
			return Results.NOT_FOUND;
		}

		if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
			BigDecimal tempPrice = startPrice;
			startPrice = endPrice;
			endPrice = tempPrice;
		}
		Store store = storeService.find(storeId);

		Pageable pageable = new Pageable(pageNumber, pageSize);
		return ResponseEntity.ok(productService.search(keyword, null, null, store, null, null, startPrice, endPrice, orderType, pageable).getContent());
	}
	/**
	 * 索取样品
	 */
	@PostMapping("/applySample")
	public ResponseEntity<?> applySample(Long productId,Sample sample,@CurrentUser Member CurrentUser){
		if (!isValid(sample, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		//以商品id获取商品
		Product find = productService.find(productId);
		
		sample.setProduct(find);
		sample.setStore(find.getStore());
		sample.setMemberUser(CurrentUser);
		
		sampleService.save(sample);
		
		return Results.OK;
		
	}
	/**
	 * 对比
	 */
	@GetMapping("/compare")
	public String compare(Long[] productIds, ModelMap model) {
		
		DxncsParam dxncsParamEntity = new DxncsParam();
		ProductParam ProductParamEntity = new ProductParam();
		
		
		if (ArrayUtils.isEmpty(productIds) || productIds.length > MAX_COMPARE_PRODUCT_COUNT) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		List<Product> products = productService.findList(productIds);
		CollectionUtils.filter(products, new Predicate() {
			@Override
			public boolean evaluate(Object obj) {
				Product product = (Product) obj;
				return BooleanUtils.isTrue(product.getIsActive()) && BooleanUtils.isTrue(product.getIsMarketable());
			}
		});
		if (CollectionUtils.isEmpty(products)) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}
		/**
		 * 获取参数对比项
		 */
		if(products.size()>0) {
			//定义参数数组
			int dxncsParam[] = new int[products.size()];
			int qthjzbParam[] = new int[products.size()];
			int csjdzdParam[] = new int[products.size()];
			for(int i=0;i<products.size();i++) {
				List<ProductParam> arr =new ArrayList<ProductParam>();
				List<ProductParam> array = new ArrayList<ProductParam>();
				//获取参数个数
				int dxncsParams = products.get(i).getDxncsParams().size();
				dxncsParam[i]=dxncsParams;
				List<ProductParam> qthjzbParams = products.get(i).getQthjzbParams();
				for(int j=0;j<qthjzbParams.size();j++) {
					String name = qthjzbParams.get(j).getType().name();
					if("QTHJSYXZB".equals(name)) {
						arr.add(qthjzbParams.get(i));
					}
				}
				int size = arr.size();
				if(size!=0) {
					qthjzbParam[i]=size;
				}
				List<ProductParam> csjdzdParams = products.get(i).getCsjdzdParams();
				for(int j=0;j<csjdzdParams.size();j++) {
					String name = csjdzdParams.get(j).getType().name();
					if("CSJDZDEDZ".equals(name)) {
						array.add(csjdzdParams.get(i));
					}
				}
				int size2 = array.size();
				if(size2!=0) {
					csjdzdParam[i]=size2;
				}
			}
			
			//对比参数个数取出最大的数据的下标
			int dxncsParamIndex = maxIndex(dxncsParam);
			int qthjzbParamIndex = maxIndex(qthjzbParam);
			int csjdzdParamIndex = maxIndex(csjdzdParam);
			
			//循环获取数据添加参数最大值
			for(int i=0;i<products.size();i++) {
				//获取参数个数
				int dxncsParams = products.get(i).getDxncsParams().size();
				int qthjzbParams = products.get(i).getQthjzbParams().size();
				int csjdzdParams = products.get(i).getCsjdzdParams().size();
				
				if(dxncsParams != dxncsParamIndex) {
					products.get(i).getDxncsParams().add(dxncsParamEntity);
				}
				if(qthjzbParams!=qthjzbParamIndex) {
					ProductParamEntity.setType(ProductParam.Type.QTHJSYXZB);
					products.get(i).getQthjzbParams().add(ProductParamEntity);
				}
				if(csjdzdParams!=csjdzdParamIndex) {
					ProductParamEntity.setType(ProductParam.Type.CSJDZDEDZ);
					products.get(i).getCsjdzdParams().add(ProductParamEntity);
				}
			}
		}
		model.addAttribute("products", products);
		return "shop/product/compare";
	}
	/**
	 * 获取需要认证的商品 检测机构
	 */
	@GetMapping("/check_company")
	public String checkCompany(ModelMap model,@CurrentUser Member currentUser,Pageable pageable) {
		
		//以用户id获获取机构
		List<MechanismStore> findStoreId = mechanismStoreService.findStoreId(currentUser);
		if(findStoreId.size()>0) {
			MechanismStore mechanismStore = findStoreId.get(0);
			//以mechanismStore id 获取检测机构所要检测的商品
			Page<Product> findPageStoreId = productService.findPageStoreId(pageable, mechanismStore, null);
			model.addAttribute("page", findPageStoreId);
			model.addAttribute("storeId", mechanismStore);
		}
		model.addAttribute("currentUser", currentUser);
		return "member/authentication/list";
	}
	/**
	 * 获取需要认证的商品 标准机构
	 */
	@GetMapping("/standard_company")
	public String standardCompany(ModelMap model,@CurrentUser Member currentUser,Pageable pageable) {
		
		//以用户id获获取机构
		List<MechanismStore> findStoreId = mechanismStoreService.findStoreId(currentUser);
		if(findStoreId.size()>0) {
			MechanismStore mechanismStore = findStoreId.get(0);
			//以mechanismStore id 获取检测机构所要检测的商品
			Page<Product> findPageStoreId = productService.findPageStoreId(pageable, null, mechanismStore);
			
			model.addAttribute("page", findPageStoreId);
			model.addAttribute("storeId", mechanismStore);
			
		}
		model.addAttribute("currentUser", currentUser);
		return "member/authentication/standard_company";
	}
	/**
	 * 认证 (标准机构)
	 */
	@PostMapping("/shenhe")
	public ResponseEntity<?> shenhe(Long id,Boolean passed,HttpServletRequest req, HttpServletResponse resp) {
		
		String realPath = req.getServletContext().getRealPath("/");
		
		String absPath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/"; 
		
		//以用户id获获取机构
		Product find = productService.find(id);
		
		//水印图片
		String url = "";
		//低层图片
		if(passed) {
			//以id获取机构
			MechanismStore find2 = mechanismStoreService.find(find.getBzstore().getId());
			url = find2.getImage();
		}
		String replace2 = url.replace(absPath, realPath);
		//获取商品图片
		List<ProductImage> productImages = find.getProductImages();
		if(productImages.size()>0) {
			for(int i=0;i<productImages.size();i++) {
				ProductImage productImage = productImages.get(i);
				String productImg = productImage.getThumbnail();
				//获取原图
				String source = productImage.getSource();
				//获取大图
				String large = productImage.getLarge();
				//获取中图
				String medium = productImage.getMedium();
				
				String new_productImg = productImg.replace(absPath, realPath);
				String source_replace = source.replace(absPath, realPath);
				String large_replace = large.replace(absPath, realPath);
				String medium_replace = medium.replace(absPath, realPath);
				
				if(find.getIsverify()) {
					ImageUtils.addWatermark(new File(new_productImg), new File(new_productImg), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(source_replace), new File(source_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(large_replace), new File(large_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(medium_replace), new File(medium_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
				}else {
					ImageUtils.addWatermark(new File(new_productImg), new File(new_productImg), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(source_replace), new File(source_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(large_replace), new File(large_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(medium_replace), new File(medium_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
				}
			}
		}
		
		find.setIsbzverify(passed);
		
		productService.update(find);
		
		return Results.OK;
	}
	
	/**
	 * 认证 (检测机构)
	 */
	@PostMapping("/jcshenhe")
	public ResponseEntity<?> jcshenhe(Long id,Boolean passed,HttpServletRequest req, HttpServletResponse resp) {
		
		String realPath = req.getServletContext().getRealPath("/");
		
		String absPath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/"; 
		
		//以用户id获获取机构
		Product find = productService.find(id);
		
		//水印图片
		String url = "";
		//低层图片
		if(passed) {
			//以id获取机构
			MechanismStore find2 = mechanismStoreService.find(find.getJcstore().getId());
			url = find2.getImage();
		}
		String replace2 = url.replace(absPath, realPath);
		//获取商品图片
		List<ProductImage> productImages = find.getProductImages();
		if(productImages.size()>0) {
			for(int i=0;i<productImages.size();i++) {
				ProductImage productImage = productImages.get(i);
				String productImg = productImage.getThumbnail();
				//获取原图
				String source = productImage.getSource();
				//获取大图
				String large = productImage.getLarge();
				//获取中图
				String medium = productImage.getMedium();
				
				String new_productImg = productImg.replace(absPath, realPath);
				String source_replace = source.replace(absPath, realPath);
				String large_replace = large.replace(absPath, realPath);
				String medium_replace = medium.replace(absPath, realPath);
				
				if(find.getIsbzverify()) {
					ImageUtils.addWatermark(new File(new_productImg), new File(new_productImg), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(source_replace), new File(source_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(large_replace), new File(large_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
					ImageUtils.addWatermark(new File(medium_replace), new File(medium_replace), new File(replace2), Setting.WatermarkPosition.BE_JUXTAPOSED, 100);
				}else {
					ImageUtils.addWatermark(new File(new_productImg), new File(new_productImg), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(source_replace), new File(source_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(large_replace), new File(large_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
					ImageUtils.addWatermark(new File(medium_replace), new File(medium_replace), new File(replace2), Setting.WatermarkPosition.TOP_LEFT, 100);
				}
			}
		}
		
		find.setIsverify(passed);
		
		productService.update(find);
		
		return Results.OK;
	}

	/**
	 * 点击数
	 */
	@GetMapping("/hits/{productId}")
	public @ResponseBody Long hits(@PathVariable Long productId) {
		if (productId == null) {
			return 0L;
		}

		return productService.viewHits(productId);
	}

	/**
	 * 已参团人数
	 */
	@GetMapping("/participants/{groupBuyingId}")
	public @ResponseBody Long participants(@PathVariable Long groupBuyingId) {
		if (groupBuyingId == null) {
			return 0L;
		}

		return groupBuyingService.getParticipants(groupBuyingId);
	}
	public static int maxIndex(int[] arr) {
		if(arr.length>0) {
			int max = 0;
			int maxIndex = 0;
			for (int i = 0; i < arr.length; i++) {
				if (arr[i] > max) {
					max = arr[i];
					maxIndex = i;
				}
			}
			return max;
		}
		return 0;
		
	 }
	//获取所有的店铺下的数据
	@GetMapping("/listAll")
	public String listAll(Long storeId) {
		
		Store store = storeService.find(storeId);
		
		//根据店铺获取商品
		List<Product> findList = productService.findList(null, store, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
		for(int i = 0 ; i < findList.size() ; i++) {
			Product product = findList.get(i);
			
			//获取商品的分类
			ProductCategory productCategory = product.getProductCategory();
			if(null!=productCategory && null!=productCategory.getId()) {
				//以分类id获取分类
				//ProductCategory find = productCategoryService.find(productCategory.getId());
				if(StringUtils.isNotEmpty(productCategory.getTreePath())) {
					StoreProductCategory storeProductCategory = new StoreProductCategory();
					storeProductCategory.setStore(store);
					storeProductCategory.setName(productCategory.getName());
					StoreProductCategory saveStoreProductCategory = storeProductCategoryService.saveStoreProductCategory(productCategory,storeProductCategory);
					if(null == saveStoreProductCategory) {
						List<StoreProductCategory> findName = storeProductCategoryService.findName(storeProductCategory,null);
						if(findName.size()>0) {
							product.setStoreProductCategory(findName.get(0));
						}
					}else {
						product.setStoreProductCategory(saveStoreProductCategory);
					}
				}
				
			}
			//更新商品的店铺分类
			productService.update(product);
		}
		return null;
		
	}
}