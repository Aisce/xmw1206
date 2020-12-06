/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: BwTFEcRvTpTWiE7TEMdXAG0oJESBFWyM
 */
package net.shopxx.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.ApplicationContext;
import org.springframework.util.Assert;
import org.springframework.web.context.support.WebApplicationContextUtils;

import net.shopxx.controller.business.BaseController;
import net.shopxx.controller.business.ExcelController.SkuForm;
import net.shopxx.controller.business.ExcelController.SkuListForm;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.CategoryApplication;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.Product;
import net.shopxx.entity.ProductCategory;
import net.shopxx.entity.ProductFile;
import net.shopxx.entity.ProductImage;
import net.shopxx.entity.ProductParam;
import net.shopxx.entity.Sku;
import net.shopxx.entity.Store;
import net.shopxx.entity.StoreProductCategory;
import net.shopxx.entity.UploadLog;
import net.shopxx.security.CurrentStore;
import net.shopxx.service.CategoryApplicationService;
import net.shopxx.service.DxncsParamService;
import net.shopxx.service.ProductCategoryService;
import net.shopxx.service.ProductParamService;
import net.shopxx.service.ProductService;
import net.shopxx.service.StoreProductCategoryService;
import net.shopxx.service.UploadLogService;

/**
 * Utils - 解压工具类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class ImpotExcel{
	
	/**
	 * 解压zip文件
	 * 
	 * @author 诛仙
	 * @param uploadLogService 日志业务层
	 * @param hostFileBatch 压缩包的路径
	 * @param sourceFile,待解压的zip文件; toFolder,解压后的存放路径
	 * @return 
	 * @throws Exception
	 **/
	public Boolean getDataFromExcel(String state,String hostFileBatch, UploadLogService uploadLogService, ProductService productService,ProductParamService productParamService,DxncsParamService dxncsParamService,ProductCategoryService productCategoryService,String filePath, @CurrentStore Store currentStore, SkuForm skuForm,
			SkuListForm skuListForm,String path,String absPath,StoreProductCategoryService storeProductCategoryService,CategoryApplicationService categoryApplicationService) {

		System.out.println(filePath);
		
		//以压缩包查询日志
		UploadLog uploadLog = new UploadLog();
		uploadLog.setFileUrl(hostFileBatch);
		List<UploadLog> findList = uploadLogService.findList(uploadLog, null);

		// 判断是否为excel类型文件
		if (!filePath.endsWith(".xls") && !filePath.endsWith(".xlsx")) {

			System.out.println("文件不是excel类型");
			if(findList.size()>0) {
				UploadLog findLog = findList.get(0);
				findLog.setFileFlag("2");
				uploadLogService.modify(findLog);
			}
			return false;

		}

		FileInputStream fis = null;
		Workbook wookbook = null;
		int flag = 0;
		int f = 1;

		try {
			// 获取一个绝对地址的流
			fis = new FileInputStream(filePath);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}

		try {
			// 2003版本的excel，用.xls结尾
			wookbook = new HSSFWorkbook(fis);// 得到工作簿

		} catch (Exception ex) {
			// ex.printStackTrace();
			try {
				// 2007版本的excel，用.xlsx结尾
				fis = new FileInputStream(filePath);
				wookbook = new XSSFWorkbook(fis);// 得到工作簿
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} finally {
		}

		// 得到一个工作表
		Sheet sheet = wookbook.getSheetAt(0);

		// 获得表头
		Row rowHead = sheet.getRow(0);
		short lastCellNum = rowHead.getLastCellNum();
		System.out.println(lastCellNum);
		// 根据不同的data放置不同的表头
		Map<Object, Integer> headMap = new HashMap<Object, Integer>();
		int physicalNumberOfCells = rowHead.getPhysicalNumberOfCells();
		System.out.println(physicalNumberOfCells);
		// 判断表头是否正确
		if (rowHead.getPhysicalNumberOfCells() != 53) {
			System.out.println("表头的数量不对!");
			if(findList.size()>0) {
				UploadLog findLog = findList.get(0);
				findLog.setFileFlag("2");
				uploadLogService.modify(findLog);
			}
			return false;
		}
		// 根据表格有多少列
		while (flag <= lastCellNum) {
			Cell cell = rowHead.getCell(flag);
			if (cell == null && "".equals(cell)) {
				f++;
			}
			if (cell != null && !"".equals(cell)) {
				if (getRightTypeCell(cell, null).toString() != null
						&& !"".equals(getRightTypeCell(cell, null).toString())) {
					if (getRightTypeCell(cell, null).toString().equals("编号")) {
						// 对应实体:编号
						headMap.put("sn", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("兼容国外型号厂家")) {
						// 对应实体:检查时间
						headMap.put("JRGWXHname", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代厂家代码")) {
						headMap.put("manufacturer", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代厂家")) {
						headMap.put("cjdwmc", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代型号规格")) {
						headMap.put("cpxh", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代名称")) {
						headMap.put("name", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代质量等级")) {
						headMap.put("zldj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代总规范")) {
						headMap.put("sytygf", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代执行标准")) {
						headMap.put("cpgf", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代封装外形")) {
						headMap.put("fzxs", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代执行标准PDF")) {
						headMap.put("supersedePDF", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代鉴定时间")) {
						headMap.put("appraisalTime", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代供货状态")) {
						headMap.put("furnishingFlag", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("是否采用进口芯片")) {
						headMap.put("isUse", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("替代类型")) {
						headMap.put("replaceType", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("主要差异点")) {
						headMap.put("differences", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("版本")) {
						headMap.put("edition", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("填表人")) {
						headMap.put("filler", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("填表人联系方式")) {
						headMap.put("fillerPhone", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("重量（克）")) {
						headMap.put("weight", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("单位")) {
						headMap.put("unit", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("功能描述")) {
						headMap.put("gnms", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("电性能参数测试条件")) {
						headMap.put("dxncscstj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("电性能参数")) {
						headMap.put("dxncsname", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("工作温度")) {
						headMap.put("gzwd", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("贮存温度")) {
						headMap.put("zcwd", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("ESD")) {
						headMap.put("esd", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("产品手册文件")) {
						headMap.put("cpsc", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("其它环境适应性指标")) {
						headMap.put("QTHJSYXZBname", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("鉴定检验简介")) {
						headMap.put("jdjyjj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("鉴定检验报告文件")) {
						headMap.put("jdjybg", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("应用注意事项")) {
						headMap.put("yyzysx", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("典型应用电路图片")) {
						headMap.put("source", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("结构分析简介")) {
						headMap.put("jgfxjj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("结构分析报告文件")) {
						headMap.put("jgfxbg", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("典型外围配套元器件")) {
						headMap.put("dxwwyqj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("可靠性试验报告文件")) {
						headMap.put("filesource", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("可靠性试验简介")) {
						headMap.put("kkxsyjj", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("参数绝对最大额定值")) {
						headMap.put("CSJDZDEDZname", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("推荐工作参数")) {
						headMap.put("TJGZCSname", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("应用领域")) {
						headMap.put("yyly", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("单位地址")) {
						headMap.put("cjdz", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("单位联系电话")) {
						headMap.put("cjlxfs", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("市场联系人")) {
						headMap.put("sclxr", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("市场联系电话")) {
						headMap.put("sclxfs", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("技术联系人")) {
						headMap.put("jslxr", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("技术联系电话")) {
						headMap.put("jslxfs", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("年供货能力")) {
						headMap.put("nghnl", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("产品介绍")) {
						headMap.put("introduction", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("产品图片")) {
						headMap.put("productsource", flag);
					} else if (getRightTypeCell(cell, null).toString().equals("产品分类")) {
						headMap.put("productCategoryname", flag);
					}else if(getRightTypeCell(cell, null).toString().equals("适用通用规范文件")) {
						headMap.put("sytygfm", flag);
					}else if(getRightTypeCell(cell, null).toString().equals("搜索关键字")) {
						headMap.put("keyword", flag);
					}
				}
			}
			flag++;
		}
		
		

		// 获得数据的总行数
		int totalRowNum = sheet.getLastRowNum();
		// 要获得属性
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		Map<String, String> map  =new HashMap<String, String>();
		
		String[] strArray = new String[totalRowNum];
		try {
			for (int i = 1; i <= totalRowNum; i++) {

				List<ProductImage> productImages = new ArrayList<>();

				List<ProductImage> dxyydlImages = new ArrayList<>();

				List<ProductFile> kkxsybgFiles = new ArrayList<>();

				List<ProductParam> qthjzbParams = new ArrayList<>();

				List<ProductParam> csjdzdParams = new ArrayList<>();

				List<ProductParam> tjgzcsParams = new ArrayList<>();

				List<ProductParam> jrgwParams = new ArrayList<>();

				List<DxncsParam> dxncsParams = new ArrayList<>();

				Product product = new Product();
				product.setType(Product.Type.GENERAL);

				ProductCategory productCategory = new ProductCategory();
				StoreProductCategory storeProductCategory = new StoreProductCategory();
				
				// 获得第i行对象
				Row row = sheet.getRow(i);
				if (null != row) {
					//获取编号
					Cell sn = row.getCell(headMap.get("sn"));
					//以隐藏编号查询数据
					//List<Product> findCopysn = productService.findCopysn(currentStore, TransformCellUtils.getCellValue(sn));
						product.setCopysn(TransformCellUtils.getCellValue(sn));

					Cell JRGWXHname = row.getCell(headMap.get("JRGWXHname"));
					String jrgw = TransformCellUtils.getCellValue(JRGWXHname);
					//分割获取到的字符串
					if(StringUtils.isNotBlank(jrgw)) {
						String jrgws[] = jrgw.split("\\|");
						for(int j=0;j<jrgws.length;j++) {
							ProductParam productParam = new ProductParam();
							String[] split = jrgws[j].split(",", 7);
							
							if(split.length == 1) {
								productParam.setName(split[0]);
							}else if(split.length == 2) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
							}else if(split.length == 3) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
								
								productParam.setValue2(split[2]);
							}else if(split.length == 4) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
								
								productParam.setValue2(split[2]);
								productParam.setValue4(split[3]);
							}else if(split.length == 5) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
								
								productParam.setValue2(split[2]);
								productParam.setValue4(split[3]);
								productParam.setValue5(split[4]);
							}else if(split.length == 6) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
								
								productParam.setValue2(split[2]);
								productParam.setValue4(split[3]);
								productParam.setValue5(split[4]);
								productParam.setValue3(split[5]);
							}else if(split.length == 7) {
								productParam.setName(split[0]);
								productParam.setValue1(split[1]);
								
								productParam.setValue2(split[2]);
								productParam.setValue4(split[3]);
								productParam.setValue5(split[4]);
								productParam.setValue3(split[5]);
								productParam.setUnit(split[6]);
							}
							
							jrgwParams.add(productParam);
						}
					}

					Cell manufacturer = row.getCell(headMap.get("manufacturer"));
					product.setManufacturer(TransformCellUtils.getCellValue(manufacturer));

					Cell cjdwmc = row.getCell(headMap.get("cjdwmc"));
					product.setCjdwmc(TransformCellUtils.getCellValue(cjdwmc));

					Cell cpxh = row.getCell(headMap.get("cpxh"));
					product.setCpxh(TransformCellUtils.getCellValue(cpxh));

					Cell name = row.getCell(headMap.get("name"));
					product.setName(TransformCellUtils.getCellValue(name));

					Cell zldj = row.getCell(headMap.get("zldj"));
					product.setZldj(TransformCellUtils.getCellValue(zldj));

					Cell sytygf = row.getCell(headMap.get("sytygf"));
					product.setSytygfm(TransformCellUtils.getCellValue(sytygf));

					Cell cpgf = row.getCell(headMap.get("cpgf"));
					product.setCpgf(TransformCellUtils.getCellValue(cpgf));

					Cell fzxs = row.getCell(headMap.get("fzxs"));
					product.setFzxs(TransformCellUtils.getCellValue(fzxs));

					Cell supersedePDF = row.getCell(headMap.get("supersedePDF"));
					product.setSupersedePDF(absPath + TransformCellUtils.getCellValue(supersedePDF));

					Cell appraisalTime = row.getCell(headMap.get("appraisalTime"));
					Date parse = new Date();
					try {
						parse = formatter.parse(TransformCellUtils.getCellValue(appraisalTime));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					product.setAppraisalTime(parse);

					Cell furnishingFlag = row.getCell(headMap.get("furnishingFlag"));
					product.setFurnishingFlag(TransformCellUtils.getCellValue(furnishingFlag));

					Cell isUse = row.getCell(headMap.get("isUse"));
					product.setIsUse(TransformCellUtils.getCellValue(isUse));

					Cell replaceType = row.getCell(headMap.get("replaceType"));
					product.setReplaceType(TransformCellUtils.getCellValue(replaceType));

					Cell differences = row.getCell(headMap.get("differences"));
					product.setDifferences(TransformCellUtils.getCellValue(differences));

					Cell edition = row.getCell(headMap.get("edition"));
					product.setEdition(TransformCellUtils.getCellValue(edition));

					Cell filler = row.getCell(headMap.get("filler"));
					product.setFiller(TransformCellUtils.getCellValue(filler));

					Cell fillerPhone = row.getCell(headMap.get("fillerPhone"));
					product.setFillerPhone(TransformCellUtils.getCellValue(fillerPhone));

					Cell weight = row.getCell(headMap.get("weight"));
					
					if(StringUtils.isNotEmpty(TransformCellUtils.getCellValue(weight))) {
						product.setWeight(Integer.parseInt(TransformCellUtils.getCellValue(weight)));
					}else {
						product.setWeight(0);
					}

					Cell unit = row.getCell(headMap.get("unit"));
					product.setUnit(TransformCellUtils.getCellValue(unit));

					Cell gnms = row.getCell(headMap.get("gnms"));
					product.setGnms(TransformCellUtils.getCellValue(gnms));

					Cell dxncscstj = row.getCell(headMap.get("dxncscstj"));
					product.setDxncscstj(TransformCellUtils.getCellValue(dxncscstj));

					Cell dxncsname = row.getCell(headMap.get("dxncsname"));
					
					//电性能参数 1，2，3，4，5|1，2，3，4，5
					String dxncs = TransformCellUtils.getCellValue(dxncsname);
					if(StringUtils.isNotBlank(dxncs)) {
						String dxncss[] = dxncs.split("\\|");
						for(int j=0;j<dxncss.length;j++) {
							DxncsParam dxncsParam = new DxncsParam();
							//获取单个电性能参数1，2，3，4，5
							String str = dxncss[j];
							//分割字符串获取参数名，最大值，最小值，额定值
							String[] split = str.split(",", 5);
							
							if(split.length == 1) {
								dxncsParam.setName(split[0]);
							}else if(split.length == 2) {
								dxncsParam.setName(split[0]);
								dxncsParam.setMin(split[1]);
							}else if(split.length == 3) {
								dxncsParam.setName(split[0]);
								dxncsParam.setMin(split[1]);
								dxncsParam.setTyp(split[2]);
							}else if(split.length == 4) {
								dxncsParam.setName(split[0]);
								dxncsParam.setMin(split[1]);
								dxncsParam.setTyp(split[2]);
								dxncsParam.setMax(split[3]);
							}else if(split.length == 5) {
								dxncsParam.setName(split[0]);
								dxncsParam.setMin(split[1]);
								dxncsParam.setTyp(split[2]);
								dxncsParam.setMax(split[3]);
								dxncsParam.setUnit(split[4]);
							}
							dxncsParams.add(dxncsParam);
						}
					}

					Cell gzwd = row.getCell(headMap.get("gzwd"));
					product.setGzwd(TransformCellUtils.getCellValue(gzwd));

					Cell zcwd = row.getCell(headMap.get("zcwd"));
					product.setZcwd(TransformCellUtils.getCellValue(zcwd));

					Cell esd = row.getCell(headMap.get("esd"));
					product.setEsd(TransformCellUtils.getCellValue(esd));

					Cell cpsc = row.getCell(headMap.get("cpsc"));
					product.setCpsc(absPath + TransformCellUtils.getCellValue(cpsc));

					Cell QTHJSYXZBname = row.getCell(headMap.get("QTHJSYXZBname"));
					String qthjzb = TransformCellUtils.getCellValue(QTHJSYXZBname);
					if(StringUtils.isNotBlank(qthjzb)) {
						String[] qthjzbs = qthjzb.split("\\|");
						for(int j=0;j<qthjzbs.length;j++) {
							ProductParam qthjzbParam = new ProductParam();
							String str = qthjzbs[j];
							String[] split = str.split(",", 5);
							if(split.length == 1) {
								qthjzbParam.setName(split[0]);
							}else if(split.length == 2) {
								qthjzbParam.setName(split[0]);
								qthjzbParam.setValue2(split[1]);
							}else if(split.length == 3) {
								qthjzbParam.setName(split[0]);
								qthjzbParam.setValue2(split[1]);
								qthjzbParam.setValue1(split[2]);
							}else if(split.length == 4) {
								qthjzbParam.setName(split[0]);
								qthjzbParam.setValue2(split[1]);
								qthjzbParam.setValue1(split[2]);
								qthjzbParam.setValue3(split[3]);
							}else if(split.length == 5) {
								qthjzbParam.setName(split[0]);
								qthjzbParam.setValue2(split[1]);
								qthjzbParam.setValue1(split[2]);
								qthjzbParam.setValue3(split[3]);
								qthjzbParam.setUnit(split[4]);
							}
							qthjzbParams.add(qthjzbParam);
						}
					}

					Cell jdjyjj = row.getCell(headMap.get("jdjyjj"));
					product.setJdjyjj(TransformCellUtils.getCellValue(jdjyjj));

					Cell jdjybg = row.getCell(headMap.get("jdjybg"));
					if(StringUtils.isNotEmpty(TransformCellUtils.getCellValue(jdjybg))) {
						product.setJdjybg(absPath + TransformCellUtils.getCellValue(jdjybg));
					}else {
						product.setJdjybg(TransformCellUtils.getCellValue(jdjybg));
					}
					

					Cell yyzysx = row.getCell(headMap.get("yyzysx"));
					product.setYyzysx(TransformCellUtils.getCellValue(yyzysx));

					Cell source = row.getCell(headMap.get("source"));
					String imageSource = TransformCellUtils.getCellValue(source);
					if(StringUtils.isNotEmpty(imageSource)) {
						String[] sourceSplit = imageSource.split(",");
						for(int j = 0;j<sourceSplit.length;j++) {
							//典型电路图片
							ProductImage dxyydlImage = new ProductImage();
							String str = sourceSplit[j];
							
							dxyydlImage.setSource(absPath + str);
							dxyydlImage.setLarge(absPath + str);
							dxyydlImage.setThumbnail(absPath + str);
							dxyydlImage.setMedium(absPath + str);
							
							dxyydlImages.add(dxyydlImage);
						}
					}

					Cell jgfxjj = row.getCell(headMap.get("jgfxjj"));
					product.setJgfxjj(TransformCellUtils.getCellValue(jgfxjj));

					Cell jgfxbg = row.getCell(headMap.get("jgfxbg"));
					if(StringUtils.isNotEmpty(TransformCellUtils.getCellValue(jgfxbg))) {
						product.setJgfxbg(absPath + TransformCellUtils.getCellValue(jgfxbg));
					}else {
						product.setJgfxbg(TransformCellUtils.getCellValue(jgfxbg));
					}
					

					Cell dxwwyqj = row.getCell(headMap.get("dxwwyqj"));
					product.setDxwwyqj(TransformCellUtils.getCellValue(dxwwyqj));

					Cell filesource = row.getCell(headMap.get("filesource"));
					String filesImg = TransformCellUtils.getCellValue(filesource);
					if(StringUtils.isNotEmpty(filesImg)) {
						String[] filesSplit = filesImg.split(",");
						
						for(int j=0;j<filesSplit.length;j++) {
							ProductFile kkxsybgFile = new ProductFile();

							String str = filesSplit[0];
							
							kkxsybgFile.setSource(absPath + str);
							
							kkxsybgFiles.add(kkxsybgFile);
						}
					}
					
					Cell kkxsyjj = row.getCell(headMap.get("kkxsyjj"));
					product.setKkxsyjj(TransformCellUtils.getCellValue(kkxsyjj));

					Cell CSJDZDEDZname = row.getCell(headMap.get("CSJDZDEDZname"));
					String CSJDZDED = TransformCellUtils.getCellValue(CSJDZDEDZname);
					if(StringUtils.isNotBlank(CSJDZDED)) {
						String[] CSJDZDEDs = CSJDZDED.split("\\|");
						for(int j=0;j<CSJDZDEDs.length;j++) {
							ProductParam csjdzdParam = new ProductParam();
							String str = CSJDZDEDs[j];
							String[] split = str.split(",", 5);
							
							if(split.length == 1) {
								csjdzdParam.setName(split[0]);
							}else if(split.length == 2) {
								csjdzdParam.setName(split[0]);
								csjdzdParam.setValue2(split[1]);
							}else if(split.length == 3) {
								csjdzdParam.setName(split[0]);
								csjdzdParam.setValue2(split[1]);
								csjdzdParam.setValue1(split[2]);
							}else if(split.length == 4) {
								csjdzdParam.setName(split[0]);
								csjdzdParam.setValue2(split[1]);
								csjdzdParam.setValue1(split[2]);
								csjdzdParam.setValue3(split[3]);
							}else if(split.length == 5) {
								csjdzdParam.setName(split[0]);
								csjdzdParam.setValue2(split[1]);
								csjdzdParam.setValue1(split[2]);
								csjdzdParam.setValue3(split[3]);
								csjdzdParam.setUnit(split[4]);
							}
							csjdzdParams.add(csjdzdParam);
						}
					}

					Cell TJGZCSname = row.getCell(headMap.get("TJGZCSname"));
					
					String TJGZCS = TransformCellUtils.getCellValue(TJGZCSname);
					
					if(StringUtils.isNotBlank(TJGZCS)) {
						
						String[] TJGZCSs = TJGZCS.split("\\|");
						
						for(int j=0;j<TJGZCSs.length;j++) {
							ProductParam tjgzcsParam = new ProductParam();
							String str = TJGZCSs[0];
							String[] split = str.split(",", 5);
							
							if(split.length == 1) {
								tjgzcsParam.setName(split[0]);
							}else if(split.length == 2) {
								tjgzcsParam.setName(split[0]);
								tjgzcsParam.setValue2(split[1]);
							}else if(split.length == 3) {
								tjgzcsParam.setName(split[0]);
								tjgzcsParam.setValue2(split[1]);
								tjgzcsParam.setValue1(split[2]);
							}else if(split.length == 4) {
								tjgzcsParam.setName(split[0]);
								tjgzcsParam.setValue2(split[1]);
								tjgzcsParam.setValue1(split[2]);
								tjgzcsParam.setValue3(split[3]);
							}else if(split.length == 5) {
								tjgzcsParam.setName(split[0]);
								tjgzcsParam.setValue2(split[1]);
								tjgzcsParam.setValue1(split[2]);
								tjgzcsParam.setValue3(split[3]);
								tjgzcsParam.setUnit(split[4]);
							}
							
							tjgzcsParams.add(tjgzcsParam);
							
						}
					}

					Cell yyly = row.getCell(headMap.get("yyly"));
					product.setYyly(TransformCellUtils.getCellValue(yyly));

					Cell cjdz = row.getCell(headMap.get("cjdz"));
					product.setCjdz(TransformCellUtils.getCellValue(cjdz));

					Cell cjlxfs = row.getCell(headMap.get("cjlxfs"));
					product.setCjlxfs(TransformCellUtils.getCellValue(cjlxfs));

					Cell sclxr = row.getCell(headMap.get("sclxr"));
					product.setSclxr(TransformCellUtils.getCellValue(sclxr));

					Cell sclxfs = row.getCell(headMap.get("sclxfs"));
					product.setSclxfs(TransformCellUtils.getCellValue(sclxfs));

					Cell jslxr = row.getCell(headMap.get("jslxr"));
					product.setJslxr(TransformCellUtils.getCellValue(jslxr));

					Cell jslxfs = row.getCell(headMap.get("jslxfs"));
					product.setJslxfs(TransformCellUtils.getCellValue(jslxfs));

					Cell nghnl = row.getCell(headMap.get("nghnl"));
					product.setNghnl(TransformCellUtils.getCellValue(nghnl));

					Cell introduction = row.getCell(headMap.get("introduction"));
					product.setIntroduction(TransformCellUtils.getCellValue(introduction));
					
					Cell sytygfm = row.getCell(headMap.get("sytygfm"));
					product.setSytygf(TransformCellUtils.getCellValue(sytygfm));

					Cell productsource = row.getCell(headMap.get("productsource"));
					//商品图片
					String productImg = TransformCellUtils.getCellValue(productsource);
					if(StringUtils.isNotEmpty(productImg)) {
						String[] split = productImg.split(",");
						
						for(int j=0;j<split.length;j++) {
							ProductImage productImage = new ProductImage();
							String str = split[j];
							productImage.setSource(absPath + str);
							productImage.setLarge(absPath + str);
							productImage.setMedium(absPath + str);
							productImage.setThumbnail(absPath + str);
							
							productImages.add(productImage);
							
						}
					}

					Cell productCategoryname = row.getCell(headMap.get("productCategoryname"));
					productCategory.setName(TransformCellUtils.getCellValue(productCategoryname));
					storeProductCategory.setName(TransformCellUtils.getCellValue(productCategoryname));
					
					Cell keyword = row.getCell(headMap.get("keyword"));
					product.setKeyword(TransformCellUtils.getCellValue(keyword));
					
					List<ProductCategory> findname = productCategoryService.findname(productCategory, currentStore, true, null);
					
					if (findname.size() <= 0) {
						//以名称获取分类
						findname = productCategoryService.findname(productCategory, null, true, null);
						ProductCategory productCategory2 = findname.get(0);
						
						CategoryApplication categoryApplication = new CategoryApplication();
						categoryApplication.setStatus(CategoryApplication.Status.APPROVED);
						categoryApplication.setRate(Store.Type.GENERAL.equals(currentStore.getType()) ? findname.get(0).getGeneralRate() : findname.get(0).getSelfRate());
						categoryApplication.setStore(currentStore);
						categoryApplication.setProductCategory(productCategory2);
						categoryApplicationService.save(categoryApplication);
						categoryApplicationService.review1(currentStore, findname.get(0));
						
						///保存厂家产品分类
						storeProductCategory.setStore(currentStore);
						StoreProductCategory saveStoreProductCategory = storeProductCategoryService.saveStoreProductCategory(findname.get(0), storeProductCategory);
						
						if(null == saveStoreProductCategory) {
							List<StoreProductCategory> findName = storeProductCategoryService.findName(storeProductCategory,null);
							if(findName.size()>0) {
								product.setStoreProductCategory(findName.get(0));
							}
						}else {
							product.setStoreProductCategory(saveStoreProductCategory);
						}
					}
					
					product.setProductCategory(findname.get(0));
					
					Long productCount = productService.count(null, currentStore, null, null, null, null, null, null);
					product.setCount(productCount);
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
					boolean snExists = productService.snExists(currentStore.getNumber() + "-" + findname.get(0).getNumber() + "-" + number);
					if(snExists) {
						//获取本分类中最新产品
						List<Product> findList2 = productService.findList(null, currentStore, findname.get(0), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
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
						
						product.setSn(currentStore.getNumber() + "-" + findname.get(0).getNumber() + "-" + str);
						
					}else {
						product.setSn(currentStore.getNumber() + "-" + findname.get(0).getNumber() + "-" + number);
					}
					
					// 厂家编码（6位）-产品分类编码（6位）- 产品数

					product.setMarketPrice(new BigDecimal(0));

					product.setMaxCommission(new BigDecimal(0));

					product.setPrice(new BigDecimal(0));

					product.setStore(currentStore);
					product.setIsFine(false);
					product.setIsHot(false);
					product.setHits(0L);
					product.setIsDelivery(true);
					product.setIsList(true);
					product.setIsTop(false);
					product.setIsMarketable(true);
					product.setScore(0F);
					product.setTotalScore(0l);
					product.setScoreCount(0L);
					product.setWeekHits(0L);
					product.setMonthHits(0L);
					product.setWeekSales(0L);
					product.setMonthSales(0L);
					product.setSales(0L);
					product.setWeekHitsDate(new Date());
					product.setMonthHitsDate(new Date());
					product.setWeekSalesDate(new Date());
					product.setMonthSalesDate(new Date());
					product.setProductImages(productImages);
					product.setKkxsybgFiles(kkxsybgFiles);
					product.setDxyydlImages(dxyydlImages);
					product.setIsSample(true);
					product.setIsbzverify(false);
					product.setIstjverify(false);
					product.setIsverify(false);
					product.setIsbzverify(false);
					
					//判断重复
					List<Product> isfindList = productService.isfindList(currentStore, findname.get(0), product.getName(), product.getCpxh(),product.getFzxs(),product.getZldj());
					
					if(isfindList.size()>0) {
						
						if(StringUtils.isNotEmpty(state) && state.equals("1")) {
							//强制覆盖
							Product product2 = isfindList.get(0);
							//先删除数据在新增
							productService.delete(product2.getId());
						}else {
							continue;
						}
					}
					

					if (product.hasSpecification()) {
						List<Sku> skus = skuListForm.getSkuList();
						productService.create(product, skus);
					} else {
						Sku sku = new Sku();
						sku.setPrice(new BigDecimal(0));
						sku.setStock(99999);
						sku.setIsDefault(false);
						sku.setMaxCommission(product.getMaxCommission());
						productService.create(product, sku);
					}
					dxncsParamService.save(product.getId(), dxncsParams);
					productParamService.save(product.getId(), qthjzbParams, ProductParam.Type.QTHJSYXZB);
					productParamService.save(product.getId(), csjdzdParams, ProductParam.Type.CSJDZDEDZ);
					productParamService.save(product.getId(), tjgzcsParams, ProductParam.Type.TJGZCS);
					productParamService.save(product.getId(), jrgwParams, ProductParam.Type.JRGWXH);
					
					//map.put(String.valueOf(i+1), TransformCellUtils.getCellValue(sn)+"--"+"成功");
					//strArray[i]="成功";
				}
				
			}
			if(findList.size()>0) {
				UploadLog findLog = findList.get(0);
				//更新状态
				findLog.setFileFlag("1");
				//更新日志
				uploadLogService.modify(findLog);
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			if(findList.size()>0) {
				UploadLog findLog = findList.get(0);
				//更新状态
				findLog.setFileFlag("2");
				//更新日志
				uploadLogService.modify(findLog);
				
			}
		}
		
		//ExcelUtils.createExcel(map, strArray);
		return true;
	}
	
	public static Object getRightTypeCell(Cell cell, String what) {
		Object object = null;
		if (cell != null && !"".equals(cell)) {
			switch (cell.getCellTypeEnum()) {
			case STRING:
				object = cell.getRichStringCellValue().getString();
				break;
			case NUMERIC:
				if ("checkDate".equals(what)) {
					Instant instant = cell.getDateCellValue().toInstant();
					ZoneId zone = ZoneId.systemDefault();
					object = LocalDateTime.ofInstant(instant, zone);
				} else {
					object = cell.getNumericCellValue();
					if (object instanceof Double) {
						object = String.valueOf(object);
					}
				}
				break;
			case BOOLEAN:
				object = cell.getBooleanCellValue();
				break;
			case BLANK:
				object = "";
				break;
			default:
				object = cell.toString();
				break;
			}
		}
		return object;
	}
	/**
	 * 根据类型获取验证组
	 * 
	 * @param type 类型
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
}