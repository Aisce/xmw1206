/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: mkM2Gd4/5EwOwk32qjIfY9govjsxYgbM
 */
package net.shopxx.controller.business;

import net.shopxx.FileType;
import net.shopxx.Filter;
import net.shopxx.Pageable;
import net.shopxx.Results;
import net.shopxx.entity.*;
import net.shopxx.exception.UnauthorizedException;
import net.shopxx.security.CurrentStore;
import net.shopxx.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Controller - 商品
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Controller("businessProductController")
@RequestMapping("/business/product")
public class ProductController extends BaseController {

	@Inject
	private ProductService productService;
	@Inject
	private SkuService skuService;
	@Inject
	private StoreService storeService;
	@Inject
	private ProductCategoryService productCategoryService;
	@Inject
	private DxncsParamService dxncsParamService;
	@Inject
	private ProductParamService productParamService;
	@Inject
	private StoreProductCategoryService storeProductCategoryService;
	@Inject
	private BrandService brandService;
	@Inject
	private PromotionService promotionService;
	@Inject
	private ProductTagService productTagService;
	@Inject
	private StoreProductTagService storeProductTagService;
	@Inject
	private ProductImageService productImageService;
	@Inject
	private ParameterValueService parameterValueService;
	@Inject
	private SpecificationItemService specificationItemService;
	@Inject
	private AttributeService attributeService;
	@Inject
	private SpecificationService specificationService;
	@Inject
	private FileService fileService;
	@Inject
	private MechanismStoreService mechanismStoreService;

	/**
	 * 添加属性
	 */
	@ModelAttribute
	public void populateModel(Long productId, Long productCategoryId, @CurrentStore Store currentStore, ModelMap model) {
		Product product = productService.find(productId);
		if (product != null && !currentStore.equals(product.getStore())) {
			throw new UnauthorizedException();
		}
		ProductCategory productCategory = productCategoryService.find(productCategoryId);
		if (productCategory != null && !storeService.productCategoryExists(currentStore, productCategory)) {
			throw new UnauthorizedException();
		}

		model.addAttribute("product", product);
		model.addAttribute("productCategory", productCategory);
	}

	/**
	 * 检查编号是否存在
	 */
	@GetMapping("/check_sn")
	public @ResponseBody boolean checkSn(String sn) {
		return StringUtils.isNotEmpty(sn) && !productService.snExists(sn);
	}

	/**
	 * 上传商品图片
	 */
	@PostMapping("/upload_product_image")
	public ResponseEntity<?> uploadProductImage(MultipartFile file) {
		if (file == null || file.isEmpty()) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (!fileService.isValid(FileType.IMAGE, file)) {
			return Results.unprocessableEntity("common.upload.invalid");
		}
		ProductImage productImage = productImageService.generate(file);
		if (productImage == null) {
			return Results.unprocessableEntity("common.upload.error");
		}
		return ResponseEntity.ok(productImage);
	}
	
	/**
	 * 上传典型应用电路图片
	 */
	@PostMapping("/upload_dxyydl_image")
	public ResponseEntity<?> uploadDxyydlImage(MultipartFile file) {
		if (file == null || file.isEmpty()) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (!fileService.isValid(FileType.IMAGE, file)) {
			return Results.unprocessableEntity("common.upload.invalid");
		}
		ProductImage productImage = productImageService.generate(file);
		if (productImage == null) {
			return Results.unprocessableEntity("common.upload.error");
		}
		return ResponseEntity.ok(productImage);
	}
	
	/**
	 * 上传文件
	 */
	@PostMapping("/upload_file")
	public ResponseEntity<?> uploadFile(MultipartFile file) {
		if (file == null || file.isEmpty()) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (!fileService.isValid(FileType.IMAGE, file)) {
			return Results.unprocessableEntity("common.upload.invalid");
		}
		ProductFile productFile = productImageService.generateFile(file);
		if (productFile == null) {
			return Results.unprocessableEntity("common.upload.error");
		}
		return ResponseEntity.ok(productFile);
	}

	/**
	 * 删除商品图片
	 */
	@PostMapping("/delete_product_image")
	public ResponseEntity<?> deleteProductImage() {
		return Results.OK;
	}
	
	/**
	 * 删除商品文件
	 */
	@PostMapping("/delete_file")
	public ResponseEntity<?> deleteFile() {
		return Results.OK;
	}
	
	/**
	 * 删除典型应用电路图片
	 */
	@PostMapping("/delete_dxyydl_image")
	public ResponseEntity<?> deleteDxyydlImage() {
		return Results.OK;
	}

	/**
	 * 获取参数
	 */
	@GetMapping("/parameters")
	public @ResponseBody List<Map<String, Object>> parameters(@ModelAttribute(binding = false) ProductCategory productCategory) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (productCategory == null || CollectionUtils.isEmpty(productCategory.getParameters())) {
			return data;
		}
		for (Parameter parameter : productCategory.getParameters()) {
			Map<String, Object> item = new HashMap<>();
			item.put("group", parameter.getGroup());
			item.put("names", parameter.getNames());
			data.add(item);
		}
		return data;
	}
	
	/**
	 * 获取电性能预置参数
	 */
	@GetMapping("/dxn_params")
	public @ResponseBody List<Map<String, Object>> dxnParams(@ModelAttribute(binding = false) ProductCategory productCategory) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (productCategory == null || CollectionUtils.isEmpty(productCategory.getParameters())) {
			return data;
		}
		for (Parameter parameter : productCategory.getParameters()) {
			Map<String, Object> item = new HashMap<>();
			if (parameter.getGroup().equals("电性能参数")) { // 电性能预置参数
				item.put("group", parameter.getGroup());
				item.put("names", parameter.getNames());
				data.add(item);
				break;
			}
		}
		return data;
	}

	/**
	 * 获取属性
	 */
	@GetMapping("/attributes")
	public @ResponseBody List<Map<String, Object>> attributes(@ModelAttribute(binding = false) ProductCategory productCategory) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (productCategory == null || CollectionUtils.isEmpty(productCategory.getAttributes())) {
			return data;
		}
		for (Attribute attribute : productCategory.getAttributes()) {
			Map<String, Object> item = new HashMap<>();
			item.put("id", attribute.getId());
			item.put("name", attribute.getName());
			item.put("options", attribute.getOptions());
			data.add(item);
		}
		return data;
	}

	/**
	 * 获取规格
	 */
	@GetMapping("/specifications")
	public @ResponseBody List<Map<String, Object>> specifications(@ModelAttribute(binding = false) ProductCategory productCategory) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (productCategory == null || CollectionUtils.isEmpty(productCategory.getSpecifications())) {
			return data;
		}
		for (Specification specification : productCategory.getSpecifications()) {
			Map<String, Object> item = new HashMap<>();
			item.put("name", specification.getName());
			item.put("options", specification.getOptions());
			data.add(item);
		}
		return data;
	}

	/**
	 * 添加
	 */
	@GetMapping("/add")
	public String add(@CurrentStore Store currentStore, ModelMap model) {
		model.addAttribute("maxProductImageSize", Product.MAX_PRODUCT_IMAGE_SIZE);
		model.addAttribute("maxParameterValueSize", Product.MAX_PARAMETER_VALUE_SIZE);
		model.addAttribute("maxParameterValueEntrySize", ParameterValue.MAX_ENTRY_SIZE);
		model.addAttribute("maxSpecificationItemSize", Product.MAX_SPECIFICATION_ITEM_SIZE);
		model.addAttribute("maxSpecificationItemEntrySize", SpecificationItem.MAX_ENTRY_SIZE);
		model.addAttribute("types", Product.Type.values());
		model.addAttribute("productCategoryTree", productCategoryService.findTree());
		model.addAttribute("allowedProductCategories", productCategoryService.findList(currentStore, null, null, null));
		model.addAttribute("allowedProductCategoryParents", getAllowedProductCategoryParents(currentStore));
		model.addAttribute("storeProductCategoryTree", storeProductCategoryService.findTree(currentStore));
		model.addAttribute("brands", brandService.findAll());
		model.addAttribute("promotions", promotionService.findList(null, currentStore, true));
		model.addAttribute("productTags", productTagService.findAll());
		model.addAttribute("storeProductTags", storeProductTagService.findList(currentStore, true));
		model.addAttribute("specifications", specificationService.findAll());
		model.addAttribute("store", currentStore);
		return "business/product/add";
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public ResponseEntity<?> save(@ModelAttribute(name = "productForm") Product productForm, @ModelAttribute(binding = false) ProductCategory productCategory, SkuForm skuForm, SkuListForm skuListForm, Long brandId, Long[] promotionIds, Long[] productTagIds, Long[] storeProductTagIds,
			Long storeProductCategoryId, HttpServletRequest request, @CurrentStore Store currentStore,HttpServletResponse resp) {
		
		if(null!=productForm && productForm.getKkxsybgFiles().size()>0) {
			List<ProductFile> kkxsybgFiles = productForm.getKkxsybgFiles();
			for(int i=0;i<kkxsybgFiles.size();i++) {
				String source = kkxsybgFiles.get(i).getSource();
				if(StringUtils.isEmpty(source)) {
					kkxsybgFiles.remove(i);
				}
			}
		}
		
		productImageService.filter(productForm.getProductImages());
		productImageService.filter(productForm.getDxyydlImages());
		parameterValueService.filter(productForm.getParameterValues());
		dxncsParamService.filter(productForm.getDxncsParams());
		productParamService.filter(productForm.getQthjzbParams());
		productParamService.filter(productForm.getCsjdzdParams());
		productParamService.filter(productForm.getTjgzcsParams());
		productParamService.filter(productForm.getJrgwParams());
		specificationItemService.filter(productForm.getSpecificationItems());
		skuService.filter(skuListForm.getSkuList());

		Long productCount = productService.count(null, currentStore, null, null, null, null, null, null);
		if (currentStore.getStoreRank() != null && currentStore.getStoreRank().getQuantity() != null && productCount >= currentStore.getStoreRank().getQuantity()) {
			return Results.unprocessableEntity("business.product.addCountNotAllowed", currentStore.getStoreRank().getQuantity());
		}
		if (productCategory == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (storeProductCategoryId != null) {
			StoreProductCategory storeProductCategory = storeProductCategoryService.find(storeProductCategoryId);
			if (storeProductCategory == null || !currentStore.equals(storeProductCategory.getStore())) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productForm.setStoreProductCategory(storeProductCategory);
		}
		
		productCount++;
		
		// 本店铺产品数
		String number = "";
		if (productCount < 10) {
			number = "00000" + productCount;
		} else if (productCount < 100) {
			number = "0000" + productCount;
		} else if (productCount < 1000) {
			number = "000" + productCount;
		} else if (productCount < 10000) {
			number = "00" + productCount;
		} else if (productCount < 100000) {
			number = "0" + productCount;
		} else {
			number = "" + productCount;
		}
		//判断编号是否存在
		boolean snExists = productService.snExists(currentStore.getNumber() + "-" + productCategory.getNumber() + "-" + number);
		if(snExists) {
			//获取本分类中最新产品
			List<Product> findList2 = productService.findList(null, currentStore, productCategory, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
			//获取第一条数据
			Product product2 = findList2.get(0);
			//以-分割字符串
			String[] split = product2.getSn().split("-");
			
			int parseInt = Integer.parseInt(split[2]);
			int code = parseInt + 1;
			
			String str = "";
			
			if (code < 10) {
				str = "00000" + code;
			} else if (code < 100) {
				str = "0000" + code;
			} else if (code < 1000) {
				str = "000" + code;
			} else if (code < 10000) {
				str = "00" + code;
			} else if (code < 100000) {
				str = "0" + code;
			} else {
				str = "" + code;
			}
			
			productForm.setSn(currentStore.getNumber() + "-" + productCategory.getNumber() + "-" + str);
			
		}else {
			productForm.setSn(currentStore.getNumber() + "-" + productCategory.getNumber() + "-" + number);
		}
		// 厂家编码（6位）-产品分类编码（6位）- 产品数
		productForm.setCount(productCount);
		productForm.setIstjverify(false);
		productForm.setIsverify(false);
		productForm.setIsbzverify(false);
		productForm.setStore(currentStore);
		productForm.setProductCategory(productCategory);
		productForm.setBrand(brandService.find(brandId));
		productForm.setPromotions(new HashSet<>(promotionService.findList(promotionIds)));
		productForm.setProductTags(new HashSet<>(productTagService.findList(productTagIds)));
		productForm.setStoreProductTags(new HashSet<>(storeProductTagService.findList(storeProductTagIds)));
		productForm.setIsFine(false);
		productForm.setIsHot(false);

		productForm.removeAttributeValue();
		for (Attribute attribute : productForm.getProductCategory().getAttributes()) {
			String value = request.getParameter("attribute_" + attribute.getId());
			String attributeValue = attributeService.toAttributeValue(attribute, value);
			productForm.setAttributeValue(attribute, attributeValue);
		}
		
		if (!isValid(productForm, BaseEntity.Save.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (StringUtils.isNotEmpty(productForm.getSn()) && productService.snExists(productForm.getSn())) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		//获取商品分类id
		if(null!=productCategory && null!=productCategory.getId()) {
			//以分类id获取分类
			//ProductCategory find = productCategoryService.find(productCategory.getId());
			if(StringUtils.isNotEmpty(productCategory.getTreePath())) {
				StoreProductCategory storeProductCategory = new StoreProductCategory();
				storeProductCategory.setStore(currentStore);
				storeProductCategory.setName(productCategory.getName());
				StoreProductCategory saveStoreProductCategory = storeProductCategoryService.saveStoreProductCategory(productCategory,storeProductCategory);
				if(null == saveStoreProductCategory) {
					List<StoreProductCategory> findName = storeProductCategoryService.findName(storeProductCategory,null);
					if(findName.size()>0) {
						productForm.setStoreProductCategory(findName.get(0));
					}
				}else {
					productForm.setStoreProductCategory(saveStoreProductCategory);
				}
			}
			
		}
		if (productForm.hasSpecification()) {
			List<Sku> skus = skuListForm.getSkuList();
			if (CollectionUtils.isEmpty(skus) || !isValid(skus, getValidationGroup(productForm.getType()), BaseEntity.Save.class)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productService.create(productForm, skus);
		} else {
			Sku sku = skuForm.getSku();
			if (sku == null || !isValid(sku, getValidationGroup(productForm.getType()), BaseEntity.Save.class)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productService.create(productForm, sku);
		}
		
		dxncsParamService.save(productForm.getId(), productForm.getDxncsParams());
		productParamService.save(productForm.getId(), productForm.getQthjzbParams(), ProductParam.Type.QTHJSYXZB);
		productParamService.save(productForm.getId(), productForm.getCsjdzdParams(), ProductParam.Type.CSJDZDEDZ);
		productParamService.save(productForm.getId(), productForm.getTjgzcsParams(), ProductParam.Type.TJGZCS);
		productParamService.save(productForm.getId(), productForm.getJrgwParams(), ProductParam.Type.JRGWXH);

		return Results.OK;
	}

	/**
	 * 编辑
	 */
	@GetMapping("/edit")
	public String edit(@ModelAttribute(binding = false) Product product, @CurrentStore Store currentStore, ModelMap model) {
		if (product == null) {
			return UNPROCESSABLE_ENTITY_VIEW;
		}

		model.addAttribute("maxProductImageSize", Product.MAX_PRODUCT_IMAGE_SIZE);
		model.addAttribute("maxParameterValueSize", Product.MAX_PARAMETER_VALUE_SIZE);
		model.addAttribute("maxParameterValueEntrySize", ParameterValue.MAX_ENTRY_SIZE);
		model.addAttribute("maxSpecificationItemSize", Product.MAX_SPECIFICATION_ITEM_SIZE);
		model.addAttribute("maxSpecificationItemEntrySize", SpecificationItem.MAX_ENTRY_SIZE);
		model.addAttribute("types", Product.Type.values());
		model.addAttribute("productCategoryTree", productCategoryService.findTree());
		model.addAttribute("allowedProductCategories", productCategoryService.findList(currentStore, null, null, null));
		model.addAttribute("allowedProductCategoryParents", getAllowedProductCategoryParents(currentStore));
		model.addAttribute("storeProductCategoryTree", storeProductCategoryService.findTree(currentStore));
		model.addAttribute("brands", brandService.findAll());
		model.addAttribute("promotions", promotionService.findList(null, currentStore, true));
		model.addAttribute("productTags", productTagService.findAll());
		model.addAttribute("storeProductTags", storeProductTagService.findList(currentStore, true));
		model.addAttribute("specifications", specificationService.findAll());
		
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
		
		model.addAttribute("product", product);
		return "business/product/edit";
	}

	/**
	 * 更新
	 */
	@PostMapping("/update")
	public ResponseEntity<?> update(@ModelAttribute("productForm") Product productForm, @ModelAttribute(binding = false) Product product, @ModelAttribute(binding = false) ProductCategory productCategory, SkuForm skuForm, SkuListForm skuListForm, Long brandId, Long[] promotionIds,
			Long[] productTagIds, Long[] storeProductTagIds, Long storeProductCategoryId, HttpServletRequest request, @CurrentStore Store currentStore) {
		productImageService.filter(productForm.getProductImages());
		productImageService.filter(productForm.getDxyydlImages());
		parameterValueService.filter(productForm.getParameterValues());
		dxncsParamService.filter(productForm.getDxncsParams());
		productParamService.filter(productForm.getQthjzbParams());
		productParamService.filter(productForm.getCsjdzdParams());
		productParamService.filter(productForm.getTjgzcsParams());
		productParamService.filter(productForm.getJrgwParams());
		specificationItemService.filter(productForm.getSpecificationItems());
		skuService.filter(skuListForm.getSkuList());
		if (product == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		if (productCategory == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		List<Promotion> promotions = promotionService.findList(promotionIds);
		if (CollectionUtils.isNotEmpty(promotions)) {
			if (currentStore.getPromotions() == null || !currentStore.getPromotions().containsAll(promotions)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
		}
		if (storeProductCategoryId != null) {
			StoreProductCategory storeProductCategory = storeProductCategoryService.find(storeProductCategoryId);
			if (storeProductCategory == null || !currentStore.equals(storeProductCategory.getStore())) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productForm.setStoreProductCategory(storeProductCategory);
		}
		productForm.setId(product.getId());
		productForm.setIstjverify(false);
		productForm.setIsverify(false);
		productForm.setIsbzverify(false);
		productForm.setType(product.getType());
		productForm.setIsActive(true);
		productForm.setIsFine(product.getIsFine());
		productForm.setIsHot(product.getIsHot());
		productForm.setProductCategory(productCategory);
		productForm.setBrand(brandService.find(brandId));
		productForm.setPromotions(new HashSet<>(promotions));
		productForm.setProductTags(new HashSet<>(productTagService.findList(productTagIds)));
		productForm.setStoreProductTags(new HashSet<>(storeProductTagService.findList(storeProductTagIds)));

		productForm.removeAttributeValue();
		for (Attribute attribute : productForm.getProductCategory().getAttributes()) {
			String value = request.getParameter("attribute_" + attribute.getId());
			String attributeValue = attributeService.toAttributeValue(attribute, value);
			productForm.setAttributeValue(attribute, attributeValue);
		}

		if (!isValid(productForm, BaseEntity.Update.class)) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		
		if (productForm.hasSpecification()) {
			List<Sku> skus = skuListForm.getSkuList();
			if (CollectionUtils.isEmpty(skus) || !isValid(skus, getValidationGroup(productForm.getType()), BaseEntity.Update.class)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productService.modify(productForm, skus);
		} else {
			Sku sku = skuForm.getSku();
			if (sku == null || !isValid(sku, getValidationGroup(productForm.getType()), BaseEntity.Update.class)) {
				return Results.UNPROCESSABLE_ENTITY;
			}
			productService.modify(productForm, sku);
		}
		
		dxncsParamService.removeByProduct(product.getId());
		dxncsParamService.save(productForm.getId(), product.getDxncsParams());
		productParamService.removeByProduct(product.getId());
		productParamService.save(productForm.getId(), product.getQthjzbParams(), ProductParam.Type.QTHJSYXZB);
		productParamService.save(productForm.getId(), product.getCsjdzdParams(), ProductParam.Type.CSJDZDEDZ);
		productParamService.save(productForm.getId(), product.getTjgzcsParams(), ProductParam.Type.TJGZCS);
		productParamService.save(productForm.getId(), product.getJrgwParams(), ProductParam.Type.JRGWXH);

		return Results.OK;
	}

	/**
	 * 列表
	 */
	@GetMapping("/list")
	public String list(@ModelAttribute(binding = false) ProductCategory productCategory, Product.Type type, Long brandId, Long promotionId, Long productTagId, Long storeProductTagId, Boolean isFine, Boolean isHot, Boolean isActive, Boolean isMarketable, Boolean isList, Boolean isTop, Boolean isOutOfStock, Boolean isStockAlert,
			Pageable pageable, @CurrentStore Store currentStore, ModelMap model) {
		Brand brand = brandService.find(brandId);
		Promotion promotion = promotionService.find(promotionId);
		ProductTag productTag = productTagService.find(productTagId);
		StoreProductTag storeProductTag = storeProductTagService.find(storeProductTagId);
		if (promotion != null) {
			if (!currentStore.equals(promotion.getStore())) {
				return UNPROCESSABLE_ENTITY_VIEW;
			}
		}
		if (storeProductTag != null) {
			if (!currentStore.equals(storeProductTag.getStore())) {
				return UNPROCESSABLE_ENTITY_VIEW;
			}
		}

		model.addAttribute("types", Product.Type.values());
		model.addAttribute("productCategoryTree", productCategoryService.findTree());
		model.addAttribute("allowedProductCategories", productCategoryService.findList(currentStore, null, null, null));
		model.addAttribute("allowedProductCategoryParents", getAllowedProductCategoryParents(currentStore));
		model.addAttribute("brands", brandService.findAll());
		model.addAttribute("promotions", promotionService.findList(null, currentStore, true));
		model.addAttribute("productTags", productTagService.findAll());
		model.addAttribute("storeProductTags", storeProductTagService.findList(currentStore, true));
		model.addAttribute("type", type);
		model.addAttribute("productCategoryId", productCategory != null ? productCategory.getId() : null);
		model.addAttribute("brandId", brandId);
		model.addAttribute("promotionId", promotionId);
		model.addAttribute("productTagId", productTagId);
		model.addAttribute("storeProductTagId", storeProductTagId);
		model.addAttribute("isMarketable", isMarketable);
		model.addAttribute("isList", isList);
		model.addAttribute("isTop", isTop);
		model.addAttribute("isActive", isActive);
		model.addAttribute("isFine", isFine);
		model.addAttribute("isHot", isHot);
		model.addAttribute("isOutOfStock", isOutOfStock);
		model.addAttribute("isStockAlert", isStockAlert);
		model.addAttribute("page", productService.findPage(type, null, currentStore, productCategory, null, brand, promotion, productTag, storeProductTag, null, null, null, null, isMarketable, isList, isTop, isFine, isActive, isOutOfStock, isStockAlert, null, null, pageable, isHot));
		return "business/product/list";
	}
	/**
	 * 提交审核
	 */
	@PostMapping("/review")
	public ResponseEntity<?> review(Long id,Long bzmechanismId,Long mechanismId) {
		
		Product find = productService.find(id);
		//获取标准化检测机构
		if(null!=bzmechanismId) {
			MechanismStore bzmechanismStore = mechanismStoreService.find(bzmechanismId);
			find.setBzstore(bzmechanismStore);
		}
		if(null!=mechanismId) {
			MechanismStore bzmechanismStore = mechanismStoreService.find(mechanismId);
			find.setJcstore(bzmechanismStore);
		}
		if (find == null) {
			return Results.UNPROCESSABLE_ENTITY;
		}
		find.setIstjverify(true);
		productService.update(find);
		return Results.OK;
	}
	/**
	 * 调转审核页面
	 */
	@GetMapping("/review")
	public String reviewPage(Long id,ModelMap model) {
		Product find = productService.find(id);
		List<MechanismStore> jcList = mechanismStoreService.findList(MechanismStore.Type.CHECK, null, null, null, null);
		List<MechanismStore> bzList = mechanismStoreService.findList(MechanismStore.Type.STANDARDIZATION, null, null, null, null);
		model.addAttribute("find", find);
		model.addAttribute("jcList", jcList);
		model.addAttribute("bzList", bzList);
		return "business/product/review";
	}

	/**
	 * 删除
	 */
	@PostMapping("/delete")
	public ResponseEntity<?> delete(Long[] ids, @CurrentStore Store currentStore) {
		if (ids != null) {
			for (Long id : ids) {
				Product product = productService.find(id);
				if (product == null) {
					return Results.UNPROCESSABLE_ENTITY;
				}
				if (!currentStore.equals(product.getStore())) {
					return Results.UNPROCESSABLE_ENTITY;
				}
				productService.delete(product.getId());
			}
		}
		return Results.OK;
	}

	/**
	 * 上架商品
	 */
	@PostMapping("/shelves")
	public ResponseEntity<?> shelves(Long[] ids, @CurrentStore Store currentStore) {
		if (ids != null) {
			for (Long id : ids) {
				Product product = productService.find(id);
				if (product == null || !currentStore.equals(product.getStore())) {
					return Results.UNPROCESSABLE_ENTITY;
				}
				if (!storeService.productCategoryExists(product.getStore(), product.getProductCategory())) {
					return Results.unprocessableEntity("business.product.marketableNotExistCategoryNotAllowed", product.getName());
				}
			}
			productService.shelves(ids);
		}
		return Results.OK;
	}

	/**
	 * 下架商品
	 */
	@PostMapping("/shelf")
	public ResponseEntity<?> shelf(Long[] ids, @CurrentStore final Store currentStore) {
		if (ids != null) {
			for (Long id : ids) {
				Product product = productService.find(id);
				if (product == null || !currentStore.equals(product.getStore())) {
					return Results.UNPROCESSABLE_ENTITY;
				}
			}
			productService.shelf(ids);
		}
		return Results.OK;
	}
	/**
	 * 检测机构选择
	 */
	@GetMapping("/mechanismStore_select")
	public ResponseEntity<?> mechanismStore_select(String keyword, Integer count) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (StringUtils.isEmpty(keyword)) {
			return ResponseEntity.ok(data);
		}
		List<MechanismStore> search = mechanismStoreService.search(keyword, count,MechanismStore.Type.CHECK);
		for (MechanismStore businesse : search) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", businesse.getId());
			item.put("username", businesse.getName());
			data.add(item);
		}
		return ResponseEntity.ok(data);
	}
	/**
	 * 标准化机构
	 */
	@GetMapping("/mechanismStore_select1")
	public ResponseEntity<?> mechanismStore_select1(String keyword, Integer count) {
		List<Map<String, Object>> data = new ArrayList<>();
		if (StringUtils.isEmpty(keyword)) {
			return ResponseEntity.ok(data);
		}
		List<MechanismStore> search = mechanismStoreService.search(keyword, count,MechanismStore.Type.STANDARDIZATION);
		for (MechanismStore businesse : search) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", businesse.getId());
			item.put("username", businesse.getName());
			data.add(item);
		}
		return ResponseEntity.ok(data);
	}

	/**
	 * 获取允许发布商品分类上级分类
	 * 
	 * @param store
	 *            店铺
	 * @return 允许发布商品分类上级分类
	 */
	private Set<ProductCategory> getAllowedProductCategoryParents(Store store) {
		Assert.notNull(store, "[Assertion failed] - store is required; it must not be null");

		Set<ProductCategory> result = new HashSet<>();
		List<ProductCategory> allowedProductCategories = productCategoryService.findList(store, null, null, null);
		for (ProductCategory allowedProductCategory : allowedProductCategories) {
			result.addAll(allowedProductCategory.getParents());
		}
		return result;
	}

	/**
	 * 根据类型获取验证组
	 * 
	 * @param type
	 *            类型
	 * @return 验证组
	 */
	private Class<?> getValidationGroup(Product.Type type) {
		Assert.notNull(type, "[Assertion failed] - type is required; it must not be null");

		switch (type) {
		case GENERAL:
			return Sku.General.class;
		case EXCHANGE:
			return Sku.Exchange.class;
		case GIFT:
			return Sku.Gift.class;
		}
		return null;
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
		 * @param sku
		 *            SKU
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
		 * @param skuList
		 *            SKU
		 */
		public void setSkuList(List<Sku> skuList) {
			this.skuList = skuList;
		}

	}

}